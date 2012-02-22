load 'deploy' if respond_to?(:namespace) # cap2 differentiator
Dir['vendor/plugins/*/recipes/*.rb'].each { |plugin| load(plugin) }

load 'config/deploy' # remove this line to skip loading any of the  test

# found this lines to precompite assets
after 'deploy:update_code' do
  ...
  run "cd #{release_path}; RAILS_ENV=production rake assets:precompile"
end
# not here but in nginx.conf
# location ~* ^/assets {
  # expires max;
  # add_header Cache-Control public;
  # break;
# }