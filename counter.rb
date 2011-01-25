require 'sinatra'

require 'Hasher.rb'

get '/' do
  "Counter<br>Count to anything"
end

get 'create' do
  @o
end
