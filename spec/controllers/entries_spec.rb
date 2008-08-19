require File.join(File.dirname(__FILE__), "..", 'spec_helper.rb')

describe Entries, "#index" do
  it "should respond correctly" do
    dispatch_to(Entries, :index).should respond_successfully
  end
end

describe Entries, "#create" do
  before(:each) do
    entry           = { :entry => { :author => "nobody", :email => "nobody@nowhere.com", :text => "It was a good game though" } }
    @params_preview = { :preview_button => '' }.merge!(entry)
    @params_post    = { :post_button    => '' }.merge!(entry)
  end

  it "should redirect to #index after successfully creating a Post" do
      lambda {
        dispatch_to(Entries, :create, @params_post).should redirect_to("/entries/index")
      }.should change(Entry, :count)
  end

  it "should respond correctly if previewing" do
    dispatch_to(Entries, :create, @params_preview).should respond_successfully
  end

end
