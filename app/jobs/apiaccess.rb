#Example: /app/jobs/myjob.rb

module APIAccess
  @queue = :default
  def self.perform(response, authentication)
   	puts "Connecting to PM Mobile to update fields"
    require 'net/http'
    require 'net/https'
    message = response.merge!(authentication)
    #header = {'X-CSRF-Token' => authentication[:authenticity_token]}
    #@host = 'localhost'
    #@port = '3000'
    uri = ""
    if Rails.env.production?
      uri = URI.parse("https://localhost:3000/api")
    else  
      uri = URI.parse("http://localhost:3000/api")
    end
  
    
    #@path = '/responses'
    @body = ActiveSupport::JSON.encode(message)

=begin
    puts @body
    request = Net::HTTP::Post.new(uri.path, initheader = {'Content-Type' =>'application/json',
      'Accept' =>'application/json'})
    p request
    request.body = @body
    #response = Net::HTTP.start(@host, @port) {|http| http.request(request) }
    response = Net::HTTP.new(uri.host, uri.port).start do |http| 
      p http
      http.request(request) 
    end
=end
    

    # see: http://stackoverflow.com/questions/7798926/ruby-blocking-http-new-start-and-dynamic-https
    http = Net::HTTP.new(uri.host, uri.port)
    p http
    
    if uri.scheme =='https'
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    end
    
    http.set_debug_output $stderr

    http.start do |h|
      request = Net::HTTP::Post.new(uri.path, initheader = {'Content-Type' =>'application/json',
        'Accept' =>'application/json'})
      
      request.body = @body
      p uri
      p request
      h.request(request)
    end
    
    #response = HTTParty.post('http://localhost:3000/responses', body: @body, headers: initheader)
    #puts response.body, response.code, response.message, response.headers.inspect
    #puts response.body if response.response_body_permitted?
    #p response
   # Net::HTTP.start(uri.host, uri.port) do |http|
    #  request = Net::HTTP::Get.new uri.request_uri
    
    #  response = http.request request # Net::HTTPResponse object
    #end
   # http = Net::HTTP.new(@host, @port)
   #response = Net::HTTP.post_form(uri, message)
    #request = Net::HTTP::Post.new(@path)
    #request.set_form_data(@body)
    #request["Content-Type"] = "application/json"
    #request["Accept"] = "application/json"
    #response = http.request(request)
    #case response
    #when Net::HTTPSuccess, Net::HTTPRedirection
      # OK
      #else
    #  p response.value
    #end
    #puts response.body
    puts "Response #{response.code} #{response.message}: #{response.body}"
    puts "Sucessfully updated proposal"
=begin
      # Convert the parameters into JSON and set the content type as application/json
      req = Net::HTTP::Post.new(@path)
      req.body = @body
      req["Content-Type"] = "application/json"
      req["X-CSRF-Token"] = authentication[:authenticity_token]
      http = Net::HTTP.new(@host, @port)
      response = http.start {|htt| htt.request(req)}

      puts "Response #{response.code} #{response.message}: #{response.body}"
=end
      #request = Net::HTTP::Post.new(@path, initheader = {'Content-Type' =>'application/json'})
      #request.set_form_data(@body)
      #request.add_field("X-CSRF-Token", authentication[:authenticity_token])
      #response = Net::HTTP.new(@host, @port).start {|http| http.request(request) }
  end
end
