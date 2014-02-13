require 'sinatra'
require 'sinatra/partial'
require 'data_mapper'
require 'rack-flash'
require './lib/link' # this needs to be done after datamapper is initialised
require './lib/tag'
require './lib/user'
require_relative 'helpers/application'
require_relative 'data_mapper_setup'

require_relative 'controllers/users'
require_relative 'controllers/sessions'
require_relative 'controllers/links'
require_relative 'controllers/tags'
require_relative 'controllers/application'

enable :sessions
set :session_secret, 'super secret unique encryption key!'
use Rack::Flash 
set :partial_template_engine, :erb






  


































