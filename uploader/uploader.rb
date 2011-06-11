#!/usr/bin/env ruby
#
#
## Installation notes:
#  - Assumes MacPorts and Xcode are installed.
#  - Installing ffmpeg-ruby:
#     sudo port install ffmpeg
#     sudo env ARCHFLAGS="-arch x86_64" gem install ffmpeg-ruby
#
#  - Installing streamio-ffmpeg:
#     sudo gem install streamio-ffmpeg

require 'rubygems'
require 'ffmpeg-ruby'     # Needed for video detection/conversion.
require 'optparse'        # Needed for argument processing.
require 'optparse/time'   # Needed for easy timestamp argument.
require 'yaml'            # Needed for config file handling.
require 'digest/md5'      # Needed for duplicate checking
require 'open3'           # Needed to get creation date (Mac only)
require 'socket'          # Needed to get the computer name.
require 'etc'             # Needed to get the logged in user's name.
require 'rest_client'     # Required to upload the file to the server.
require 'streamio-ffmpeg' # Required for transcoding
require 'tempfile'        # Needed to create temporary files that are easily removed.
require 'pp'

$version = "COVE Uploader 0.0.2"


# Default options:
options = {
  :project => nil,
  :title => nil,
  :time => nil,
  :creation => nil,
  :offsettime => 0,
  :camera => nil,
  :author => nil,
  :album => nil,
  :locationname => nil,
  :uploadername => nil,
  :comments => nil,
  :offline => false,
  :configfile => nil,
  :verbose => false,
}

optparse = OptionParser.new do|opts|

  opts.on( '-p', '--project=PROJECT', "Project name." ) do |project|
    options[:project] = project
    @project = project
  end

  opts.on( '-t', '--title=TITLE', "Title of file." ) do |title|
    options[:title] = title
    @title = title
  end

  opts.on( '-c', '--creation=TIME', ::Time, "Time of creation." ) do |creation|
    options[:creation] = creation.to_i
    @creation = creation.to_i
  end

  opts.on( '-o', '--offset=SECONDS', ::Float, "Camera clock drift correction. (Seconds)" ) do |offsettime|
    options[:offsettime] = offsettime.to_i
    @offsettime = offsettime.to_i
  end

  opts.on( '-C', '--camera=CAMERANAME', "Camera name." ) do |camera|
    options[:camera] = camera
    @camera = camera
  end  

  opts.on( '-a', '--author=AUTHOR', "Content creator." ) do |author|
    options[:author] = author
    @author = author
  end  

  opts.on( '-A', '--album=ALBUM', "Listed album." ) do |album|
    options[:album] = album
    @album = album
  end  

  opts.on( '-L', '--locationname=LOCATIONNAME', "Human-readable location name." ) do |locationname|
    options[:locationname] = locationname
    @locationname = locationname
  end  

  opts.on( '-U', '--uploadername=UPLOADERNAME', "User and computer that did the uploading." ) do |uploadername|
    options[:uploadername] = uploadername
    @uploadername = uploadername
  end  

  opts.on( '-m', '--comment=COMMENT', "Uploader comments." ) do |comment|
    options[:comment] = comment
    @comment = comment
  end  


  opts.on( '-N', '--offline', "Work with files offline (WIP)." ) do
    options[:offline] = true
    @offline = true
  end  


  # Use YAML config file.
  opts.on("-y", "--configfile PATH", String, "Set YAML config file") do |config_path|
    options.merge(Hash[YAML::load(open(config_path)).map { |k, v| [k.to_sym, v] }])
  end



  # Verbose
  opts.on( '-v', '--verbose', "Verbose." ) do
    options[:verbose] = true
  end

  # Version
  opts.on( '-V', '--version', "Version" ) do
    puts $version
  end

  ## Print help page.
  opts.on( '-h', '--help', 'Display this screen' ) do
    puts opts
    exit
  end

end # End of option set.



## Get creation time (Mac only)
def creation_time(file)
  Time.parse(Open3.popen3("mdls", 
                          "-name",
                          "kMDItemContentCreationDate", 
                          "-raw", file)[1].read)
end


## Automatically detect the uploader.
def auto_uploadername()
  hostname = Socket.gethostname
  username = Etc.getlogin
  @auto_uploadername = username + "@" + hostname
end
@auto_uploadername = auto_uploadername


def analyze_video(filename,stage)

  ##### Skip loop if already cleared.

  puts "Performing pre-conversion analysis..."

  filesize = File.size(filename)
  puts "  File size: " + filesize.to_s + " KB"
  stage == "pre" && @pre_filesize = filesize
  stage == "post" && @post_filesize = filesize
  stage == "skip" && @post_filesize = @pre_filesize

  chksum = Digest::MD5.file(filename)
  puts "  Checksum: " + chksum.to_s if $verbose
  stage == "pre" && @pre_chksum = chksum
  stage == "post" && @post_chksum = chksum
  stage == "skip" && @post_chksum = @pre_chksum

  ### Check if hash already exists with REST query.
  if @offline
    puts "  Offline mode enabled.  Will not check for dupes with server." if $verbose
  else
    if @pre_chksum.to_s != @post_chksum.to_s # If the file hasn't changed, there's no point in checking with the server again.
      #TODO use real serivce to check
      chksum_uri = 'http://rest-test.heroku.com/' + chksum.to_s
      puts "  Submitting checksum check to: " + chksum_uri if $verbose
      dupe_check = RestClient.get(chksum_uri)
      puts "  Checksum submitted to server with reply: " + dupe_check.to_s if $verbose
      puts "  Server reply code: " +dupe_check.code.to_s if $verbose
      ## If duplicate, server will return response code 302.
      if dupe_check.code == 302
        puts "  Warning.  Server reported duplicate.  Will not upload: " + filename
        @suspected_dupe = true
        break
      elsif dupe_check.code == 200 && stage == "pre"
        puts "  Server reported pre-conversion checksum is original."
      elsif dupe_check.code == 200 && stage == "post"
        puts "  Server reported post-conversion checksum is original.  Cleared to upload."
        @suspected_dupe = false
      else
        puts "  Warning. Server response not understood.  Press ENTER to continue..."
        gets
      end
    end
  end

  @mtime = File.new(filename).mtime.to_i
  puts "  Modification time: " + @mtime.to_s if $verbose

  @embed_creation = creation_time(filename).to_i
  puts "  Creation time: " + @embed_creation.to_s if $verbose


  puts "\nFormat Information:" if $verbose
  f = FFMpeg::AVFormatContext.new(filename)

  @duration = f.duration
  puts "  Duration: " + @duration.to_s if $verbose

  @embed_title = f.title
  puts "  Embedded Title: " + @embed_title if $verbose

  @copyright = f.copyright
  puts "  Copyright: " + @copyright if $verbose

  @embed_author = f.author
  puts "  Embedded Author: " + @embed_author if $verbose

  @embed_album = f.album
  puts "  Embedded Album: " + @embed_album if $verbose

  bitrate = f.bit_rate
  puts "  Bit Rate: " + bitrate.to_s if $verbose
  stage == "pre" && @pre_bitrate = bitrate
  stage == "post" && @post_bitrate = bitrate
  stage == "skip" && @post_bitrate = @pre_bitrate  

  ## Stream information: (Not currently used.)
  puts "\nStream information:" if $verbose
  f.streams.each{|s|
    puts "  Canonical Codec: #{s.canonical_codec_name}" if $verbose
    puts "  Codec Long Name: #{s.codec_context.long_name}" if $verbose
  }

  ## Iterate over all the streams in the file, determine Codec Context Information
  f.codec_contexts.each_with_index{|ctx,i|
    puts "\nCodec info for stream ##{i}" if $verbose
    type_id = ctx.codec_type
    puts "  Type ID: " + type_id.to_s if $verbose
    puts "  Type: #{FFMpeg::MAP_CODEC_TYPES[ctx.codec_type]}" if $verbose
    puts "  Long Name: #{ctx.long_name}" if $verbose

    ### We must only declare attributes tied to video when the video stream is being
    ### looped over, otherwise other streams will write it over with irrelevant info
    ### (i.e. audio height, video channels, etcetera).
    #
    ## Collect video-specific codec context info.
    if ctx.codec_type == 0
      vformat = ctx.name
      puts "  Video Format Name: " + vformat if $verbose
      stage == "pre" && @pre_vformat = vformat
      stage == "post" && @post_vformat = vformat
      stage == "skip" && @post_vformat = @pre_vformat

      height = ctx.height
      puts "  Height: " + height.to_s if $verbose
      stage == "pre" && @pre_height = height
      stage == "post" && @post_height = height
      stage == "skip" && @post_height = @pre_height

      width = ctx.width
      puts "  Width: " + width.to_s if $verbose
      stage == "pre" && @pre_width = width
      stage == "post" && @post_width = width
      stage == "skip" && @post_width = @pre_width

      ## Collect audio-specific codec context info.
    elsif ctx.codec_type == 1
      aformat = ctx.name
      puts "  Audio Format Name: " + aformat if $verbose
      stage == "pre" && @pre_aformat = aformat
      stage == "post" && @post_aformat = aformat
      stage == "skip" && @post_aformat = @pre_aformat

      audio_channels = ctx.channels
      puts "  Audio Channels: " + audio_channels.to_s if $verbose
      stage == "pre" && @pre_achannels = audio_channels
      stage == "post" && @post_achannels = audio_channels
      stage == "skip" && @post_achannels = @pre_achannels

      audio_samplerate = ctx.sample_rate
      puts "  Audio Sample Rate: " + audio_samplerate.to_s if $verbose
      stage == "pre" && @pre_samplerate = audio_samplerate
      stage == "post" && @post_samplerate = audio_samplerate
      stage == "skip" && @post_samplerate = @pre_samplerate
    end


    ## Ensure the file uses the expected codec.
    if ctx.codec_type == 0 
      ctx.name != "h264" && @valid_videotype = false
      #bitrate != "300000" && @valid_videotype = false
    elsif ctx.codec_type == 1
      ctx.name != "aac" && @valid_audiotype = false
    end


  }

  ## Respond whether or not the file needs conversion.
  if @valid_videotype == false || @valid_audiotype == false
    @needs_conversion = true
    puts "Needs conversion!"
  elsif @valid_videotype == false && @valid_audiotype == false
    puts "Unrecognized media type!"
  else
    @needs_conversion = false
    puts "No conversion needed."
  end

  puts "\n-- Now dumping the format:"  if $verbose
  f.dump_format if $verbose

end


# Parse the command-line.
optparse.parse!

def uploadfile(filename)



RestClient.post('http://chai.ucsd.edu:8000/videos', :video => { 
  
  :video_up => File.new(filename)


})

# RestClient.post 'http://localhost:3000/videos',
#   File.read(filename),
#   :content_type => 'video/mp4',
#   :project => '@project',
#   :embed_creation => '@embed_creation',
#   :creation => '@creation',
#   :uploaddate => '@uploaddate',
#   :camera => '@camera',
#   :title => '@title',
#   :embed_title => '@embed_title',
#   :copyright => '@copyright',
#   :author => '@author',
#   :embed_author => '@embed_author',
#   :album => '@album',
#   :embed_album => '@embed_album',
#   :timeoffset => '@timeoffset',
#   :locationname => '@locationname',
#   :filepath => filename,
#   :uploadername => '@uploadername',
#   :auto_uploadername => '@auto_uploadername',
#   :mtime => '@mtime',
#   :pre_chksum => '@pre_chksum',
#   :post_chksum => '@post_chksum', 
#   :pre_vformat => '@pre_vformat',
#   :post_vformat => '@post_vformat',
#   :pre_aformat => '@pre_aformat',
#   :post_aformat => '@post_aformat',
#   :pre_bitrate => '@pre_bitrate',
#   :post_bitrate => '@post_bitrate',
#   :pre_height => '@pre_height',
#   :post_height => '@post_height',
#   :pre_width => '@pre_width',
#   :post_width => '@post_width',
#   :pre_filetype => '@pre_filetype',
#   :post_filetype => '@post_filetype',
#   :pre_fps => '@pre_fps',
#   :post_fps => '@post_fps',
#   :pre_filesize => '@pre_filesize',
#   :post_filesize => '@post_filesize',
#   :pre_achannels => '@pre_achannels',
#   :post_achannels => '@post_achannels',
#   :pre_samplerate => '@pre_samplerate',
#   :post_samplerate => '@post_samplerate',
#   :duration => '@duration',
#   :comments => '@comments'

end

# Check verbose status so that we can conditionally print with: puts [x] if verbose
$verbose = options[:verbose]

pp "Options:", options if $verbose
pp "ARGV:", ARGV if $verbose


# Iterate over each file
ARGV.each do|filename|

  puts "\n--> Iterating over file: " + filename

  # First pass, metadata collection (pre-conversion)
  analyze_video(filename,"pre")

  if @needs_conversion == true
    puts 'CONVERTING'
    # Now that the file has been converted, make it  the new target

    movie = FFMPEG::Movie.new(filename)
    destination_dir="/tmp/cove_conversion/" # Trailing slash required.
    File.directory?(destination_dir) || Dir.mkdir(destination_dir)
    converted_filename = destination_dir + @pre_chksum.to_s + ".mp4"
    puts "Converted filename: " + converted_filename if $verbose

    ## Works by magic.
    movie_options = {:video_codec => "libx264", :audio_codec => "libfaac", :custom => "-crf 28 -threads 0 -flags +loop -cmp +chroma -deblockalpha -1 -deblockbeta -1 -refs 3 -bf 3 -coder 1 -me_method hex -me_range 18 -subq 7 -partitions +parti4x4+parti8x8+partp8x8+partb8x8 -g 320 -keyint_min 25 -level 41 -qmin 10 -qmax 51 -qcomp 0.7 -trellis 1 -sc_threshold 40 -i_qfactor 0.71 -flags2 +mixed_refs+dct8x8+wpred+bpyramid -padcolor 000000 -padtop 0 -padbottom 0 -padleft 0 -padright 0 -ab 80kb -ar 48000 -ac 2"}
    movie.transcode(converted_filename,movie_options) { |progress| puts progress }

    # Now gather info post-conversion.
    filename = converted_filename

    # Second pass, metadata collection (post-conversion)
    analyze_video(filename,"post")
  elsif @needs_conversion == false  # Video is already in the correct format. 
    # Skip redudant steps of the second pass.
    analyze_video(filename,"skip")
  end

  ## Upload video to server.
  @uploaddate = Time.now.to_i

  puts "Duplicate #{@suspected_dupe}"
  puts "Offline #{@offline}"
  puts "Conditional #{@suspected_dupe == false and @offline == false}"

  #TODO Trace the logic
 # if @suspected_dupe == false and @offline == false
    puts 'WE ARE UPLOADING KTHX'
    uploadfile(filename)
 # end

end
