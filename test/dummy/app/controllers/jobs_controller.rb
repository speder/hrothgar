class JobsController < ApplicationController
  def index
  end

  def create
    publish_uri, @subscribe_uri = pubsub_uris(request)
    Delayed::Job.enqueue(Job.new(params[:name], publish_uri))
  end
end
