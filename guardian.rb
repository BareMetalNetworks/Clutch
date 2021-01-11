#!/usr/bin/env ruby
require 'logger'
require 'rb-inotify'
require 'thread'



$DIRS = ARGV
$DBG = true


# Send to channel named after the host so we can easily track where alerts came from
# and to selectively follow hosts were interested in, for example.


CHANNEL = `hostname`


#option parser -> config parser too

# http messagehub transport in addition to redis

#
##


begin
	
  file = ARGV[0]
  p file
	#$DIRS.each do |file| ## need to test threaded v. properly before implementing fully
	#	Thread.new do |file|
	hook = INotify::Notifier.new
	hook.watch(file, :create, :delete, :modify, :moved_from) do |event|
	p "changed"
		next if event.nil?
		p "[Guardian] #{Time.now}:Event name: #{event.name} flags:#{event.flags} \n" if $DBG
		
		end
	hook.run
#	end
	# end
rescue => err
	p "[Guardian] #{Time.now} - #{err.inspect} #{err.backtrace}"

end



__END__
#def hook_log_file
## this is the file hook thread
#logHook = Thread.new{
#begin
# open($options[:hookLog]) do |file|
# 	file.seek(0, IO::SEEK_END)
# 	loop do
# 		changes = file.read
# 		unless changes.empty?
# 			p "#{Time.now} #{changes}" if $DEBUG
# 		$logger.info "#{Time.now}: Logged -> #{changes}"
#
# 			$r << changes
# 		end
# 	 sleep 10
# 	end
# end

#rescue => err
#	$logger.info "#{Time.now}: Error #{err.inspect}\n Backtrace #{err.backtrace}"
#	sleep 300
#	retry
#end
#}
#	end



# rescue => err
#	$logger.info "#{Time.now}: #{err.inspect} backtrace: #{err.backtrace}"
 #end


#}

#dirHookEtc.Thread.join

#logHook.Thread.join


__END__
#def hook_log_file
## this is the file hook thread
#logHook = Thread.new{
#begin
# open($options[:hookLog]) do |file|
# 	file.seek(0, IO::SEEK_END)
# 	loop do
# 		changes = file.read
# 		unless changes.empty?
# 			p "#{Time.now} #{changes}" if $DEBUG
# 		$logger.info "#{Time.now}: Logged -> #{changes}"
#
# 			$r << changes
# 		end
# 	 sleep 10
# 	end
# end

#rescue => err
#	$logger.info "#{Time.now}: Error #{err.inspect}\n Backtrace #{err.backtrace}"
#	sleep 300
#	retry
#end
#}
#	end



#dirHookEtc.Thread.join

#logHook.Thread.join

def mailer(events, address, elapsed)
	address.gsub!(/[\W\d]+/)
	`echo #{events} events in #{elapsed} seconds! #{$archive.values.join("\n")} | ssmtp -vvv #{address}`
end
