cumulus_location = File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "..", "cumulus"))

execute "clone cumulus repo" do
  not_if "test -d #{cumulus_location}"
  command "git clone https://github.com/OpenRTMFP/Cumulus.git #{cumulus_location}"
end

template "#{cumulus_location}/CumulusLib/Makefile" do
  source "CumulusLib-Makefile"
  owner "root"
  group "staff"
  mode 0640
end

template "#{cumulus_location}/CumulusService/Makefile" do
  source "CumulusService-Makefile"
  owner "root"
  group "staff"
  mode 0640
end

script "build cumulus" do
  interpreter "bash"
  cwd cumulus_location
  code <<-SH
  cd CumulusLib
  make
  cd ../CumulusService
  make
  echo "****************************************************"
  echo "****************************************************"
  echo "****************************************************"
  echo "Change ownership of #{cumulus_location} to your normal user before running the service!"
  echo "Otherwise it will abort trap."
  echo "****************************************************"
  echo "****************************************************"
  echo "****************************************************"
  SH
end

