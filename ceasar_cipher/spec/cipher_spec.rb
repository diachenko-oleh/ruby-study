require './lib/caesar_cipher'

describe CaesarCipher do
  describe "#caesar_cipher" do
    it "returns the coded message" do
      cipher = CaesarCipher.new
      expect(cipher.caesar_cipher("What a string!", 5)).to eql("Bmfy f xywnsl!")
    end
  end
end