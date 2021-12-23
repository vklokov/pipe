# frozen_string_literal: true

module Pipe
  class File
    class << self
      def find_all_deal_files(deal_id)
        find_deal_files(deal_id) + find_deal_email_files(deal_id)
      end

      def find_deal_files(deal_id)
        request = Pipe::Routes::ROUTE_DEALS_FILES.sub(':id', deal_id.to_s)
        response = Pipe::Client.new(request).get
        response[:data].map do |file|
          url = Pipe::Routes::ROUTE_FILE_DOWNLOAD.sub(':id', file[:id].to_s)

          new(
            id: file[:id],
            name: file[:file_name],
            url: Pipe::Client.new(url).send(:base_signed_url)
          )
        end
      end

      def find_deal_email_files(deal_id)
        files = []
        request = Pipe::Routes::ROUTE_DEALS_MAIL_MESSAGES.sub(':id', deal_id.to_s)
        response = Pipe::Client.new(request).get
        return [] unless response[:data]

        response[:data].each do |message|
          next unless message[:data].key? :attachments

          message[:data][:attachments].each do |file|
            url = Pipe::Routes::ROUTE_FILE_DOWNLOAD.sub(':id', file[:id].to_s)

            files << new(
              id: file[:id],
              name: file[:name],
              url: Pipe::Client.new(url).send(:base_signed_url)
            )
          end
        end

        files
      end
    end

    attr_reader :id, :name, :url

    def initialize(id:, name:, url:)
      @id = id
      @name = name
      @url = url
    end
  end
end
