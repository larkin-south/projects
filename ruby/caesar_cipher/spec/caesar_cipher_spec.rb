require '../lib/caesar_cipher'

describe "#shifts" do
  subject(:cipher) { caesar_cipher('testing', 5) }

  it "input between 97 & 122" do
    expect(cipher).to receive(:shifts)
  end
end
