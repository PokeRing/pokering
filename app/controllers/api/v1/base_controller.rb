module Api
  module V1
    class BaseController < ApplicationController

      resource_description do
        formats ['json']
        meta :author => {:name => 'Patrick', :surname => 'Force'}
      end

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
          User.find_by(username: username).try(:authenticate, password)
        end
      end

      def validate_request_body(request_body, schema_name)
        json    = JSON.parse(request_body)
        schema  = JSON.parse(File.read(File.join(Rails.root, "app", "models", "json-schema", "#{schema_name}.json")))
        JSON::Validator.validate(schema, json)
        return json
      end

      def create_item(type, json, strip = [])
        strip.each do |key|
          json.delete(key) if json.has_key?(key)
        end
        created = type.create(json)
        if created.valid?
          render :status => 201, :json => created
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

      def show_item(type, id)
        item = get_item(type, id)
        if !item.nil?
          render :json => item
        else
          render :status => 404, :json => {:status => 404, :message => 'Not Found'}
        end
      end

      def update_item(type, id, json, strip = [])
        existing = get_item(type, id)
        if !existing.nil?
          strip.each do |key|
            json.delete(key) if json.has_key?(key)
          end
          render :status => 200, :json => type.find(id)
        else
          render :status => 404, :json => {:status => 404, :message => 'Not Found'}
        end
      end

      def get_arel_search(type, q)
        table   = type.arel_table
        search  = nil
        type.get_queryable_fields.each do |field|
          if search.nil?
            search = table[field].matches("%#{q}%")
          else
            search = search.or(table[field].matches("%#{q}%"))
          end
        end
        return search
      end

    end
  end
end