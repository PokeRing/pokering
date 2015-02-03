module Api
  module V1
    class RequestsController < BaseController

      resource_description do
        error :code => 401, :desc => "Unauthorized"
        error :code => 500, :desc => "Internal Server Error"
        description "The JSON schema for the request body per [json-schema.org](http://json-schema.org/)<pre><code>#{File.read(File.join(Rails.root, "app", "models", "json-schema", "request.json"))}</code></pre>One note on request_type: can either be 'invite' or 'referral' to make use of requests for both of these needs."
      end

      api :GET, '/requests', "Get a paged list of requests, page limit set at #{WillPaginate.per_page}"
      error :code => 404, :desc => "Not Found"
      error :code => 500, :desc => "Internal Server Error"
      param :ids, String, :desc => "a comma-delimited list of ids to return (cannot be used in conjunction with the q parameter, ids takes precedence)"
      param :q, String, :desc => "a search across relevant fields (cannot be used in conjunction with the ids parameter, ids takes precedence)"
      param :status, ['active', 'inactive'], :desc => "search for a particular status only, default = active"
      param :page, Integer, :desc => "the page of results to show"
      param :order, String, :desc => "how to order the results, '[field_name] [ASC|DESC]', default = parent_type, parent_id ASC"
      param :various, String, :desc => "any table column name can be used as a param, ex: parent_type=games etc."
      def index
        @results = Request.where(
                          :status => params[:status] ? params[:status] : 'active'
                        )
                        .where(
                          get_arel_search(Request, params)
                        )
                       .paginate(:page => params[:page] ? params[:page] : 1)
                       .order(params[:order] ? params[:order] : 'parent_type, parent_id ASC')
        render_collection @results, params[:page] ? params[:page] : 1
      end

      api :POST, '/requests', 'Create a request'
      description "Refer to the JSON schema above for what to the JSON to post."
      meta :response => 'Returns the created request object'
      def create
        json  = validate_request_body request.body.read, 'request'
        if !json.has_key?("status")
          json["status"] = "active"
        end
        json[:creator_id] = @@user.id
        id    = create_item Request, json
      end

      api :GET, '/requests/:id', 'Get a single request'
      error :code => 404, :desc => "Not Found"
      def show
        show_item Request, params[:id]
      end

      api :PUT, '/requests/:id', 'Update a single request'
      error :code => 404, :desc => "Not Found"
      description "Refer to the JSON schema above for what to the JSON to post."
      def update
        json = validate_request_body request.body.read, 'request'
        update_item Request, params[:id], json
      end

      def destroy
        delete_item Request, params[:id]
      end

    end
  end
end
