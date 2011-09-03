module CacheMachine
  class Logger

    # The different log levels.
    LOGGING_LEVELS = { :debug  => 0,   # Tons of log messages for tracking internal functioning of cache-machine.
                       :info   => 1,   # Log messages that visualize how cache-machine works.
                       :errors => 2,   # Only error messages.
                       :none   => 10 } # No output at all.

    # The default log level.
    @@level = LOGGING_LEVELS[:none]

    class << self
      LOGGING_LEVELS.keys.each do |level|
        define_method(level) { |message| write level, message }
      end

      # Sets the log level for CacheMachine.
      # Call like this in your your code, best in development.rb: ActiveRecord::CacheMachine::Logger.level = :info
      def level= value
        @@level = LOGGING_LEVELS[value] or raise "CACHE_MACHINE: Unknown log level: '#{value}'."
        puts "CACHE_MACHINE: Setting log level to '#{value}'."
      end

      # Logs the given entry with the given log level.
      def write level, text
        puts text if @@level <= (LOGGING_LEVELS[level] or raise "CACHE_MACHINE: Unknown log level: '#{level}'.")
      end
    end
  end
end
