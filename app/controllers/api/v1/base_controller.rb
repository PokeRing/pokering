module Api
  module V1
    class BaseController < ApplicationController

      @@user = nil

      resource_description do
        formats ['json']
        meta :author => {:name => 'Patrick', :surname => 'Force'}
      end

      before_filter :http_authenticate
      before_filter :authorize

      protected

      def render_collection(results, page)
        render :json => {
          :total    => results.total_entries,
          :count    => results.length,
          :page     => page,
          :results  => results
        }
      end

      def http_authenticate
        authenticate_or_request_with_http_basic('Pokering') do |username, password|
          authenticate username, password
        end
      end

      def authenticate(username, password)
        user = User.find_by(username: username).try(:authenticate, password)
        if !user.nil?
          @@user = user
          return user
        end
      end

      def authorize
        if @@user.is_admin
          return true
        end
        if controller_name == "users" && params.has_key?(:id) && params[:id].to_i != @@user.id
          return forbid
        end
        # some authorization must happen after this, so not all authorization handled here
        return true
      end

      def forbid
        render :status => 403, :json => {:status => 403, :message => "Forbidden"}
      end

      def validate_request_body(request_body, schema_name)
        json    = JSON.parse(request_body)
        schema  = JSON.parse(File.read(File.join(Rails.root, "app", "models", "json-schema", "#{schema_name}.json")))
        JSON::Validator.validate(schema, json)
        return json
      end

      def create_item(type, json, strip = [])
        strip.push("id", "created_at", "updated_at")
        strip.each do |key|
          json.delete(key) if json.has_key?(key)
        end
        created = type.create(json)
        if created.valid?
          render :status => 201, :json => created
          return created.id
        else
          render :status => 500, :json => {:status => 500, :message => created.errors.messages}
        end
      end

      def get_item(type, id)
        if type.exists?(id)
          return type.find(id)
        else
          return nil
        end
      end

      def show_item(type, id, merge = nil)
        item = get_item(type, id)
        if !item.nil?
          if merge.is_a? Hash
            item_hash = item.as_json
            merge.each do |key, value|
              item_hash[key] = value
            end
            render :json => item_hash
          else
            render :json => item
          end
        else
          render :status => 404, :json => {:status => 404, :message => 'Not Found'}
        end
      end

      def update_item(type, id, json, strip = [])
        strip.push("id", "created_at", "updated_at")
        existing = get_item(type, id)
        if (!@@user.is_admin && existing.has_attribute?('organizer_id') && existing.organizer_id != @@user.id) || \
           (!@@user.is_admin && existing.has_attribute?('creator_id') && existing.creator_id != @@user.id) || \
           (!@@user.is_admin && existing.has_attribute?('commenter_id') && existing.commenter_id != @@user.id)
          return forbid
        end
        if !existing.nil?
          strip.each do |key|
            json.delete(key) if json.has_key?(key)
          end
          render :status => 200, :json => type.find(id)
        else
          render :status => 404, :json => {:status => 404, :message => 'Not Found'}
        end
      end

      def delete_item(type, id)
        # Not yet supported
        render :status => 404, :json => {:status => 404, :message => 'Not Found'}
        # existing = get_item(type, id)
        # if !existing.nil?
        #   existing.destroy
        #   render :status => 204, :json => ""
        # else
        #   render :status => 404, :json => {:status => 404, :message => 'Not Found'}
        # end
      end

      def get_arel_search(type, params)
        table   = type.arel_table
        search  = nil
        q       = params[:q]
        ids     = params[:ids]
        if !ids.nil?
          ids = ids.split(',')
          search = table[:id].in(ids)
        else
          type.get_queryable_fields.each do |field|
            if search.nil?
              search = table[field].matches("%#{q}%")
            else
              search = search.or(table[field].matches("%#{q}%"))
            end
          end
        end
        params.each do |key, value|
          if type.column_names.include?(key)
            search = search.and(table[key].eq(value))
          end
        end
        return search
      end

      def get_id_list(type, select, match_field, match_value)
        results = type.select(select).where(match_field => match_value)
        list    = []
        results.each do |result|
          list.push(result[select])
        end
        return list
      end

    end
  end
end
