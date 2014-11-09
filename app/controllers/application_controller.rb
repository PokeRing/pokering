class ApplicationController < ActionController::Base

  before_filter :authenticate

  protected

  def render_collection(results, page)
    render :json => {
      :total    => results.total_entries,
      :count    => results.length,
      :page     => page,
      :results  => results
    }
  end

  def authenticate
    authenticate_or_request_with_http_basic('Pokering') do |username, password|
      username == "foo" && password == "bar"
    end
  end

end
