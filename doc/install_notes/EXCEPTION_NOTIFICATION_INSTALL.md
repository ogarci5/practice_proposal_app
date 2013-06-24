### Exception Notification setup

See: http://smartinez87.github.io/exception_notification/

#### To use with sendmail:

- Install sendmail:

		 $ sudo apt-get install sendmail sendmail-base sendmail-bin sendmail-cf mailutils

- To test:

	 $ sendmail -v [to email]
	 message goes here

	 Then ctrl-d to send. If you're sending from a server without a qualified name, sendmail will hang for about 60 seconds. The '-v' in the command actives verbose mode, useful in the case of failure and to confirm success. Also: check your spam folder at the recipient's side.
	 
- Configure ActionMailer to use sendmail. Put the following code in your config/environments/production.rb and/or config/environments/development.rb:

		config.action_mailer.delivery_method = :sendmail
		# Defaults to:
		# config.action_mailer.sendmail_settings = {
		#   :location => '/usr/sbin/sendmail',
		#   :arguments => '-i -t'
		# }
		config.action_mailer.perform_deliveries = true
		config.action_mailer.raise_delivery_errors = true 

	
