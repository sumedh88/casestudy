log_level                :info
log_location             STDOUT
node_name                'sumedh'
client_key               '/home/devops/chef-repo/.chef/sumedh.pem'
validation_client_name   'psl-validator'
validation_key           '/home/devops/chef-repo/.chef/psl-validator.pem'
chef_server_url          'https://10.51.237.155/organizations/psl'
syntax_check_cache_path  '/home/devops/chef-repo/.chef/syntax_check_cache'
cookbook_path [ '/home/devops/chef-repo/cookbooks' ]
