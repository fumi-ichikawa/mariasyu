require 'rails_helper'

RSpec.describe 'マリアージュ投稿', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @mariage_title = Faker::Lorem.sentence
    @mariage_text = Faker::Lorem.sentence
    @image_path = Rails.root.join('public/images/test_image.jpg')
    sleep 0.1
  end
  context 'マリアージュ投稿ができるとき'do
    it 'ログインしたユーザーは新規投稿できる' do
      # ログインする
      sign_in(@user)
      # 新規投稿ページへのボタンがあることを確認する
      expect(page).to have_content('New Mariage')
      # 投稿ページに移動する
      visit new_mariage_path
      # フォームに情報を入力する
      fill_in 'mariage_title', with: @mariage_title
      fill_in 'mariage_text', with: @mariage_text
      select '和食', from: 'mariage[category_id]'
      select 'その他', from: 'mariage[taste_id]'
      attach_file('mariage[image]', @image_path, make_visible: true)
      # 送信するとMariageモデルのカウントが1上がることを確認する
      expect{
        find('input[class="form-btn"]').click
      }.to change { Mariage.count }.by(1)
      # 投稿完了ページに遷移することを確認する
      expect(current_path).to eq(root_path)
      # トップページには先ほど投稿した内容のマリアージュが存在することを確認する（画像）
      expect(page).to have_selector("img[src$='test_image.jpg']")
      # トップページには先ほど投稿した内容のマリアージュが存在することを確認する（テキスト）
      expect(page).to have_content(@mariage_title)
    end
  end
  context 'マリアージュ投稿ができないとき'do
    it 'ログインしていないと新規投稿ページに遷移できない' do
      # トップページに遷移する
      visit root_path
      # 新規投稿ページへのボタンがないことを確認する
      expect(page).to have_no_content('New Mariage')
    end
  end
end
RSpec.describe 'マリアージュ編集', type: :system do
  before do
    @mariage1 = FactoryBot.create(:mariage)
    @mariage2 = FactoryBot.create(:mariage)
    @image_path2 = Rails.root.join('public/images/test_image2.jpg')
    sleep 0.1
  end
  context 'マリアージュ編集ができるとき' do
    it 'ログインしたユーザーは自分が投稿したマリアージュの編集ができる' do
      # マリアージュ1を投稿したユーザーでログインする
      sign_in(@mariage1.user)
      # マリアージュ1の詳細ページに移動する
      visit mariage_path(@mariage1)
      # 詳細ページに「編集」へのリンクがあることを確認する
      expect(page).to have_link '編集', href: edit_mariage_path(@mariage1)
      # 編集ページへ遷移する
      visit edit_mariage_path(@mariage1)
      # すでに投稿済みの内容がフォームに入っていることを確認する
      expect(
        find('#mariage_title').value
      ).to eq(@mariage1.title)
      expect(
        find('#mariage_text').value
      ).to eq(@mariage1.text)
      # 投稿内容を編集する
      fill_in 'mariage_text', with: "#{@mariage1.text}+編集したテキスト"
      attach_file('mariage[image]', @image_path2, make_visible: true)
      # 編集してもMariageモデルのカウントは変わらないことを確認する
      expect{
        find('input[class="form-btn"]').click
      }.to change { Mariage.count }.by(0)
      # 詳細画面に遷移したことを確認する
      expect(current_path).to eq(mariage_path(@mariage1))
      # 詳細画面には先ほど変更した内容のマリアージュが存在することを確認する（画像）
      expect(page).to have_selector("img[src$='test_image2.jpg']")
      # 詳細画面には先ほど変更した内容のマリアージュが存在することを確認する（テキスト）
      expect(page).to have_content("#{@mariage1.text}+編集したテキスト")
    end
  end
  context 'マリアージュ編集ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿したマリアージュの編集画面には遷移できない' do
      # マリアージュ1を投稿したユーザーでログインする
      sign_in(@mariage1.user)
      # マリアージュ2の詳細ページに移動する
      visit mariage_path(@mariage2)
      # マリアージュ2に「編集」へのリンクがないことを確認する
      expect(page).to have_no_link '編集', href: edit_mariage_path(@mariage2)
    end
    it 'ログインしていないとマリアージュの編集画面には遷移できない' do
      # トップページにいる
      visit root_path
      # マリアージュ1の詳細ページに移動する
      visit mariage_path(@mariage1)
      # マリアージュ1に「編集」へのリンクがないことを確認する
      expect(page).to have_no_link '編集', href: edit_mariage_path(@mariage1)
      # マリアージュ2の詳細ページに移動する
      visit mariage_path(@mariage2)
      # マリアージュ2に「編集」へのリンクがないことを確認する
      expect(page).to have_no_link '編集', href: edit_mariage_path(@mariage2)
    end
  end
end
RSpec.describe 'マリアージュ削除', type: :system do
  before do
    @mariage1 = FactoryBot.create(:mariage)
    @mariage2 = FactoryBot.create(:mariage)
    sleep 0.1
  end
  context 'mariage削除ができるとき' do
    it 'ログインしたユーザーは自らが投稿したマリアージュの削除ができる' do
    # マリアージュ1を投稿したユーザーでログインする
    sign_in(@mariage1.user)
    # マリアージュ1の詳細ページに移動する
    visit mariage_path(@mariage1)
    # マリアージュ1に「削除」へのリンクがあることを確認する
    expect(page).to have_link '削除', href: mariage_path(@mariage1)
    # 投稿を削除するとレコードの数が1減ることを確認する
    expect{
      find_link('削除', href: mariage_path(@mariage1)).click
    }.to change { Mariage.count }.by(-1)
    # トップページに遷移したことを確認する
    expect(current_path).to eq(root_path)
    # トップページにはマリアージュ1の内容が存在しないことを確認する（タイトル）
    expect(page).to have_no_content("#{@mariage1.title}")
    end
  end
  context 'マリアージュ削除ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿したマリアージュの削除ができない' do
      # マリアージュ1を投稿したユーザーでログインする
      sign_in(@mariage1.user)
      # マリアージュ2の詳細ページに移動する
      visit mariage_path(@mariage2)
      # マリアージュ2に「削除」へのリンクがないことを確認する
      expect(page).to have_no_link '削除', href: mariage_path(@mariage2)
    end
    it 'ログインしていないとマリアージュの削除ボタンがない' do
      # トップページに移動する
      visit root_path
      # マリアージュ1の詳細ページに移動する
      visit mariage_path(@mariage1)
      # マリアージュ1に「削除」へのリンクがないことを確認する
      expect(page).to have_no_link '削除', href: mariage_path(@mariage1)
      # マリアージュ2の詳細ページに移動する
      visit mariage_path(@mariage2)
      # マリアージュ2に「削除」へのリンクがないことを確認する
      expect(page).to have_no_link '削除', href: mariage_path(@mariage2)
    end
  end
end
RSpec.describe 'マリアージュ詳細', type: :system do
  before do
    @mariage = FactoryBot.create(:mariage)
  end
  it 'ログインしたユーザーはマリアージュ詳細ページに遷移してコメント投稿欄が表示される' do
    # ログインする
    sign_in(@mariage.user)
    # 詳細ページに遷移する
    visit mariage_path(@mariage)
    # 詳細ページにマリアージュの内容が含まれている
    expect(page).to have_selector ("img[src$='test_image.jpg']")
    expect(page).to have_content("#{@mariage.title}")
    expect(page).to have_content("#{@mariage.text}")
    # コメント用のフォームが存在する
    expect(page).to have_selector'input[id="comment_text"]'
  end
  it 'ログインしていない状態でマリアージュ詳細ページに遷移できるもののコメント投稿欄が表示されない' do
    # トップページに移動する
    visit root_path
    # 詳細ページに遷移する
    visit mariage_path(@mariage)
    # 詳細ページにマリアージュの内容が含まれている
    expect(page).to have_selector ("img[src$='test_image.jpg']")
    expect(page).to have_content("#{@mariage.title}")
    expect(page).to have_content("#{@mariage.text}")
    # フォームが存在しないことを確認する
    expect(page).to have_no_selector 'input[id="comment_text"]'
    # 「コメントの投稿には新規登録/ログインが必要です」が表示されていることを確認する
    expect(page).to have_content 'コメントの投稿には新規登録/ログインが必要です'
  end
end
