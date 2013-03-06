require 'eventmachine'
require './helpers'

class ClientConnection < EM::Connection
	# method will be called when the process receives data from server.connection.send_data
	def receive_data(data)
		log "received message: #{data}"
	end

	def post_init
		data = 'me client got connected'
		log "sending data: #{data}"
		# send an event any 
		EM.add_periodic_timer 1, proc { send_data data}
	end
end

EM.run {
	Signal.trap("INT")  { log "int signal sent, exiting now..."; EM.stop }
	Signal.trap("TERM")  { log "term signal sent, exiting now..."; EM.stop }
	Signal.trap("KILL")  { log "kill signal sent, exiting now..."; EM.stop }

	EM.connect '127.0.0.1', 3210, ClientConnection
}