# frozen_string_literal: true

# Print to STDOUT Enumerable object
class ConsolePrinter
  # we open a standard output stream and write a string into it.
  # it could be done with simple print or puts,
  # but thats more formal way of interacting with STDOUT using kernel methods
  # @param result[Enumerable]
  def self.print(result)
    ios = IO.new STDOUT.fileno
    result.each do |path|
      ios.write "#{path}\n"
    end
    ios.close
  end
end
