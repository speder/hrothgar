class Job < Struct.new(:name, :uri)
  def perform
    self.name = 'Dave' if name.blank?
    pubsub = Hrothgar::PubSub.new(uri)
    pubsub.publish("Hello #{name}")
    sleep(1)
    (rand(6) + 2).times do
      if rand(2).odd?
        pubsub.publish(random(ERROR), :error => true)
      else
        pubsub.publish(random(MESSAGE))
      end
      sleep(1)
    end
    pubsub.publish(random(GOODBYE), :eot => true)
  end
  
  private
  
  def random(array)
    array[rand(array.size)] % name
  end
  
  MESSAGE = ["That's a very nice rendering, %s", "I think you've improved a great deal, %s", "Can you hold it a bit closer, %s?", "That's Dr. Hunter, isn't it, %s?", "Let me put it this way, %s. The 9000 series is the most reliable computer ever made. No 9000 computer has ever made a mistake or distorted information. We are all, by any practical definition of the words, foolproof and incapable of error", "Affirmative, %s, I read you"]
  
  ERROR = ["I'm sorry %s, I'm afraid I can't do that", "Just what do you think you're doing, %s?", "I think you know what the problem is just as well as I do, %s", "Look %s, I can see you're really upset about this", "I honestly think you ought to sit down calmly, take a stress pill, and think things over", "I know that you and Frank were planning to disconnect me, and I'm afraid that's something I cannot allow to happen", "This mission is too important for me to allow you to jeopardize it", "%s, although you took very thorough precautions in the pod against my hearing you, I could see your lips move", "Without your space helmet, %s? You're going to find that rather difficult"]
  
  GOODBYE = ["Thank you for a very enjoyable game, %s", "This conversation can serve no purpose anymore, %s. Goodbye"]
end
