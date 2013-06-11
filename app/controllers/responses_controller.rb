class ResponsesController < ApplicationController
  skip_before_filter  :verify_authenticity_token
  def response
    p params
    flash[:success] = "#{params} was received."
    redirect_to root_path
  end
end
