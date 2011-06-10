#PRATIK PRAMANIK IS GOING TO EAT YOUR BRAINS!!!!!!!!!!!! 2/6/2011
#in lib/tasks/
directory "public/videos" #where video will end up

task :default do
  puts "Possible Cmds:"
  puts "   vid_import"
  puts "   sync_db"
end

task :vid_import => "videos" do
  puts "Importing Videos."
  #Chris's code goes here if necessary
    #<alt> Chris's code leaves a flag saying new videos have been imported, prevents this task from running unless new shit is added. something like that. we'll see.
end


task :sync_vid_db => [:environment, "public/videos"] do
  puts "Synchronizing DB."

  #We are working in the public video's folder
  cd "public/videos"
  #1. Grabs DB (intervals [note: dedi video db later])
  puts "DB->files"
  #2. Checks <video> elements for unstandardized video filepaths (videos not in /videos/<ID>/)
  Video.all.each do | itvl |  #"itvl" is a vestage of cove_old, PLEASE GO THROUGH A RENAME
    #3. for Non-conforming elements: Move/Copy files at original filepath to the standardized filepaths (file rename not necessary)
    if itvl.filepath != nil
      #SOME file is associated as a video to this interval
      if File.exists?(itvl.filepath)
        #file exists, mess with it
        if itvl.filepath != "public/videos/"+itvl.id.to_s+"/*"
          filenm = File.basename(itvl.filepath)
          mv itvl.filepath , itvl.id.to_s+"/"+filenm
          #4. Update DB to reflect new file structure
          itvl.filepath = "public/videos/"+itvl.id.to_s+"/"+filenm
          itvl.save
        end
      else
        #doesn't exist, append a comment saying videos are missing
        puts "Video <"+itvl.id.to_s+">: Video is Missing."
        if itvl.comments != nil
          itvl.comments << " Video File is Missing/Non-Existent."
        else
          itvl.comments = " Video File is Missing/Non-Existent."
        end
      end
    else
      #NO file is associated as a video with this interval
      puts "Video <"+itvl.id.to_s+">: No Video File associated."
      if itvl.comments != nil
        #append a comment saying its a videoless
        itvl.comments >> " No Video File associated with Video DB Item."
      else
        #listed interval, but
        puts "Video <"+itvl.id.to_s+">: SIGNIFICANT PROBLEM, All fields are nil, please check Video in 'rails console'"
      end
    end
  end
  #5. Check video folder for videos without a listing in the database
  puts "files->DB"
  files = Dir.glob("*.mp4") #only files with extensions (aka no folders, script files) PROBABLY NEED TO CHECK IF MOVIE FILE!
  files.each do | file |
    #6. Create a new listing in DB
    newfile = Video.new
    newfile.save   #save db item in order to to get an ID value
    #7. videos should be placed in a folder-bucket(name: db ID) if not in a folder already
    newfile.filepath = "public/videos/"+newfile.id.to_s+"/video/"+File.basename(file)
    newfile.name = File.basename(file) #takes the base name of the file as the name of the video for now
    
    #should probably add current time
    #should probably try to grab metadata as well :/
    
    mkdir newfile.id.to_s       #making directory to move file to
    mv file,newfile.id.to_s+"/"+File.basename(file) #move
    newfile.save
  end
end
