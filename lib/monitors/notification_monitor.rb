module ScalabilityTest
  module Monitors
    class NotificationMonitor < ScalabilityMonitor
      def channel
        raise NotImplementedError
      end

      def setup
        ActiveSupport::Notifications.subscribe(self.channel) do |*args|
          event = ActiveSupport::Notifications::Event.new(*args)
          @events << {
            'start' => event.time.to_ms,
            'end' => event.end.to_ms,
            'key' => event.name,
            'title' => title_of(event),
          }
        end
      end

      def start
        @events = []
      end

      def results
        {
          :values => [{
            :v => duration(@events),
            :title => title
          }],
          :events => @events
        }
      end

      def title_of(event)
        ''
      end
    end
  end
end