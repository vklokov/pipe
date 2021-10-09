# frozen_string_literal: true

module Pipe
  class User
    attr_reader :id, :name, :email, :active_flag

    def initialize(source)
      @id          = source[:id]
      @name        = source[:name]
      @email       = source[:email]
      @active_flag = source[:active_flag]
    end

    class << self
      def find_by_email(email)
        request  = Pipe::Routes::ROUTE_USER_BY_EMAIL
        response = Pipe::Client.new(Pipe::Routes::ROUTE_USER_BY_EMAIL, search_by_email: 1, term: email).get
        Pipe::User.new(response[:data].last) if response[:data].last
      end
    end
  end
end
