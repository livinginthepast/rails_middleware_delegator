require 'spec_helper'

RSpec.describe RailsMiddlewareDelegator do
  it 'has a version number' do
    expect(RailsMiddlewareDelegator::VERSION).not_to be nil
  end

  class WrappedClass
    def initialize(app, *args)
      @app = app
      @args = args
    end

    def call(env, *args)
      @app.call(env, *args)
    end
  end

  let(:app) { double('app', call: true) }
  let(:env) { double('env') }
  let(:fake_rails) { double('Rails', application: rails_app) }
  let(:rails_app) { double('application', config: rails_config) }
  let(:rails_config) { double('config', cache_classes: cache_classes) }
  let(:cache_classes) { false }

  subject(:delegator) { described_class.new('WrappedClass') }

  before do
    stub_const('Rails', fake_rails)
  end

  describe '#class' do
    it 'is the initialized class' do
      expect(delegator.class).to eq('WrappedClass')
    end
  end

  describe '#new' do
    it 'sets initialization_args' do
      expect { delegator.new(1, 2, 3) }.to change {
        delegator.initialization_args
      }.from(nil).to([1, 2, 3])
    end

    context 'when rails is configured to not cache_classes' do
      it 'returns self' do
        expect(delegator.new(1, 2, 3)).to eq(delegator)
      end
    end

    context 'when rails is configured to cache classes' do
      let(:cache_classes) { true }

      it 'returns an instance of klass' do
        expect(delegator.new(1, 2, 3)).to be_a(WrappedClass)
      end
    end
  end

  describe '#call' do
    it 'initializes a klass and calls it with the passed args' do
      delegator.new(app, 1, 2, 3).call(env, 4, 5, 6)
      expect(app).to have_received(:call).with(env, 4, 5, 6)
    end
  end
end
