require "socket"

server = TCPServer.open(2000)
loop {
	client = server.accept
	parts = client.gets.split(" ")
	if parts[0] == "GET"
	  if parts[1] == "/index.html"
	  	file = File.open("index.html", "r")
	  	contents = file.read
	  	client.puts "HTTP/1.0 200 OK"
	  	client.puts(Time.now.ctime)
	  	client.puts "Content-Type: text/html"
	  	client.puts "Content-Length: #{contents.size}\r\n\r\n"
	  	client.puts(contents)
	  	client.close
	  end
	else
	  client.puts "ERROR"
	end
}