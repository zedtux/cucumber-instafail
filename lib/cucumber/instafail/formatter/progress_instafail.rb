require 'cucumber/formatter/console'
require 'cucumber/formatter/io'

module Cucumber
  module Formatter
    # The formatter used for <tt>--format progress-instafail</tt>
    class ProgressInstafail < Cucumber::Formatter::Progress
      def progress(status)
        char = CHARS[status]
        @io.print(format_string(char, status))
        print_steps(:failed) if status == :failed
        @io.flush
      end
    end
  end
end
