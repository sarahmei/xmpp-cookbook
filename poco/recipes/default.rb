execute "download poco" do
  not_if "test -f /tmp/poco-1.4.1p1.tar.gz"
  command "curl http://surfnet.dl.sourceforge.net/project/poco/sources/poco-1.4.1/poco-1.4.1p1.tar.gz -o /tmp/poco-1.4.1p1.tar.gz"
end

execute "unpack poco" do
  not_if "test -d /tmp/poco-1.4.1p1"
  command "tar xzf /tmp/poco-1.4.1p1.tar.gz -C /tmp"
end

script "build poco" do
  interpreter "bash"
  cwd "/tmp/poco-1.4.1p1"
  code <<-SH
  ./configure --config=Darwin64-clang --prefix=/usr --no-tests --no-samples
  make -s
  sudo make -s install
  SH
end