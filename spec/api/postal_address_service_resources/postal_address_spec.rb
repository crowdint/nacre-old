require 'spec_helper'

describe Nacre::API::PostalAddress do
  let(:response_json) { IO.read('spec/fixtures/json/postal_address_post.json') }

  let(:response) do
    response = double('response')
    response.stub(:body) { response_json }
    response
  end

  let(:connection) do
    connection = double('connection')
    connection.stub(:post) { response }
    connection
  end

  before do
    Nacre::API::PostalAddress.stub(:connection).and_return(connection)
  end

  describe '.create' do
    it 'returns the contact id' do
      described_class.create({}).should eq({ id: 200 })
    end
  end
end


