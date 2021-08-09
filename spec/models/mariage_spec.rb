require 'rails_helper'

RSpec.describe Mariage, type: :model do
  describe '#create' do
    before do
      @mariage = FactoryBot.build(:mariage)
    end

    describe '新規マリアージュ投稿' do
      context '新規投稿できるとき' do
        it '全ての項目が入力されていれば登録できること' do
          expect(@mariage).to be_valid
        end
      end

      context '新規投稿できないとき' do
        it 'user情報がない場合は登録できないこと' do
          @mariage.user = nil
          @mariage.valid?
          expect(@mariage.errors.full_messages).to include('User must exist')
        end

        it 'imageが空では登録できないこと' do
          @mariage.image = nil
          @mariage.valid?
          expect(@mariage.errors.full_messages).to include("Image can't be blank")
        end

        it 'titleが空では登録できないこと' do
          @mariage.title = ''
          @mariage.valid?
          expect(@mariage.errors.full_messages).to include("Title can't be blank")
        end

        it 'textが空では登録できないこと' do
          @mariage.text = ''
          @mariage.valid?
          expect(@mariage.errors.full_messages).to include("Text can't be blank")
        end

        it 'categoryが空では登録できないこと' do
          @mariage.category_id = 1
          @mariage.valid?
          expect(@mariage.errors.full_messages).to include("Category can't be blank")
        end

        it 'tasteが空では登録できないこと' do
          @mariage.taste_id = 1
          @mariage.valid?
          expect(@mariage.errors.full_messages).to include("Taste can't be blank")
        end
      end
    end
  end
end
