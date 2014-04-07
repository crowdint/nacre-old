require 'spec_helper'

describe Nacre::API::Contact do
  let(:connection) { double('connection') }

  before do
    Nacre::API::Contact.stub(:connection).and_return(connection)
  end

  context 'when instantiated with no data' do
    let(:model) { Nacre::API::Contact.new }

    it 'creates an instance' do
      model.should be_a(Nacre::API::Contact)
    end
  end

  context 'when instantiated with valid data' do
    let(:valid_params) {}

    let(:model) { Nacre::API::Contact.new(valid_params) }

    describe 'initialization' do
      it 'creates an instance' do
        model.should be_a(Nacre::API::Contact)
      end

      it 'have a list of fields' do
        model.class.fields.should == [
          :id, :contact_id, :first_name, :last_name, :communication
        ]
      end
    end
  end

end

