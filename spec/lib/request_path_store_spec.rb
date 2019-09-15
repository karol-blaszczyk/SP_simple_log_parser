# frozen_string_literal: true

require 'spec_helper'

RSpec.describe RequestPathStore do
  subject(:store) { described_class.new }

  let(:logline) { double('slip', ip: '192.168.0.1', path: '/home') }

  describe '#emit' do
    it 'stores path view info correctly' do
      expect { store.emit(logline) }
        .to change { store.instance_variable_get(:@store) }
        .from({})
        .to('/home' => { '192.168.0.1' => 1 })
    end
  end

  context 'aggragators' do
    before do
      3.times { store.emit(logline) }
    end

    describe '#views_by_path' do
      it { expect(store.views_by_path).to eq([{ '/home' => 3 }]) }
    end

    describe '#uniq_views_by_path' do
      it { expect(store.uniq_views_by_path).to eq([{ '/home' => 1 }]) }
    end
  end
end
