require 'rails_helper'

describe '投稿のテスト' do
  let(:user) { create(:user) }
  let!(:user2) { create(:user) }
  let!(:salon) { create(:salon, user: user) }
  let!(:salon2) { create(:salon, user: user2) }
  before do
    visit new_user_session_path
    fill_in 'user[emial]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'Log in'
  end
  describe 'salon新規投稿' do
    context '動作の確認' do
      it 'salon_nameフォームが表示される' do
        expect(page).to have_field 'salon[salon_name]'
      end
      it 'salon_addressフォームが表示される' do
        expect(page).to have_field 'salon[salon_address]'
      end
      it 'salon_phoneフォームが表示される' do
        expect(page).to have_field 'salon[salon_phone]'
      end
      it '投稿に成功する' do
        fill_in 'salon[salon_name]', with: Faker::Lorem.characters(number:8)
        fill_in 'salon[salon_address]', with: Faker::Lorem.characters(number:8)
        fill_in 'salon[salon_phone]', with: Faker::PhoneNumber.characters(number:10)
        click_button 'サロン新規作成'
        expect(page).to have_content 'サロンを追加'
      end
      it '投稿に失敗する' do
        click_button 'サロンを追加'
        expect(current_path).to eq(new_salon_path)
      end
    end
  end
  describe 'salon編集のテスト' do
    context '自分のsalon投稿の編集画面への遷移' do
      it '遷移できる' do
        visit edit_salon_path(salon)
        expect(current_path).to eq('/salons/' + salon.id.to_s + '/edit')
      end
    end
    context '他人の投稿の編集画面への遷移' do
      it '遷移できない' do
        visit edit_salon_path(style2)
        expect(current_path).to eq('/users/' + user.id.to_s)
      end
    end
    context '表示の確認' do
      before do
        visit edit_style_path(style)
      end
      it '画像編集フォームが表示される' do
        expect(page).to have_field 'salon[salon_image]'
      end
      it 'salon_name編集フォームが表示される' do
        expect(page).to have_field 'salon[salon_name]', with: salon.salon_name
      end
      it 'salon_address編集フォームが表示される' do
        expect(page).to have_field 'salon[salon_address]', with: salon.salon_address
      end
      it 'salon_phone編集フォームが表示される' do
        expect(page).to have_field 'salon[salon_phone]', with: salon.salon_phone
      end
    end
    context 'フォームの確認' do
      it '編集に成功する' do
        visit edit_salon_path(salon)
        click_button 'サロン編集完了'
        expect(page).to have_content 'サロン情報変更'
        expect(current_path).to eq '/users/' + user.id.to_s
      end
      it '編集に失敗する' do
        visit edit_style_path(style)
        fill_in 'salon[salon_name]', with: ''
        click_button 'サロン編集完了'
        expect(current_path).to eq '/salons/' + salon.id.to_s + '/edit'
      end
    end
  end
end