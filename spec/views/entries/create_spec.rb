require File.join(File.dirname(__FILE__), "..", "..", "spec_helper.rb")

describe "entries/create" do

  before(:each) do
    Ambethia::ReCaptcha.public_key  = '0000000000000000000000000000000000000000'
    Ambethia::ReCaptcha.private_key = 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'

    @controller = Entries.new(fake_request)

    @controller.extend(SessionHelper)
    @controller.session = {}
    
    @entry = Entry.new
    @entry.author = "Nobody"
    @entry.email = "nobody@nowhere.com"
    @entry.text = "Hello"
    @entry.created_at = Time.now

    @controller.instance_variable_set(:@entry, @entry)
    @body = @controller.render(:create)
  end

  it "should have a form to create new posts" do
    form_create_post_present?(@body)
  end
  
  after(:each) do
    Entry.destroy_all
  end
  
end
