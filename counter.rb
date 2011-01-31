require 'rubygems'
require 'sinatra'
require 'dm-core'
require 'dm-migrations'

require 'Hasher.rb'

DataMapper.setup(:default, 'sqlite::memory:')

class Counter
  include DataMapper::Resource

  property :id,             Serial
  property :title,          String
  property :description,    Text
  property :created_at,     DateTime
  property :incrementing,    Boolean
  property :current_value,  Integer

  def tick
    if self.incrementing
      self.current_value = self.current_value + 1
    else
      self.current_value = self.current_value - 1
    end
    self.save unless self.id.nil?
    self.current_value
  end

  def hash
    unless self.id.nil?
      Hasher::encode(self.id)
    else
      nil
    end
  end
end

get '/' do
  DataMapper.auto_migrate!
  haml :index
end

post '/create' do
  values = Hash.new

  if params[:starting_value].to_i
    values[:current_value] = params[:starting_value]
  end

  values[:incrementing] = params[:direction] == 'Up'

  if params[:title] != ""
    values[:title] = params{:title}
  end

  if params[:description] != ""
    values[:description] = params{:description}
  end

  counter = Counter.create(values)
  unless counter.nil?
    redirect "/#{counter.hash}"
  else
    @form_vals= params
    haml :index
  end
end
