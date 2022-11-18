RSpec.describe PewPew do
  [
    Relax::Client.instance_methods(false),
    PewPew::Client.instance_methods(false)
  ].flatten.each do |method|
    it "delegates .#{method} to .client" do
      expect(described_class.send(:client)).to receive(method)

      described_class.send method
    end
  end
end
