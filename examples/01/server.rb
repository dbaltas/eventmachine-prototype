$:.unshift File.dirname(__FILE__)

require 'eventmachine'
require 'helpers'

class SayHi <  EM::Connection
	def receive_data(data)
		log "received data: #{data}"
	end

	def post_init
		data = 'hello, glad you connected'
		log "sending data: #{data}"
		send_data data
	end
end

EM.run {
	log "server listening at port 3210"
	Signal.trap("INT")  { log "stopping"; EM.stop }
  	Signal.trap("TERM") { log "stopping"; EM.stop }
	EM.start_server '127.0.0.1', 3210, SayHi
}