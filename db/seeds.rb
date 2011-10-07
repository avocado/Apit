# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

Page.create(:permalink=>'root',:title=>"ROOT",:content=>"Lege pagina") if Page.find_by_permalink('root').nil?

Role.create(:name=>'webmaster') if Role.find_by_name('webmaster').nil?
admin = Role.create(:name=>'administrator') if Role.find_by_name('administrator').nil?

user=User.create(:first_name=>"Big", :last_name=>"Boss",:email=>"big@boss.com",:password=>"bigboss") if User.find_by_email('big@boss.com').nil?

user.roles<<admin
user.save