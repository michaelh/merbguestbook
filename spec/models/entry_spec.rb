require File.join( File.dirname(__FILE__), "..", "spec_helper" )

module EntrySpecHelper
  def valid_entry_attributes
    { :author => 'nobody',
      :email  => 'nobody@nowhere.com',
      :text   => 'An entry to your guestbook!' }
  end
end


describe Entry do
  include EntrySpecHelper

  before(:each) do
    @entry = Entry.new
  end
  
  it "should NOT be valid when new" do
    @entry.should_not be_valid
  end

  it "should require at least two body characters to be valid" do
    @entry.attributes = valid_entry_attributes.except(:text)
    @entry.should_not be_valid
    @entry.errors.on(:text).should include(Entry::ERROR_TEXT_TOO_SHORT)
    @entry.text = "Some text"
    @entry.should be_valid
  end

  it "should have an author" do
    @entry.attributes = valid_entry_attributes.except(:author)
    @entry.should_not be_valid
    @entry.errors.on(:author).should include(Entry::ERROR_AUTHOR_NOT_PRESENT)
    @entry.author = "nobody"
    @entry.should be_valid
  end

  it "should have a valid e-mail address" do
    @entry.attributes = valid_entry_attributes.except(:email)
    @entry.should_not be_valid
    @entry.errors.on(:email).should include(Entry::ERROR_EMAIL_INVALID)
    @entry.email = "nobody@nowhere.com"
    @entry.should be_valid
  end

end
