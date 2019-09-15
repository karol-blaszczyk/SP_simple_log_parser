# frozen_string_literal: true

# Analyze log from file line by line
# This class responsibility is to iterate over each line of provided log file
class LogFileProcessor
  def initialize(file_path:)
    raise ArgumentError, 'File does not exist' unless File.exist?(file_path)

    @log_file = File.open(file_path)
  end

  # Parse lines with provided line_parser
  # Emit parsed line to provided collector
  def process(line_parser:, store:)
    @log_file.each_line do |line|
      line = line_parser.call line
      next unless line

      store.call line
    end
  end
end
