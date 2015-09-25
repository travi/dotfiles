git_client 'default' do
  action :install
end

git "/home/vagrant/dotfiles" do
  repository "https://github.com/travi/dotfiles.git"
  reference "master"
  action :sync
end
