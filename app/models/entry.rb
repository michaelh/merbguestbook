require 'merb_paginate/finders/activerecord'

class Entry < ActiveRecord::Base

  PAGINATION_PER_PAGE = 10

  ERROR_AUTHOR_NOT_PRESENT = "ERROR_AUTHOR_NOT_PRESENT"
  ERROR_AUTHOR_TOO_SHORT = "ERROR_AUTHOR_TOO_SHORT"
  ERROR_EMAIL_INVALID = "ERROR_EMAIL_INVALID"
  ERROR_TEXT_TOO_SHORT = "ERROR_TEXT_TOO_SHORT"

  include MerbPaginate::Finders::Activerecord
  
  # gravator support
  include Gravtastic::Model
  has_gravatar

  #before_create :generate_token

  attr_accessible :author, :email, :text

  validates_presence_of :author, :message => ERROR_AUTHOR_NOT_PRESENT
  validates_length_of :author, :minimum => 2, :message => ERROR_AUTHOR_TOO_SHORT

  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,}|localhost)\Z/i, :message => ERROR_EMAIL_INVALID

  validates_length_of :text, :minimum => 2, :message => ERROR_TEXT_TOO_SHORT

  def self.find_recent_entries(pagination_options)
    with_scope(:find => { :conditions => "show = true", :order => "created_at DESC" } ) do
      find(:all, pagination_options)
    end
  end

  def self.find_admin_recent_entries(pagination_options)
    with_scope(:find => {:order => "created_at DESC" } ) do
      find(:all, pagination_options)
    end
  end

  private

  #def generate_token
  #  self.token = Digest::SHA1.hexdigest Time.now.to_s
  #end

end
