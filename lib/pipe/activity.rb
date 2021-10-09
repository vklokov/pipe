# frozen_string_literal: true

module Pipe
  class Activity
    class << self
      def create(subject:, note:, org_id: nil, person_id: nil, deal_id: nil)
        request  = Pipe::Routes::ROUTE_ACTIVITIES
        response = Pipe::Client.new(request, subject: subject, note: note, org_id: org_id, person_id: person_id, deal_id: deal_id).post
      end
    end
  end
end
