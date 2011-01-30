require 'rubygems'
require 'sinatra'
require 'dm-core'

require 'Hasher.rb'

class Counter
  include DataMapper::Resource

  property :id,             Serial
  property :title,          String
  property :description,    Text
  property :created_at,     DateTime
  property :incremeting,    Boolean
  property :current_value,  Integer

  def tick
    if self.incrementing
      self.current_value = self.current_value + 1
    else
      self.current_value = self.current_value - 1
    end
  end
end

get '/' do
  haml :index
end
