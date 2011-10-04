module Hrothgar
  module Helper
    # NB these URI patterns must match those in the relevant Nginx config
    PUBLISH_URI   = '%s/push/publish?channel=%s'    
    SUBSCRIBE_URI = '%s/push/subscribe?channel=%s'

    def pubsub_uris(request)
      base_uri = request.url.gsub(request.fullpath, '')
      channel = Time.now.strftime('%Y%m%d%H%M%S%L')
      [PUBLISH_URI % [base_uri, channel], SUBSCRIBE_URI % [base_uri, channel]]
    end
  end
end
