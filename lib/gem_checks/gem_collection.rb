require 'delegate'
class GemCollection < SimpleDelegator
  def initialize(collection)
    @collection = collection
    super(collection)
  end

  def display_vulnerable
    collection.each do |gem|
      puts format_gem_message(gem)
    end
    self
  end

  def self.wrap(collection)
    collection.empty? ? EmptyGemCollection.new : new(collection)
  end

  private

  attr_reader :collection

  def format_gem_message(gem)
    "#{gem[:gem_name]}, version: #{gem[:version]}"
  end

  class EmptyGemCollection
    MESSAGE = "\nYou have no vulnerable gems in your project".freeze

    def empty?
      true
    end

    def display_vulnerable
      puts MESSAGE
      self
    end
  end
end
