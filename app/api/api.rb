class API < Grape::API
  prefix 'api'

  mount API::Ver1::Root

end
