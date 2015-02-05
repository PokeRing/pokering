module Api
  module V1
    class NotificationsController < BaseController
      include ActionController::Live

      resource_description do
        error :code => 401, :desc => "Unauthorized"
        error :code => 500, :desc => "Internal Server Error"
        description "The JSON schema for the request body per [json-schema.org](http://json-schema.org/)<pre><code>#{File.read(File.join(Rails.root, "app", "models", "json-schema", "notification.json"))}</code></pre> \
          <p>The following are the valid <code>type_id</code> values:</p>
          <div><code>invite.created</code>: when someone has sent an invite</div>
          <div><code>request.invite.created</code>: when someone has requested and invite</div>
          <div><code>invite.referral.created</code>: when someone has sent a referral (which should then lead to an invite if following through)</div>"
      end

      api :GET, '/notifications', "Get a paged list of notifications for the current user, page limit set at #{WillPaginate.per_page}.  This resource is set up to stream notifications via <a href=\"https://developer.mozilla.org/en-US/docs/Server-sent_events/Using_server-sent_events\">server-sent events</a>."
      error :code => 404, :desc => "Not Found"
      error :code => 500, :desc => "Internal Server Error"
      param :status, ['read', 'unread'], :desc => "search for a particular status only, default = read and unread"
      param :page, Integer, :desc => "the page of results to show"
      param :order, String, :desc => "how to order the results, `field_name ASC|DESC`, default = id DESC"
      def index
        response.headers['Content-Type'] = 'text/event-stream'
        min_id = 0
        loop do
            timevalue = (Time.now.to_f * 1000).to_i
            @results = Notification.where(
                          :to_id => @@user.id
                       )
                       .where('id > ?', min_id)
                       .where('? = ?', timevalue, timevalue)
                       .paginate(:page => params[:page] ? params[:page] : 1)
                       .order(params[:order] ? params[:order] : 'id DESC')
          if (@results.length > 0)
            min_id = @results[0].id
          end
          response.stream.write("data: " + get_collection(@results, params[:page] ? params[:page] : 1).to_json + "\n\n")
          sleep 10
        end
      rescue IOError
        # Client Disconnected
      ensure
        response.stream.close
      end

      api :GET, '/notifications/:id', 'Get a single notification'
      error :code => 404, :desc => "Not Found"
      def show
        show_item Notification, params[:id]
      end

      api :PUT, '/notifications/:id', 'Update a single notification, only the status value can be updated'
      error :code => 404, :desc => "Not Found"
      description "Refer to the JSON schema above for what to the JSON to post."
      def update
        json = validate_request_body request.body.read, 'trip'
        update_item Notification, params[:id], json, ["type_id", "to_id", "content"]
      end

    end
  end
end
