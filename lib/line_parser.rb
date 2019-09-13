# frozen_string_literal: true

# Parse single log line
class LineParser
  # Regexp for log format
  LOG_FORMAT = %r{^([\w|\/]+)\s+(\b(?:\d{1,3}\.){3}\d{1,3}\b)}.freeze
  # Simple Struct to store result of parsed line
  Line = Struct.new(:path, :ip)

  # Parse line based on defined Regexp
  # @param line [String]
  # @return [Struct::LogLine]
  def self.parse(line)
    line.match(LOG_FORMAT) { |m| Line.new(*m.captures) }
  end
end
