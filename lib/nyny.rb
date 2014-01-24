require 'rack'

require 'nyny/version'
require 'nyny/app'
require 'nyny/core-ext/runner'
require 'nyny/core-ext/templates'

module NYNY
  class EnvString < String
    [:production, :development, :test].each do |env|
      define_method "#{env}?" do
        self == env.to_s
      end
    end
  end

  class PathString < String
    def join other
      File.join(self, other)
    end
  end

  def self.root
    @root ||= PathString.new(Dir.pwd)
  end

  def self.env
    @env ||= EnvString.new(ENV['RACK_ENV'] || 'development')
  end

  App.register NYNY::Runner
  App.register NYNY::Templates
end

