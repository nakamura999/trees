require 'rails_helper'

RSpec.describe 'contactモデルのテスト', type: :model do

  describe 'バリデーションのテスト' do
    let(:contact) { build(:contact) }
    subject { test_contact.valid? }

    context 'nameカラム' do
      let(:test_contact) { contact }
      it '空欄でないこと' do
        test_contact.name = ''
        is_expected.to eq false;
      end
      it '2文字以上であること' do
        test_contact.name = Faker::Lorem.characters(number:1)
        is_expected.to eq false;
      end
      it '20文字以下であること' do
        test_contact.name = Faker::Lorem.characters(number:21)
        is_expected.to eq false;
      end
    end
    
    context 'bodyカラム' do
      let(:test_contact) { contact }
      it '空欄でないこと' do
        test_contact.body = ''
        is_expected.to eq false;
      end
      it '2文字以上であること' do
        test_contact.body = Faker::Lorem.characters(number:1)
        is_expected.to eq false;
      end
      it '200文字以下であること' do
        test_contact.body = Faker::Lorem.characters(number:201)
        is_expected.to eq false;
      end
    end
  end
end