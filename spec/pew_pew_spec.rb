require 'spec_helper'

describe PewPew do
  subject { described_class }

  PewPew::Client.instance_methods(false).sort.each do |method|
    context "##{method}" do
      it 'responds to method' do
        described_class.should respond_to(method)
      end

      it 'delegates to #client' do
        PewPew::Client.any_instance.should_receive(method)
        described_class.send(method)
      end
    end
  end
end
