require File.join(File.dirname(__FILE__), "..", 'spec_helper.rb')

describe Admin::Entries, "admin/ route" do
  it "should redirect to admin/entries/index" do
    request_to("/admin", :get).should route_to("Admin/entries", :index)
  end
end

describe Admin::Entries, "#index" do
  it "should respond correctly" do
    dispatch_to(Admin::Entries, :index).should respond_successfully
  end
end

describe Admin::Entries, "#delete" do
  
  it "should raise error on non existing entry" do 
    params = { :id => -1}  
    lambda { 
      dispatch_to(Admin::Entries, :delete, params)
    }.should raise_error(Merb::ControllerExceptions::NotFound)
  end
  
  it "sould delete existing entry" do
    entry = Entry.new(:author => "Herbert Herbert", :email => "herbert@herbert.de", :text => "Herbert Herbert text")
    entry.save
    params = { :id => entry.id}
    dispatch_to(Admin::Entries, :delete, params).should redirect_to("/admin/entries/index")
  end
  
  after(:each) do
    Entry.destroy_all
  end
end

describe Admin, "#toggle_show" do
  it "should raise error on non existing entry" do 
    params = { :id => -1}  
    lambda { 
      dispatch_to(Admin::Entries, :toggle_show, params)
    }.should raise_error(Merb::ControllerExceptions::NotFound)
  end
  
  it "sould toggle show value for existing entry" do
    entry = Entry.new(:author => "Herbert Herbert", :email => "herbert@herbert.de", :text => "Herbert Herbert text")
    entry.save
    params = { :id => entry.id}
    x = entry.show
    dispatch_to(Admin::Entries, :toggle_show, params).should redirect_to("/admin/entries/index")
    x.should != entry.show
  end

  after(:each) do
    Entry.destroy_all
  end
end

describe Admin, "#edit" do

  before(:each) do
    @original_column_author = "nobody"
    @original_column_email  = "nobody@nowhere.com"
    @original_column_text   = "It was a good game though"

    @changed_column_author = "Hans Hans"
    @changed_column_email  = "hans@hans.de"
    @changed_column_text   = "Hans Hans text"
    @changed_entry_params  = { :author => @changed_column_author, :email => @changed_column_email, :text => @changed_column_text }

    @entry = Entry.new(:author => @original_column_author, :email => @original_column_email, :text => @original_column_text)
  end

  it "should raise error on non existing entry" do 
    params = { :id => -1}  
    lambda { 
      dispatch_to(Admin::Entries, :edit, params)
    }.should raise_error(Merb::ControllerExceptions::NotFound)
  end
  
  it "should respond correctly" do
    @entry.save
    params = { :id => @entry.id }
    dispatch_to(Admin::Entries, :edit, params).should respond_successfully
  end

  it "should redirect to admin/index" do
    @entry.save
    params = { :id => @entry.id, :entry => @changed_entry_params, :post_button => ""}
    dispatch_to(Admin::Entries, :edit, params).should redirect_to("/admin/entries/index")
  end

  it "should change author" do
    @entry.save
    params = { :id => @entry.id, :entry => @changed_entry_params, :post_button => ""}
    lambda { 
      dispatch_to(Admin::Entries, :edit, params)
    }.should change{ Entry.find(@entry.id).author }.from(@original_column_author).to(@changed_column_author)
  end

  it "should change email" do
    @entry.save
    params = { :id => @entry.id, :entry => @changed_entry_params, :post_button => ""}
    lambda { 
      dispatch_to(Admin::Entries, :edit, params)
    }.should change{ Entry.find(@entry.id).email }.from(@original_column_email).to(@changed_column_email)
  end

  it "should change text" do
    @entry.save
    params = { :id => @entry.id, :entry => @changed_entry_params, :post_button => ""}
    lambda { 
      dispatch_to(Admin::Entries, :edit, params)
    }.should change{ Entry.find(@entry.id).text }.from(@original_column_text).to(@changed_column_text)
  end

  after(:each) do
    Entry.destroy_all
  end
end
