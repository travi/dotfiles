require 'spec_helper'

describe file('/home/vagrant/dotfiles/.gitattributes') do
    its(:content) { should match(/\* text=auto/) }
end

describe file('/home/vagrant/.files') do
  it { should be_symlink }
end
