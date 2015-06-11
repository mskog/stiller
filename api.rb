require 'uri'
require 'net/http'
require 'tempfile'
require_relative 'lib/webm'

module Stiller
  class API < Grape::API
    format :json

    params do
      requires :url, type: String, regexp: URI.regexp
    end
    get "/still" do
      uri = URI.parse(params[:url])
      webm = Stiller::Webm.from_url(uri)

      content_type "image/png"
      env['api.format'] = :binary
      webm.still.read
    end
  end
end
