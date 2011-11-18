# You can put this file in your lib directory.
# Don't forget to add 'use Rack::Facebook' in config.ru.
module Rack
  class FacebookRedirect
    
    def initialize(app)
      @app = app
    end

    def call(env)
      request = Request.new(env)
      
      if request.POST['signed_request']
        env["REQUEST_METHOD"] = 'GET'
      end
      
      return @app.call(env)
    end
  
  end
end