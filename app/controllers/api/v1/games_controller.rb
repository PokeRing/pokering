module Api
  module V1
    class GamesController < BaseController

      resource_description do
        error :code => 401, :desc => "Unauthorized"
        error :code => 500, :desc => "Internal Server Error"
        description "The JSON schema for the request body per [json-schema.org](http://json-schema.org/)<pre><code>#{File.read(File.join(Rails.root, "app", "models", "json-schema", "game.json"))}</code></pre>"
      end

      api :GET, '/games', "Get a paged list of games, page limit set at #{WillPaginate.per_page}"
      error :code => 404, :desc => "Not Found"
      error :code => 500, :desc => "Internal Server Error"
      param :ids, String, :desc => "a comma-delimited list of ids to return (cannot be used in conjunction with the q parameter, ids takes precedence)"
      param :q, String, :desc => "a search across relevant fields (cannot be used in conjunction with the ids parameter, ids takes precedence)"
      param :status, ['active', 'inactive'], :desc => "search for a particular status only, default = active"
      param :page, Integer, :desc => "the page of results to show"
      param :order, String, :desc => "how to order the results, '[field_name] [ASC|DESC]', default = name ASC"
      param :various, String, :desc => "any table column name can be used as a param, ex: organizer_id=1 etc."
      def index
        @results = Game.where(
                          :status => params[:status] ? params[:status] : 'active'
                        )
                        .where(
                          get_arel_search(Game, params)
                        )
                       .paginate(:page => params[:page] ? params[:page] : 1)
                       .order(params[:order] ? params[:order] : 'organizer_id ASC')
        render_collection @results, params[:page] ? params[:page] : 1
      end

      api :POST, '/games', 'Create a game'
      description "Refer to the JSON schema above for what to the JSON to post."
      meta :response => 'Returns the created game object'
      def create
        json  = validate_request_body request.body.read, 'game'
        if !json.has_key?("status")
          json["status"] = "active"
        end
        json[:organizer_id] = @@user.id
        id    = create_item Game, json
      end

      api :GET, '/game/:id', 'Get a single game'
      error :code => 404, :desc => "Not Found"
      def show
        show_item Game, params[:id]
      end

      api :PUT, '/games/:id', 'Update a single game'
      error :code => 404, :desc => "Not Found"
      description "Refer to the JSON schema above for what to the JSON to post."
      def update
        json = validate_request_body request.body.read, 'game'
        update_item Game, params[:id], json
      end

      def destroy
        delete_item Game, params[:id]
      end

    end
  end
end
