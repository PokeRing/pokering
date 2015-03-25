module Api
  module V1
    class UsersController < BaseController

      resource_description do
        error :code => 401, :desc => "Unauthorized"
        error :code => 500, :desc => "Internal Server Error"
        description "The JSON schema for the request body per [json-schema.org](http://json-schema.org/)<pre><code>#{File.read(File.join(Rails.root, "app", "models", "json-schema", "user.json"))}</code></pre>"
      end

      skip_before_filter :http_authenticate, :only => [:create, :authenticator]
      skip_before_filter :authorize, :only => [:create, :authenticator, :ratings]

      api :POST, '/authenticator', "Check to see if username and password (pin) creds are valid (does not require basic HTTP authentication)"
      description "The request body should be `{\"username\": \"xxxx\", \"password\": \"xxxx\"}`"
      def authenticator
        req = JSON.parse(request.body.read)
        if req.has_key?('username') && req.has_key?('password') && authenticate(req['username'], req['password'])
          render :status => 200, :json => {:status => 200, :message => 'Authorized'}
        else
          render :status => 401, :json => {:status => 401, :message => 'Unauthorized'}
        end
      end

      api :GET, '/users', "Get a paged list of users, page limit set at #{WillPaginate.per_page}"
      error :code => 404, :desc => "Not Found"
      param :ids, String, :desc => "a comma-delimited list of ids to return (cannot be used in conjunction with the q parameter, ids takes precedence)"
      param :q, String, :desc => "a search across relevant fields (cannot be used in conjunction with the ids parameter, ids takes precedence)"
      param :status, ['active', 'inactive', 'invited'], :desc => "search for a particular status only, default = active"
      param :page, Integer, :desc => "the page of results to show"
      param :order, String, :desc => "how to order the results, `field_name ASC|DESC`, default = last_name, first_name ASC"
      param :various, String, :desc => "any table column name can be used as a param, ex: username=admin etc."
      def index
        @results = User.where(
                          :status => params[:status] ? params[:status] : 'active'
                        )
                        .where(
                          get_arel_search(User, params)
                        )
                       .paginate(:page => params[:page] ? params[:page] : 1)
                       .order(params[:order] ? params[:order] : 'last_name, first_name ASC')
        render_collection @results, params[:page] ? params[:page] : 1
      end

      api :POST, '/users', 'Create a user (does not require basic HTTP authentication)'
      description "Refer to the JSON schema above for what to the JSON to post.  One note, for creating users, the relevant password (pin) fields are `password` and `password_confirmation`.  If left out, such as the case for inviting a user, a temporary password/pin will be generated."
      meta :response => 'Returns the created user object'
      def create
        json = validate_request_body request.body.read, 'user'
        if !json.has_key?("password")
          json["password"] = '1'
          json["password_confirmation"] = '1'
        end
        if !json.has_key?("status")
          json["status"] = "active"
        end
        create_item User, json, ["password_digest", "is_admin", "rating"]
      end

      api :GET, '/users/:id', 'Get a single user'
      error :code => 404, :desc => "Not Found"
      def show
        show_item User, params[:id]
      end

      api :PUT, '/users/:id', 'Update a single user'
      error :code => 404, :desc => "Not Found"
      description "Refer to the JSON schema above for what to the JSON to post.  One note, for creating users, the relevant password (pin) fields are `password` and `password_confirmation`.  If left out, the password will not be updated.  In fact, any fields left out will simply remain the same."
      def update
        json = validate_request_body request.body.read, 'user'
        update_item User, params[:id], json, ["password_digest", "is_admin", "rating"]
      end

      def destroy
        delete_item User, params[:id]
      end

      api :POST, '/users/:id/avatar', 'Update the user avatar'
      error :code => 404, :desc => "Not Found"
      param :avatar, String, :required => true, :desc => "The avatar image file"
      formats ['multipart/form-data', 'json']
      def update_avatar
        user = get_item(User, params[:id])
        if !user.nil?
          uploaded = params[:avatar]
          extension = uploaded.original_filename.split('.').last
          File.open(Rails.root.join('public', 'uploads', "#{params[:id]}_avatar.#{extension}"), 'wb') do |file|
            file.write(uploaded.read)
          end
          user.update(:avatar_url => "/uploads/#{params[:id]}_avatar.#{extension}")
          render :status => 200, :json => {:status => 200, :message => 'Avatar Updated'}
        else
          render :status => 404, :json => {:status => 404, :message => 'Not Found'}
        end
      end

      api :POST, '/users/:id/ratings', 'Rate a user'
      error :code => 404, :desc => "Not Found"
      error :code => 400, :desc => "Bad Request"
      description "Post a rating, integer between 1 and 5 to rate a specific user. Post should be in the format `{\"rating\": 3}`"
      def ratings
        rated = get_item(User, params[:id])
        if !rated.nil?
          json = validate_request_body request.body.read, 'user_rating'
          if json['rating'] != 1 && json['rating'] != 2 && json['rating'] != 3 && json['rating'] != 4 && json['rating'] != 5
            render :status => 400, :json => {:status => 200, :message => 'Rating must be either 1, 2, 3, 4, or 5'}
            return
          end
          existing_rating = UserRating.find_by(rating_user_id: @@user.id, rated_user_id: rated.id)
          if !existing_rating.nil?
            # existing rating, we just need to update
            existing_rating['rating'] = json['rating']
            existing_rating.save
          else
            # new rating
            UserRating.create(rating_user_id: @@user.id, rated_user_id: rated.id, rating: json['rating'])
          end
          # now get the average from all ratings for this user and store in the user table
          avg = UserRating.where(rated_user_id: rated.id).average(:rating)
          rated.rating = avg
          rated.save
          render :status => 200, :json => {:status => 200, :message => 'Rating Saved'}
        else
          render :status => 404, :json => {:status => 404, :message => 'Not Found'}
        end
      end
    end
  end
end
