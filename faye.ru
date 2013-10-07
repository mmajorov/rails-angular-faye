require 'faye'
load 'faye/client_event.rb'
load 'faye/resource_locks.rb'

Faye::WebSocket.load_adapter('thin')
faye_server = Faye::RackAdapter.new(:mount => '/faye', :timeout => 45)
faye_server.add_extension(ClientEvent.new)
faye_server.add_extension(ResourceLocks.new)

run faye_server