script "download Ejabberd" do
  not_if "test -d /tmp/ejabberd-2.1.6"
  interpreter "bash"
  cwd "/tmp"
  code <<-SH
  curl http://www.process-one.net/downloads/ejabberd/2.1.6/ejabberd-2.1.6.tar.gz -o ejabberd-2.1.6.tar.gz
  tar xzf ejabberd-2.1.6.tar.gz
  SH
end

unless `uname`.strip == 'Darwin'
  user "ejabberd" do
    not_if "grep ejabberd /etc/passwd"
    gid "ejabberd"
    system true
  end
end

script "build Ejabberd" do
  interpreter "bash"
  cwd "/tmp/ejabberd-2.1.6/src"
  code <<-SH
  #{'INSTALLUSER=ejabberd' unless `uname`.strip == 'Darwin'} ./configure --prefix=''
  make install
  SH
end

template "/etc/ejabberd/ejabberd.cfg" do
  source "ejabberd.cfg"
  owner `uname`.strip == 'Darwin' ? "root" : "ejabberd"
  mode 0640
end

