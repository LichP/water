$LOAD_PATH.unshift File.join(File.dirname($0), 'app')
require 'launchy'
require 'rack'

puts $PROGRAM_NAME

ARGV << "app/config.ru" unless ARGV.length != 0

rack_server = Rack::Server.new
rack_thread = Thread.new do
  rack_server.start
end

sleep(2)

if defined?(Ocra)
  exit
else
  host = rack_server.options[:Host] || rack_server.options[:BindAddress]
  host = "localhost" if host == "0.0.0.0"
  port = rack_server.options[:Port]

  Launchy.open("http://#{host}:#{port}/")
end
rack_thread.join

