require 'rails_helper'

RSpec.describe Advertisement, type: :model do
  let(:advertisement) {Advertisement.create!(title: 'New ad', body: 'This is new ad', price: 3)}
  describe 'attributes' do
    it 'create ad attributes' do
      expect(ad).to have_attributes(title: 'New ad', body: 'This is new ad', price: 3)
    end
  end
end
