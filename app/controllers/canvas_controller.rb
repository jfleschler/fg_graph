class CanvasController < ApplicationController
  def show
    redirect_to Facebook.config[:canvas_url]
  end

  def create
    @auth = Facebook.auth.from_signed_request(params[:signed_request])
    if @auth.authorized?
      authenticate Facebook.identify(@auth.user)

      @friends = []
      friends_on_app.each do |friend|
        @friends << FbGraph::User.fetch(friend.identifier)
      end
      
      render :show
    else
      render :authorize
    end
  end
end