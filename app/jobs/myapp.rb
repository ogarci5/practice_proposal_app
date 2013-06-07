#Example: /app/jobs/myjob.rb

module MyJob
  @queue = :default
  def self.perform(params)
   	puts "Doing my job"
	puts params
  end
end
