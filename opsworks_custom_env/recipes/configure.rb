node[:deploy].each do |app, deploy|
  if node[:custom_env].has_key?(app) && node[:opsworks][:instance][:layers].include?('rails-app')
    ruby_block "application_yml_writer" do

      inner_node = node
      block do
        yml_file_path = ::File.join(inner_node[:deploy][app][:deploy_to], 'current', 'config', 'application.yml')
#        if ::File.exists?(yml_file_path)
        ::File.open(yml_file_path, 'w') do |yml_file|
          yml_file.write(YAML.dump(inner_node[:custom_env][app]))
        end

      end
    end
  end
end
