class API < Grape::API
  prefix 'api'
  require 'rack/jsonp'
  use Rack::JSONP
  mount API::Ver1::Root

end
