require 'net/http'
require 'uri'

module Hrothgar
  class PubSub
    attr_accessor :uri, :http

     def initialize(uri_string)
      @uri = URI.parse(uri_string)
      @http = Net::HTTP.new(uri.host, uri.port)
    end

    def publish(message, options = {})
      error   = options[:error] || false
      eot     = options[:eot]   || false
      request = Net::HTTP::Post.new(uri.request_uri)
      request.body = {
        :message => message, 
        :error   => error ? 1 : 0, 
        :eot     => eot   ? 1 : 0
      }.to_json
      request.content_type = 'text/json'
#     request['accept']    = 'text/json'
      http.request(request)
    end
  end
end
