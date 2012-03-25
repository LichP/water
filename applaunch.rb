$LOAD_PATH.unshift File.join(File.dirname($0), 'app')
require 'logger'
require 'launchy'
require 'rack'

# A small modicifcation to Rack::Handler::WEBrick to expose the WEBrick server
# You will need to use a different approach if you plan on using a different
# Rack handler (e.g. Thin, Mongrel, etc)
class Rack::Handler::WEBrick
  def self.server
    @server
  end
end

logger = Logger.new(STDOUT)
logger.formatter = proc do |severity, datetime, progname, msg|
  "[#{datetime.strftime('%F %T')}] #{severity}  [Water] #{msg}\n"
end

logger.info("Program running as: #{$PROGRAM_NAME}")

logger.info("Building app ...")
app, options = Rack::Builder.parse_file("app/config.ru")
logger.info("App built.")

trap("INT") { Rack::Handler::WEBrick.shutdown }

rack_thread = Thread.new do
  logger.info("Starting server ...")
  Rack::Handler::WEBrick.run app, options
end

logger.info("Waiting for server to become ready ...")
while Rack::Handler::WEBrick.server.nil? || Rack::Handler::WEBrick.server.status != :Running
  sleep(1)
end

if defined?(Ocra)
  logger.info("Ocra is running, shutting down server and exiting")
  Rack::Handler::WEBrick.shutdown
  exit
else
  logger.info("Server ready, launching browser window ...")
  
  host = options[:Host] || options[:BindAddress] || "localhost"
  logger.debug("Host: #{host}")
  host = "localhost" if host == "0.0.0.0"
  port = options[:Port]

  Launchy.open("http://#{host}:#{port}/")
end

rack_thread.join

