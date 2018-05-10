configure do
    set :allow_origin, :any
    set :allow_methods, [:get, :post, :put, :options, :delete]
    
    enable :cross_origin
end

options '*' do
    response.headers["Allow"] = "HEAD,GET,POST,PUT,DELETE,OPTIONS"
    response.headers["Access-Control-Allow-Headers"] = "X-Requested-With, X-HTTP-Method-Override, Content-Type, Cache-Control, Accept"
end