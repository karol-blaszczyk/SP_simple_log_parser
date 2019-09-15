# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LogFileProcessor do
  subject(:log_processor) { described_class.new(file_path: file_like_path) }

  let(:log_line1) { "line1\n" }
  let(:log_line2) { "line2\n" }
  let(:log_line3) { "line3\n" }
  let(:parsed_log_line1) { double(log_line1) }
  let(:parsed_log_line2) { double(log_line2) }
  let(:parsed_log_line3) { nil }
  let(:file_like_object) do
    StringIO.new([log_line1, log_line2, log_line3].join)
  end
  let(:file_like_path) { './file.log' }
  let(:store) { double('Store') }
  let(:line_parser) { double('LineParser') }

  context 'with existing file' do
    before do
      allow(File).to receive(:exist?).with(file_like_path).and_return(true)
      allow(File).to receive(:open).with(file_like_path).and_return(file_like_object)
    end

    context ' when invalid parser' do
      it 'keys line_parser and store are required' do
        expect { log_processor.process }
          .to raise_error(ArgumentError, 'missing keywords: line_parser, store')
      end

      it 'requires from line_parser to respond to call' do
        expect { log_processor.process(line_parser: nil, store: store) }
          .to raise_error(NoMethodError)
      end
      it 'requires from store to respond to call' do
        allow(line_parser).to receive(:call).and_return(parsed_log_line1)
        expect { log_processor.process(line_parser: line_parser, store: nil) }
          .to raise_error(NoMethodError)
      end
    end

    context 'when valid' do
      it 'calls parser for every line and calls the store' do
        expect(line_parser).to receive(:call).with(log_line1).ordered.and_return(parsed_log_line1)
        expect(store).to receive(:call).with(parsed_log_line1).ordered

        expect(line_parser).to receive(:call).with(log_line2).ordered.and_return(parsed_log_line2)
        expect(store).to receive(:call).with(parsed_log_line2).ordered

        # If nil, log line is not emited to the store
        expect(line_parser).to receive(:call).with(log_line3).ordered.and_return(parsed_log_line3)
        expect(store).not_to receive(:call).with(parsed_log_line3)

        log_processor.process(store: store, line_parser: line_parser)
      end
    end
  end

  context 'with not exisitng file' do
    it 'returns exception' do
      expect(File).to receive(:exist?).with(file_like_path).and_return(false)
      expect { log_processor }.to raise_error(ArgumentError, 'File does not exist')
    end
  end
end
