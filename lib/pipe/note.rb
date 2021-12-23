# frozen_string_literal: true

module Pipe
  class Note
    class << self
      def create(deal_id: nil, person_id: nil, org_id: nil, content:, **params)
        if [deal_id, person_id, org_id].compact.length.zero?
          raise Pipe::Exception::AttributeError, "Resource ID has not been provided"
        end

        request_params = {}.tap do |attr|
          attr[:content] = content
          attr[:deal_id] = deal_id     if deal_id
          attr[:person_id] = person_id if person_id
          attr[:org_id] = org_id       if org_id
        end

        request_url = Pipe::Routes::ROUTE_NOTES
        response = Pipe::Client.new(request_url, { **request_params, **extra(params) }).post
        new response[:data]
      end

      private

      def extra(params)
        {}.tap do |attr|
          attr[:add_time] = params[:add_time].strftime('%Y-%m-%d %H:%M:%S') if params[:add_time]
          attr[:pinned_to_lead_flag] = params[:pinned_to_lead_flag] ? 1 : 0
          attr[:pinned_to_deal_flag] = params[:pinned_to_deal_flag] ? 1 : 0
          attr[:pinned_to_organization_flag] = params[:pinned_to_organization_flag] ? 1 : 0
          attr[:pinned_to_person_flag] = params[:pinned_to_person_flag] ? 1 : 0
        end
      end
    end

    attr_reader :id, :active_flag, :add_time, :content,
                :deal_id, :org_id, :person_id, :pinned_to_lead_flag,
                :pinned_to_deal_flag, :pinned_to_organization_flag,
                :pinned_to_person_flag, :update_time, :user_id

    def initialize(source)
      @id = source[:id]
      @active_flag = source[:active_flag]
      @add_time = Time.parse(source[:add_time])
      @update_time = Time.parse(source[:update_time])
      @content = source[:content]
      @deal_id = source[:deal_id]
      @org_id = source[:org_id]
      @person_id = source[:person_id]
      @user_id = source[:user_id]
      @pinned_to_deal_flag = source[:pinned_to_deal_flag]
      @pinned_to_organization_flag = source[:pinned_to_organization_flag]
      @pinned_to_person_flag = source[:pinned_to_person_flag]
    end
  end
end
