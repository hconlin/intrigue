class ContactMailer < ApplicationMailer

def send_mail(fname, lname, email, body)
  mail(
    to: 'intriguelandscapes@gmail.com',
    from: %("#{fname} #{lname}" <#{email}>),
    subject: "New Email From #{fname} #{lname}",
    body: "Name: #{fname} #{lname}

Email: #{email}

Message: #{body}"
  )
end

end
