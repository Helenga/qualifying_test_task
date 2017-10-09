require 'socket'

socket1 = TCPServer.open("localhost", 5001)
socket2 = TCPServer.open("localhost", 5002)

connect1 = socket1.accept
connect2 = socket2.accept

file = File.open("output.txt", 'w')

loop do
	t1 = Thread.new(connect1) do |connect|
		message1 = connect.gets
		connect2.print message1
		file.puts "From 5001 to 5002 -> " + message1.chomp
	end
	t2 = Thread.new(connect2) do |connect|
		message2 = connect.gets
		connect1.print message2
		file.puts "From 5002 to 5001 -> " + message2.chomp
	end
	t1.join
	t2.join
end

t1.exit
t2.exit
file.close
