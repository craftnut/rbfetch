require 'sys/cpu'
require 'sys-uptime'
require 'colorize'
include Sys

os = RUBY_PLATFORM
logon = ENV['USERNAME']
counter = 1

# define functions for platform specific stuff
def rbfetch_win # Windows-specific functions
    cpu = CPU.model.to_s
	cpu_arch = CPU.architecture.to_s
	cpu_vend = CPU.cpu_type.to_s
	cpu_full = "CPU: ".blue + "#{cpu_arch} #{cpu} \n" +
			"CPU Vendor: ".blue + cpu_vend
    puts cpu_full
end


unless ENV['COMPUTERNAME']
    hostname = ENV['LOGONSERVER']
else
    hostname = ENV['COMPUTERNAME']
end

up_minutes = Uptime.minutes - (Uptime.hours * 60)

puts logon.blue+"@"+hostname.blue
while counter <= (logon+hostname).length
    print "="
    counter += 1
end
puts "="

# Ruby on Windows runs under MINGW, add a note pointing out that MINGW is probably Windows.
unless os.include? "mingw"
    puts "Platform: ".blue + os
else
    puts "Platform: ".blue + "#{os} (probably Windows)"
end


puts "Uptime: ".blue + "#{Uptime.hours} hours, #{up_minutes} minutes"

# Windows-specific stuff
if os.include? "mingw"
    rbfetch_win
end
