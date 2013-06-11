#Example: /app/jobs/myjob.rb

module MyJob
  @queue = :default
  def self.perform(response, authentication)
   	puts "Doing my job"
    require 'net/http'

    message = response.merge!(authentication)
    header = {'X-CSRF-Token' => authentication[:authenticity_token]}
    @host = 'localhost'
    @port = '3000'

    @path = "/responses"

    @body = ActiveSupport::JSON.encode(message)

    p @body

    request = Net::HTTP::Post.new(@path, initheader = {'Content-Type' =>'application/json'})
    request.body = @body
    response = Net::HTTP.new(@host, @port, header).start {|http| http.request(request) }
    puts "Response #{response.code} #{response.message}: #{response.body}"
  end
end
