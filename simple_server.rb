require "socket"
require "json"

server = TCPServer.open(2000)
loop {
	client = server.accept
	response = client.read_nonblock(256)
	headers, body = response.split("\r\n\r\n")
	
	header_parts = headers.split(" ")
	method = header_parts[0]
	path = header_parts[1][1..-1]

	if File.exist?(path)
	  client.puts "HTTP/1.0 200 OK\r\n#{Time.now.ctime}\r\nContent-Type: text/html\r\n\r\n"
	  if method == "GET"
	  	file = File.open(path, "r")
	  	contents = file.read
	    client.puts "Content-Length: #{contents.size}\r\n\r\n"
	    client.puts (contents)
	    client.close
	  elsif method == "POST"
	    params = JSON.parse body
	    user_data = "<li>name: #{params["viking"]["name"]}</li><li>email: #{params["viking"]["email"]}</li>"
	    file = File.open(path, "r")
	    contents = file.read
	    client.puts contents.gsub("<%= yield %>", user_data)
	    client.close
	  end
	else
	  client.puts "ERROR"
	  client.close
	end

	
}