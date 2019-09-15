#!/usr/bin/env ruby
# frozen_string_literal: true

Dir.glob(File.join('./lib', '**', '*.rb'), &method(:require))

counter = RequestPathStore.new
line_parser = LineParser

LogFileProcessor.new(
  file_path: ARGV[0]
).process(
  store: ->(line) { counter.emit line },
  line_parser: ->(line) { line_parser.parse line }
)

ConsolePrinter.print(["\n\t----Uniq Views Per Path------\n"])
ConsolePrinter.print(counter.uniq_views_by_path)
ConsolePrinter.print(["\n\n\t----Views Per Path------\n"])
ConsolePrinter.print(counter.views_by_path)
