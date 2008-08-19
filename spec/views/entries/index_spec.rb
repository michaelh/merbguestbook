require File.join(File.dirname(__FILE__), "..", "..", "spec_helper.rb")

describe "entries/index" do

  before(:each) do
    Merb::Fixtures.load
    @controller = Entries.new(fake_request)
    
    @controller.extend(SessionHelper)
    @controller.session = {}

    @entries = WillPaginate::Collection.new(1, Entry.per_page)
    @entries << Entry.fixture(:first_entry)
    @entries << Entry.fixture(:second_entry)
    @entries.total_entries = 2

    @entry = Entry.new
    @entry.created_at = Time.now

    @controller.instance_variable_set(:@entries, @entries)
    @controller.instance_variable_set(:@entry, @entry)
    @body = @controller.render(:index)
  end

  it "should have a form to create new posts" do
    form_create_post_present?(@body)
  end
  
  after(:each) do
    Entry.destroy_all
  end
  
end
