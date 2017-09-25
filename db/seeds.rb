User.create(
  :username => 'bob',
  :email => 'bob@bob.com',
  :password => 'bob',
  :location => 'NYC',
  :img => "https://vignette2.wikia.nocookie.net/gurennlagann/images/f/fa/Gurren.png/revision/latest?cb=20161103020841",
  :details => "his name is Bob"
  )
User.create(:username => 'silly', :email => 'silly@bob.com', :password => 'silly', :location => 'NYC', :img => "http://static.tvtropes.org/pmwiki/pub/images/antispiral_7468.jpg", :details => "his name is silly")
User.create(:username => 'phil', :email => 'phil@bob.com', :password => 'phil', :location => 'NYC', :img=> "https://vignette2.wikia.nocookie.net/gurennlagann/images/a/a4/Viral.jpg/revision/latest/scale-to-width-down/640?cb=20091110170159", :details => "his name is phil")

Item.create(:user_id=>1, :name=>"Nike shoes", :condition => "new", :item_type => "shoes", :img => "https://media.kohlsimg.com/is/image/kohls/2940131_Gray_Black", :desc=>"Some desc", :current_possessor_user_id => 3)
Item.create(:user_id=>2, :name=>"Blue shirt", :condition => "lightly used", :item_type => "shirt", :img => "https://wordans-mxelda46illwc0hq.netdna-ssl.com/wordansfiles/model_specifications/2015/8/28/117441/117441_big.jpg?1440803233", :desc=>"Extra blue dye infusion", :current_possessor_user_id => 2)
Item.create(:user_id=>3, :name=>"Red Hat", :condition => "worn", :item_type => "accessory", :img => "http://www.mcivorwoodworks.com/images/red%20maple%20bowl%20%20upside%20down.JPG", :desc=>"Haha!", :current_possessor_user_id => 2)

Review.create(:user_id=>2, :item_id=>1, :review=>"These shoes rock!")
Review.create(:user_id=>1, :item_id=>2, :review=>"This shirt is too blue!")
Review.create(:user_id=>2, :item_id=>3, :review=>"This hat is just a bowl!")
Review.create(:user_id=>3, :item_id=>1, :review=>"These shoes rock, indeed!")
Review.create(:user_id=>1, :item_id=>3, :review=>"How is this a hat?")
