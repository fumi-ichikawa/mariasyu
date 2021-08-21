require 'rails_helper'

RSpec.describe 'コメント投稿', type: :system do
  before do
    @mariage = FactoryBot.create(:mariage)
    @comment = Faker::Lorem.sentence
    sleep 0.1
  end

  it 'ログインしたユーザーはマリアージュ詳細ページでコメント投稿できる' do
    # ログインする
    sign_in(@mariage.user)
    # ツイート詳細ページに遷移する
    visit mariage_path(@mariage)
    # フォームに情報を入力する
    fill_in 'comment_text', with: @comment
    # コメントを送信すると、Commentモデルのカウントが1上がることを確認する
    expect  do
      find('input[class="commenr__btn"]').click
    end.to change { Comment.count }.by(1)
    # 詳細ページにリダイレクトされることを確認する
    expect(current_path).to eq(mariage_path(@mariage))
    # 詳細ページ上に先ほどのコメント内容が含まれていることを確認する
    expect(page).to have_content @comment
  end
end
