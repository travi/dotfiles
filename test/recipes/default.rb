git_client 'default' do
  action :install
end

git "/home/vagrant/dotfiles" do
  repository "https://github.com/travi/dotfiles.git"
  reference "master"
  action :sync
end

bash "configure the environment" do
    code ". ./init.sh 0"
    cwd "/home/vagrant/dotfiles/setup"
end
