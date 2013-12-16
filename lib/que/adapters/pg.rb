require 'monitor'

module Que
  module Adapters
    class PG < Base
      def initialize(pg)
        @pg   = pg
        @lock = Monitor.new # Must be re-entrant.
        super
      end

      def checkout
        @lock.synchronize { yield @pg }
      end
    end
  end
end