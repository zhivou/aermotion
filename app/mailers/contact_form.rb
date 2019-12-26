class ContactForm < MailForm::Base
  attributes :name,  :validate => true
  attributes :email, :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attributes :message
  attribute :nickname,  :captcha  => true

  def headers
    {
        :subject => "AERMOTION WEB FORM:",
        :to => ENV["MY_EMAIL"], #TODO Upadate ENV in heroku server!
        :from => %("#{name}" <#{email}>)
    }
  end
end