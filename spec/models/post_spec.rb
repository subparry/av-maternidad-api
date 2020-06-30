require 'rails_helper'

RSpec.describe Post, type: :model do
  context 'creation' do
    context 'with invalid data' do
      context 'raises exception when' do
        
      
      it 'missing title' do
        expect {create(:post, title: '')}.to raise_error(ActiveRecord::ActiveRecordError)
      end

      it 'missing body' do
        expect {create(:post, body: '')}.to raise_error(ActiveRecord::ActiveRecordError)
      end

      it 'post is not associated to admin' do
        expect {create(:post, admin_id: nil)}.to raise_error(ActiveRecord::ActiveRecordError)
      end
    end
    end

    context 'with valid data' do
      it 'creates post correctly with title and body but without image' do
        expect {create(:post, image: nil)}.not_to raise_error
      end

      it 'creates post correctly with title, body and image' do
        expect {create(:post)}.not_to raise_error
      end
    end
  end
end
