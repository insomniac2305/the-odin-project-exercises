require "./lib/caesar_cipher"

describe CaesarCipher do
  describe "#caesar_cipher" do
    
    it "rotates given letters by the given key" do
      expect(subject.caesar_cipher("abc", 3)).to eql("def")
    end

    it "works case sensitive" do
      expect(subject.caesar_cipher("HeLlo", 1)).to eql("IfMmp")
    end

    it "keeps empty spaces" do
      expect(subject.caesar_cipher("This is a test", 2)).to eql("Vjku ku c vguv")
    end

    it "keeps special characters" do
      expect(subject.caesar_cipher("!.?&%$", 7)).to eql("!.?&%$")
    end

    it "works with an empty string" do
      expect(subject.caesar_cipher("", 15)).to eql("")
    end

    it "works with a negative key" do
      expect(subject.caesar_cipher("Now backwards", -5)).to eql("Ijr wvxfrvmyn")
    end

    it "works with a key > 26" do
      expect(subject.caesar_cipher("Round it goes", 35)).to eql("Axdwm rc pxnb")
    end
  end
end