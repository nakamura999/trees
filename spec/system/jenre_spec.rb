require 'rails_helper'

describe '投稿のテスト' do
  let(:admin) { create(:admin) }
  let!(:jenre) { create(:jenre) }
  before do
    visit new_admin_session_path
    fill_in 'admin[email]', with: admin.email
    fill_in 'admin[password]', with: admin.password
    click_button 'Log in'
  end
  describe 'Jenre新規投稿' do
    context '動作の確認' do
      before do
        visit admins_jenres_path
      end
      it 'nameフォームが表示される' do
        expect(page).to have_field 'jenre[name]'
      end
      it '投稿に成功する' do
        fill_in 'jenre[name]', with: Faker::Lorem.characters(number:6)
        click_button '追加'
        expect(page).to have_content 'ジャンルを追加'
      end
      it '投稿に失敗する' do
        click_button '追加'
        expect(page).to have_content 'ジャンルは1文字以上20文字以内です'
      end
    end
  end
  describe 'jenre編集のテスト' do
    context '自分のjenre投稿の編集画面への遷移' do
      it '遷移できる' do
        visit edit_admins_jenre_path(jenre)
        expect(current_path).to eq('/admins/jenres/' + jenre.id.to_s + '/edit')
      end
    end
    context '表示の確認' do
      before do
        visit edit_admins_jenre_path(jenre)
      end
      it 'name編集フォームが表示される' do
        expect(page).to have_field 'jenre[name]', with: jenre.name
      end
    end
    context 'フォームの確認' do
      it '編集に成功する' do
        visit edit_admins_jenre_path(jenre)
        click_button '保存'
        expect(page).to have_content 'ジャンルを変更'
      end
    end
  end
end