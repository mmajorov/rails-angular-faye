require 'faye'
load 'faye/client_event.rb'

Faye::WebSocket.load_adapter('thin')
faye_server = Faye::RackAdapter.new(:mount => '/faye', :timeout => 45)
faye_server.add_extension(ClientEvent.new)

run faye_server