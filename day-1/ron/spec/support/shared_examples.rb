shared_examples "check init items" do
  it "should init right items size" do
    expect(order.items.size).to eq items.size
  end
end

shared_examples "check result after run calc_price" do
  it "should return right results" do
    order.calc_price!
    expect(order.price).to eq results[:price]
    expect(order.final_price).to eq results[:final_price]
    expect(order.discount).to eq results[:discount]
  end
end