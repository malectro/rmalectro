require 'open-uri'

def vendor_uri(filename, uri, config={})
  get uri, "vendor/#{filename}"
end

def vendor_js_uri(filename, uri)
  vendor_uri "assets/javascripts/#{filename}", uri
end

def local_copy(src, dest, options={})
  copy_file "#{@cwd}/#{src}", dest, options
  if options[:app_name]
    gsub_file dest, /%app_name%/, @app_name
  end
end

def local_dir(src, dest)
  directory "#{@cwd}/#{src}", dest
end

@app_name = app_name
@cwd = File.dirname(__FILE__)

gem "mongoid"
gem "ejs", group: :assets

application do
  "config.assets.precompile += ['admin/admin.js', 'admin/admin.css']"
end

# generate mongoid.yml
generate 'mongoid', 'config'

# add vendor js
vendor_js_uri 'backbone.js', 'http://backbonejs.org/backbone.js'
vendor_js_uri 'underscore.js', 'http://underscorejs.org/underscore.js'
vendor_js_uri 'jquery.transit.js', 'http://ricostacruz.com/jquery.transit/jquery.transit.js'

# add stylsheets stuff
inside "app/assets/stylesheets" do
  remove_file "application.css"
  local_copy "stylesheets/application.css.scss", "application.css.scss"
  local_copy "stylesheets/base.css.scss", "base.css.scss"
  local_copy "stylesheets/home.css.scss", "home.css.scss"
  local_dir "stylesheets/admin", "admin"
end

# add javascript defaults
inside "app/assets/javascripts" do
  ['lib', 'models', 'templates', 'views'].each do |dir|
    empty_directory dir
  end

  local_copy "javascripts/application.js", "application.js", force: true
  local_copy "javascripts/main.js", "main.js"

  local_dir "javascripts/admin", "admin"
end

inside "app/controllers" do
  local_copy "controllers/home_controller.rb", "home_controller.rb"
  local_dir "controllers/admin", "admin"
end

inside "app/views" do
  local_copy "views/layouts/admin.html.erb", "layouts/admin.html.erb"
  local_copy "views/layouts/application.html.erb", "layouts/application.html.erb", force: true, app_name: true
  local_dir "views/home", "home"
end

local_copy "script/deploy.sh", "script/deploy.sh", app_name: true

inside "config" do
  inject_into_file "routes.rb", before: "  # The priority is based upon order of creation:" do
    %Q{
    root to: 'home#index'

    namespace :admin do
      root to: 'admin#index'
    end
    }
  end
  local_copy "config/mongoid.yml", "mongoid.yml", app_name: true
end

remove_file "public/index.html"

git :init
git :add => "."
git :commit => "-m'First commit!'"

