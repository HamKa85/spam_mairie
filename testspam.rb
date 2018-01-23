require 'mail'
require 'gmail'
require 'gmail_xoauth'
#gmail.logged_in?

gmail = Gmail.connect("login", "mdp") do |gmail|
end

gmail.deliver do
  to "karouihamza@hotmail.com"
  subject "Having fun in THP!"
  text_part do
    body "Ca code dure"
  end
  html_part do
    content_type 'text/html; charset=UTF-8'
    body "<p>Text of <em>html</em> message.</p>"
  end
end
