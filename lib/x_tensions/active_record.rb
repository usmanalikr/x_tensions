module ActiveRecord
  class Base
    def self.random
      order("RAND()").first
    end
  end
end
