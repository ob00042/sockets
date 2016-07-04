require "socket"
require 'json'

host = "localhost"
port = 2000
path = "/index.html"
puts "What type of request you want to make? (GET/POST)"
req = gets.chomp

if req == "GET"
  request = "GET #{path} HTTP/1.0\r\n\r\n"

  socket = TCPSocket.open(host, port)
  socket.print(request)
  response = socket.read

  headers, body = response.split("\r\n\r\n", 2)
  print body
  socket.close

elsif req == "POST"

  puts "We are registering for a viking raid!"
  print "Enter your name to take part: "
  name = gets.chomp
  print "Enter your email to take part: "
  email = gets.chomp
  hash = { :viking => {:name => name, :email => email} }
  json_hash = hash.to_json

  socket = TCPSocket.open(host, port)
  socket.puts "POST /thanks.html HTTP/1.0\r\nFrom: ob00042@gmail.com\r\nUser-Agent: HTTPTool/1.0\r\nContent-Type: application/...\r\nContent-Length: #{json_hash.length}\r\n\r\n#{json_hash}"

  response = socket.read
  headers, body = response.split("\r\n\r\n", 2)
  print body
  socket.close

else

  socket = TCPSocket.open(host, port)
  socket.puts "ERROR"
  socket.close

end