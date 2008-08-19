fixture_for(Entry, :first_entry) do
  self.author     = "Michael"
  self.email      = "michael@localhost"
  self.text       = "Greetings from Michael!"
  self.created_at = Time.now
  self.show       = true
end

fixture_for(Entry, :second_entry) do
  self.author     = "Robert"
  self.email      = "robert@localhost"
  self.text       = "Greetings from Robert!"
  self.created_at = Time.now
  self.show       = true
end
