require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

# Order matters!
use Rack::MethodOverride
use UserController
use ItemController
run ApplicationController
