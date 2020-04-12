DEFAULTS = [

    ##
    # HOME PAGE
    #
    { key: 'home_page_title',                           value: 'AEROBIC CALISTHENICS FITNESS GUIDE' },
    { key: 'home_page_sub_title',                       value: 'SKILLS PROGRESSIONS EFFECTIVE SPECIFIC MUSCLE CONDITIONING WORKOUT PROGRAMS' },
    { key: 'home_page_introduction_video_title',        value: 'INTRODUCTION VIDEO' },
    { key: 'home_page_introduction_video_sub_title',    value: 'PLEASE WATCH MY INTRODUCTION VIDEO' },
    { key: 'home_page_introduction_video_url',          value: 'https://www.youtube.com/embed/EdigyOt4m_g' },
    { key: 'home_page_workouts_title',                  value: 'WORKOUTS' },
    { key: 'home_page_workouts_sub_title',              value: 'ADD SOME TEXT HERE TO EXPLAIN WHAT WORKOUTS ARE' },
    { key: 'home_page_tutorials_title',                 value: 'TUTORIALS' },
    { key: 'home_page_tutorials_sub_title',             value: 'ADD SOME TEXT HERE TO EXPLAIN WHAT TUTORIALS ARE' },
    { key: 'home_page_blogs_title',                     value: 'BLOGS' },
    { key: 'home_page_blogs_sub_title',                 value: 'MY LATEST BLOGS, UPDATE ME' },
    { key: 'home_page_contact_block',                   value: 'WHETHER YOU HAVE A QUESTION ABOUT PERSONAL TRAINING, TUTORIALS, WORKOUTS, OR ANYTHING ELSE, I AM READY TO ANSWER ALL YOUR QUESTIONS' },
    { key: 'home_page_html_title',                      value: 'Aermotion Home Page'},
    { key: 'home_page_html_keys',                       value: 'Aermotion, Tutorials, Personal Training, Couching' },

    ##
    # WORKOUTS PAGE
    #
    { key: 'workouts_page_title',                       value: 'Workout Sets' },
    { key: 'workouts_page_sub_title',                   value: 'This book is a treatise on the theory of ethics, very popular' },
    { key: 'workouts_page_video_url',                   value: 'https://www.youtube.com/embed/EdigyOt4m_g' },
    { key: 'workouts_page_info_block',                  value: 'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.' },

]

class SiteConfiguration < ApplicationRecord
  def self.ensure_created
    DEFAULTS.each do |setting|
      self.record_default(setting) if self.where(key: setting[:key]).empty?
    end
  end

  def self.record_default(setting)
    record = self.new(key: setting[:key], value: setting[:value])
    record.save!
  end


  # Ensure all the defaults are created when the class file is read
  self.ensure_created
end