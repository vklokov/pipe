# frozen_string_literal: true

require 'rest-client'
require 'json'
require 'date'
require 'yaml'

require 'pipe/version'
require 'pipe/exception'
require 'pipe/config'
require 'pipe/utils'
require 'pipe/serializer'
require 'pipe/field'
require 'pipe/client'
require 'pipe/routes'
require 'pipe/entity'
require 'pipe/activity'
require 'pipe/user'
require 'pipe/deal'
require 'pipe/person'
require 'pipe/organization'

module Pipe
  class << self
    def config
      @config ||= Pipe::Config.new
    end

    def configure
      yield config
    end
  end
end
