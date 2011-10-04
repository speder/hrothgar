require 'test_helper'

module Hrothgar
  class HelperTest < ActiveSupport::TestCase
    test "should return publisher and subscriber uris" do
      base = 'http://acme.org:8000'
      path = '/some/path?this=that'
      request = Object.new
      mock(request).fullpath { path }
      mock(request).url { [base, path].join }
      o = ClassWithHelper.new
      assert o.respond_to?(:pubsub_uris)
      pub, sub = o.pubsub_uris(request)
      assert_match /^#{base}\/push\/publish\?channel=.+?$/, pub
      assert_match /^#{base}\/push\/subscribe\?channel=.+?$/, sub
    end
  end
  
  class ClassWithHelper
    include Helper
  end
end
