class CertificationTest < ActiveRecord::Base
  ACCEPTANCE_THRESHOLD = 1
  
  belongs_to :certification_video
  belongs_to :user
  has_many :certification_test_tags
  delegate :certification, :to => :certification_video
  delegate :video, :to => :certification_video
  
  def tags
    self.certification_test_tags
  end
  
  def score
    expected_tags = self.certification_video.tags
    submitted_tags = self.tags
    
    total = expected_tags.length * 2
    points = 0.0

    expected_start_times = expected_tags.map { |t| t.start_time }
    expected_end_times = expected_tags.map { |t| t.end_time }
    submitted_start_times = submitted_tags.map { |t| t.start_time }
    submitted_end_times = submitted_tags.map { |t| t.end_time }
    
    [[expected_start_times, submitted_start_times], [expected_end_times, submitted_end_times]].each do |exp, sub|
      exp.each_index do |i|
        #puts "comparing expected #{exp[i]}"
        match = sub.index { |t| (t-exp[i]).abs <= ACCEPTANCE_THRESHOLD }
        if match.nil? then
          #puts "no match"
          points -= 1
        else
          #puts "found match #{sub[match]}"
          sub.delete_at match
          points += 1
        end
      end       
    end
    
    #puts "correct tags: #{points}"
    points -= submitted_start_times.length + submitted_end_times.length
    #puts "after considering incorrect tags: #{points}"
        
    [0, points/total*100].max
    
  end
end
