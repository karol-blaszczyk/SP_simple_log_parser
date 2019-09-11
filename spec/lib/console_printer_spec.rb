# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ConsolePrinter do
  it 'prints to STDOUT' do
    expect { described_class.print(%w[test1 test2]) }
      .to output("test1\ntest2\n").to_stdout_from_any_process
  end
end
