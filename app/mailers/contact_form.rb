class ContactForm < MailForm::Base
  attributes :name,  :validate => true
  attributes :email, :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attributes :message,
  attributes :reason,
  attribute :nickname,  :captcha  => true

  def headers
    {
        :subject => "Your subject",
        :to => ENV["MY_EMAIL"],
        :from => %("#{name}" <#{email}>)
    }
  end
end