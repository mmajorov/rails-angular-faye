require 'hashie'

class ResourceLocks
  MONITORED_CHANNELS = [ '/meta/subscribe', '/meta/disconnect' ]

  def incoming(message, callback)
    return callback.call(message) unless MONITORED_CHANNELS.include? message['channel']
    return callback.call(message) if message['channel'].include? '/resource/lock'

    faye_msg = Hashie::Mash.new(message)
    get_lock faye_msg

    faye_client.publish('/resource/lock/task', faye_msg.to_json)

    callback.call(message)
  end

  def locks
    @locks ||= {}
  end

  def user_locks
    @user_locks ||= {}
  end

  def on_lock msg
    subscription = msg.subscription.split('/')
    return if subscription.count < 4

    lock_class = subscription[-2]
    lock_id = subscription.last.to_i
    return unless lock_id

    locks["#{lock_class}:#{lock_id}"] ||= {
        owner: nil,
        users: []
    }
    lock = locks["#{lock_class}:#{lock_id}"]

    lock[:owner] = msg.clientId unless lock[:owner]
    lock[:users].push(msg.clientId) unless lock[:users].include? msg.clientId

    user_locks[msg.clientId] ||= []
    user_locks[msg.clientId].push "#{lock_class}:#{lock_id}"

    faye_client.publish("/resource/lock/#{lock_class}/#{lock_id}", lock.to_json)
  end

  def on_release msg
    return
    user_locks[msg.clientId].each do |lock_name|
      lock = locks[lock_name]
      lock[:users].delete(msg.clientId) if lock[:users].include? msg.clientId
      lock[:owner] = lock[:users].first if (lock[:owner] == msg.clientId) && lock[:users].any?

      faye_client.publish("/resource/lock/#{lock_name.sub(':', '/')}", lock.to_json)
    end

    user_locks.delete msg.clientId
  end

  def get_lock msg
    action = msg.channel.split('/').last
    if action == 'subscribe'
      on_lock msg
    elsif action == 'disconnect'
      on_release msg
    end
  end

  def faye_client
    @faye_client ||= Faye::Client.new('http://localhost:9292/faye')
  end
end