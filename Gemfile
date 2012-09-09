source 'http://rubygems.org'

gem 'sqlite3-ruby', :require => 'sqlite3'
# ruby '1.9.3'
gem 'rails', '3.2.8' 

gem "mongoid", "~> 3.0.0"

# gem "locu", git: "git@github.com:acechase/locu-ruby.git"

# http://haml-lang.com/
gem 'haml'
gem 'haml-rails'

gem 'andand'

# the rails webserver. Using this rather than passenger or others because Heroku suggests it 
# (and presumably it's what they best support).
gem 'thin'

# https://github.com/nov/fb_graph
gem 'fb_graph'

#gem 'coffee-filter'

gem 'rabl'

group :assets do
  gem 'sass-rails'
  # gem 'coffee-rails'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', :platform => :ruby

  gem 'uglifier', '>= 1.0.3'
  # documentation: https://github.com/seyhunak/twitter-bootstrap-rails
  gem 'twitter-bootstrap-rails'
end

group :test do
  gem 'shoulda'
end

gem 'simplecov', :require => false, :group => :test

# adds jquery.js, jquery-ui.js and jquery-ujs to the asset path
gem 'jquery-rails'


