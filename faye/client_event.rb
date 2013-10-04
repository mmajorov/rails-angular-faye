require 'hashie'

class ClientEvent
  MONITORED_CHANNELS = [ '/meta/subscribe', '/meta/disconnect' ]

  def incoming(message, callback)
    return callback.call(message) unless MONITORED_CHANNELS.include? message['channel']

    faye_msg = Hashie::Mash.new(message)
    faye_action = faye_msg.channel.split('/').last

    get_client(faye_msg.clientId, faye_action)
    faye_client.publish('/users/list', connected_clients.values.to_json)

    callback.call(message)
  end

  def connected_clients
    @connected_clients ||= { }
  end

  def push_client(client_id)
    connected_clients[client_id] ||= {name: "Guest #{rand(10000)}", id: client_id}
  end

  def pop_client(client_id)
    connected_clients.delete(client_id)
  end

  def get_client(client_id, action)
    if action == 'subscribe'
      push_client(client_id)
    elsif action == 'disconnect'
      pop_client(client_id)
    end
  end

  def faye_client
    @faye_client ||= Faye::Client.new('http://localhost:9292/faye')
  end
end