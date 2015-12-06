class QuestionMailer < ActionMailer::Base
  default from: 'notifications@example.com'
 
  def report(email,count)
    @count = count
    mail(to: email, subject: 'Questions Added')
  end
end