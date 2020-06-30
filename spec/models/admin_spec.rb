require 'rails_helper'

RSpec.describe Admin, type: :model do
  context 'creation' do
    context 'with invalid data' do
      context 'raises exception if' do
        
      
      it 'name not present' do
        expect {create(:admin, name: '')}.to raise_error(ActiveRecord::ActiveRecordError)
      end
      
      it 'email not present' do
        expect {create(:admin, email: '')}.to raise_error(ActiveRecord::ActiveRecordError)
      end

      it 'missing password' do
        expect {create(:admin, password: '', password_confirmation: '')}.to raise_error(ActiveRecord::ActiveRecordError)
      end

      it 'passwords mismatch' do
        expect {create(:admin, password_confirmation: '1234123')}.to raise_error(ActiveRecord::ActiveRecordError)
      end
    end
    end

    context 'with valid data' do
      it 'creates admin user normally' do
        expect {create(:admin)}.not_to raise_error
      end
    end
  end
end
