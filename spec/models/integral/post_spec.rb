require 'rails_helper'

module Integral
  describe Post do
    let(:post) { build(:integral_post) }
    let(:ip_address) { '192.168.1.1' }

    it 'has a valid factory' do
      expect(post.valid?).to be true
    end

    describe 'relations' do
      it { is_expected.to belong_to :user }
    end

    describe 'validates' do
      it { is_expected.to validate_presence_of :title }
      it { is_expected.to validate_length_of(:title).is_at_least(4) }
      it { is_expected.to validate_length_of(:title).is_at_most(70) }
      it { is_expected.to validate_presence_of :body }
      it { is_expected.to validate_presence_of :user }
      it { is_expected.to validate_presence_of :description }
      it { is_expected.to validate_length_of(:description).is_at_least(50) }
      it { is_expected.to validate_length_of(:description).is_at_most(200) }
    end

    describe '#increment_count' do
      context 'when view is unique (based on IP)' do
        it 'increments count' do
          expect {
            post.increment_count(ip_address)
          }.to change(post, :view_count).by(1)
        end
      end

      context 'when view is not unique (based on IP)' do
        before do
         PostViewing.create!(post: post, ip_address: ip_address)
        end

        it 'does not increment count' do
          expect {
            post.increment_count(ip_address)
          }.not_to change(post, :view_count)
        end
      end
    end
  end
end
