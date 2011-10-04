require 'test_helper'

module Hrothgar
  class PubSubTest < ActiveSupport::TestCase
    test "should initialize" do
      pub_uri = 'http://domain.org/push/subscribe?channel=0123456789'
      pubsub = PubSub.new(pub_uri)
      assert_equal pub_uri, pubsub.uri.to_s
      assert_equal 'domain.org', pubsub.http.address
    end

    test "should publish" do
      pub_uri = 'http://domain.org/push/subscribe?channel=0123456789'
      pubsub = PubSub.new(pub_uri)
      mock(pubsub.http).request(anything)
      pubsub.publish('hello')
    end
  end
end
