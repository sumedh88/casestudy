current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "sumedh"
client_key               "#{current_dir}/sumedh.pem"
chef_server_url          "https://10.51.237.155/organizations/psl"
cookbook_path            ["#{current_dir}/../cookbooks"]
validation_client_name   "persistent-validator"
validation_key           "#{current_dir}/persistent-validator.pem"
syntax_check_cache_path  "#/home/devops/chef-repo/.chef/syntax_check_cache"
cookbook_path            ["/home/devops/chef-repo/cookbooks"]

no_proxy                 'localhost,127.0.0.1,10.51.237.155,hj-ibmibm4486,local.home'
http_proxy               'http://sumedh_surlekar:Titan1988@hjproxy.persistent.co.in:8080'
https_proxy              'https://sumedh_surlekar:Titan1988@hjproxy.persistent.co.in:8080'
ssl_verify_mode          :verify_none
