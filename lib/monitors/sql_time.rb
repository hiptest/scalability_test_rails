module ScalabilityTest
  module Monitors
    class SqlTimeMonitor < NotificationMonitor
      def self.key
        :sql
      end

      def title
        'ActiveRecord SQL time'
      end

      def channel
        'sql.active_record'
      end

      def title_of(event)
        sql_statement = event.payload[:sql].split[0]
        "ActiveRecord SQL #{sql_statement}"
      end
    end
  end
end