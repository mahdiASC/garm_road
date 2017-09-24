User.create(:username => 'bob', :email => 'bob@bob.com', :password => 'bob', :location => 'NYC', :img => "http://via.placeholder.com/150x150", :details => "his name is Bob")
User.create(:username => 'silly', :email => 'silly@bob.com', :password => 'silly', :location => 'NYC', :img => "http://via.placeholder.com/150x150", :details => "his name is silly")
User.create(:username => 'phil', :email => 'phil@bob.com', :password => 'phil', :location => 'NYC', :img => "http://via.placeholder.com/150x150", :details => "his name is phil")

Item.create(:user_id=>1, :name=>"Nike shoes", :condition => "new", :item_type => "shoes", :img => "http://via.placeholder.com/300x300", :current_possessor_user_id => 3)
Item.create(:user_id=>2, :name=>"Blue shirt", :condition => "lightly used", :item_type => "shirt", :img => "http://via.placeholder.com/300x300", :current_possessor_user_id => 2)
Item.create(:user_id=>3, :name=>"Red Hat", :condition => "worn", :item_type => "accessory", :img => "http://via.placeholder.com/300x300", :current_possessor_user_id => 2)

Review.create(:user_id=>2, :item_id=>1, :review=>"These shoes rock!")
Review.create(:user_id=>1, :item_id=>2, :review=>"This shirt is too blue!")
Review.create(:user_id=>2, :item_id=>3, :review=>"This hat is just a bowl!")
Review.create(:user_id=>3, :item_id=>1, :review=>"These shoes rock, indeed!")
Review.create(:user_id=>1, :item_id=>3, :review=>"How is this a hat?")
