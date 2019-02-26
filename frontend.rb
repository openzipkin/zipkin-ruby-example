require 'sinatra'
require 'faraday'
require 'zipkin-tracer'

set :port, 8081

conn = Faraday.new(:url => 'http://localhost:9000/') do |faraday|
  faraday.use ZipkinTracer::FaradayHandler, 'backend'
  faraday.request :url_encoded
  faraday.adapter Faraday.default_adapter
end

get '/' do
  response = conn.get '/api'
  content_type 'text/plain'
  response.body
end

require 'rack'

ZIPKIN_TRACER_CONFIG = {
  service_name: 'frontend',
  sample_rate: 1.0,
  json_api_host: 'http://localhost:9411'
}.freeze

use ZipkinTracer::RackHandler, ZIPKIN_TRACER_CONFIG

