require 'sinatra'
require 'date'

set :port, 9000

get '/api' do
  content_type 'text/plain'
  DateTime.now.to_s
end

require 'rack'
require 'zipkin-tracer'

ZIPKIN_TRACER_CONFIG = {
  service_name: 'backend',
  sample_rate: 1.0,
  json_api_host: 'http://localhost:9411'
}.freeze

use ZipkinTracer::RackHandler, ZIPKIN_TRACER_CONFIG

