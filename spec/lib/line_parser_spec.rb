# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LineParser do
  describe '#parse' do
    context 'with valid format' do
      let(:log_line) { '/about/2 722.247.931.582' }

      it 'parsing correctly' do
        expect(described_class.parse(log_line))
          .to have_attributes(path: '/about/2', ip: '722.247.931.582')
      end
    end

    [
      '',
      '722.247.931.582',
      'Something /about/2 722.247.931.582',
      '/Something /about/2 722.247.931.582',
      '127.0.0.1 - MyApp [10/Oct/2019:13:55:36 -0700] "GET /users HTTP/1.1" 200 2326'
    ].each do |log_line|
      context 'with invalid format' do
        it 'returns nil' do
          expect(described_class.parse(log_line)).to be_nil
        end
      end
    end
  end
end
