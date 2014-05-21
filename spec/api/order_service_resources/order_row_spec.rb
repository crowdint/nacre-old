require 'spec_helper'

describe Nacre::API::OrderRow do
  let(:connection) { double("connection") }
  
  before do
    Nacre::API::OrderRow.stub(:connection).and_return(connection)
  end

  describe "self.create" do
    let(:response_json) { IO.read("spec/fixtures/json/order_row_post.json") }
    
    it "should return order ID" do
      response = double("response")
      response.stub(:body).and_return(response_json)
      connection.should_receive(:post).
        with("/order-service/order/123/row", {}, "{}").
        and_return(response)
      
      order_response = Nacre::API::OrderRow.create(123, {})
      order_response[:id].should == 234
    end
  end
end