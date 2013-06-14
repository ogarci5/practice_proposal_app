module MailGun
  @queue = :default
  def self.perform(email, proposal)
    require 'net/https'
    puts "Sending email request to Mailgun"
    time = Time.new(proposal["updated_at"])
    RestClient.post("https://api:key-8v5-zria2m3i4j--kh28id4inoszp378"\
      "@api.mailgun.net/v2/oliver.garcia.mailgun.org/messages",
      :from => "Oliver Garcia <admin@oliver.garcia.mailgun.org>",
      :to => email,
      :subject => "Reponse to Proposal - #{proposal["name"]}",
      :text => "You have received a response to your proposal. \n"+
        "Reponse: #{proposal["response"]}\n"+ 
        "Time: #{time.strftime('%m/%d/%Y at %I:%M %p')}"){|response, request, result| puts response }
    #uri = URI.parse("https://api:key-8v5-zria2m3i4j--kh28id4inoszp378@api.mailgun.net/v2/oliver.garcia.mailgun.org/messages")
    #request = Net::HTTP::Post.new(uri.path)
    #request.use_ssl = true
    #request.body = { :from => "Oliver Garcia <admin@@oliver.garcia.mailgun.org>",
    #  :to => "ogarci5@gmail.com",
    #  :subject => "Hello",
    #  :text => "Testing some Mailgun awesomness!\n#{message}" }
    #puts request
    #response = Net::HTTP.start(uri.host, uri.port) {|http| http.request(request) }
    #puts response.code, response.status, response.body
  end
end
