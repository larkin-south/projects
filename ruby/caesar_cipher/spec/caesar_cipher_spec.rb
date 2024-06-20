require './lib/caesar_cipher'

describe "#ord_values" do
  it "output should not be a char type" do
    expect((ord_values('I')).not_to be_a(Symbol))
  end
end