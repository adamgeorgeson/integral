require "rails_helper"

module Integral
  describe "#configure" do
    let(:foo) { '' }

    before do
      Integral.configure do |config|
        # config.foo = foo
      end
    end

    context 'black_listed_paths' do
      context 'when setting is not set' do
        it 'attempting to create a page under /admin fails' do
          expect(build(:integral_page, path: '/admin/').valid?).to be false
        end
      end

      context 'when setting is set' do
        let(:black_listed_paths) { [ '/foo', '/bar' ] }

        before do
          Integral.configure do |config|
            config.black_listed_paths = black_listed_paths
          end
        end

        it 'attempting to create a page under the black listed paths fails' do
          expect(build(:integral_page, path: '/bar/').valid?).to be false
          expect(build(:integral_page, path: '/foo/').valid?).to be false
        end
      end
    end
  end
end
