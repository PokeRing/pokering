module Api
  module V1
    class UsersController < ApplicationController

      skip_before_filter :authenticate, :only => :create

      def index
        @results = User.where(:status => params[:status] ? params[:status] : 'active')
                       .paginate(:page => params[:page] ? params[:page] : 1)
                       .order(params[:order] ? params[:order] : 'last_name ASC')
        render_collection @results, 1
      end

      def create
        render :json => request.body.read
      end

    end
  end
end
