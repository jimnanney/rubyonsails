class Account < ActiveRecord::Base
  has_many :comments, :dependent => :destroy
  has_many :submissions, :dependent => :destroy
  has_many :votes, :dependent => :destroy

  validates_presence_of :email
  validates_presence_of :name
  validates_presence_of :oauth_token
  validates_uniqueness_of :oauth_uid
  validates_uniqueness_of :email

  attr_accessor :guest

  GuestDefaults = {
    :name  => "Ruby on SailsGuest",
    :email => "guest@rubyonsails.info"
  }

  def make_guest
    disable_privileges
    self.guest  = true
    readonly!
    self
  end

  def guest?
    self.guest || false
  end

  def submitter?
    account_type == :submitter ? true : false
  end

  def account_type
    case true
      when admin?  then :admin
      when reviewer? then :reviewer
    else
      :submitter
    end
  end

  private
  def disable_privileges
    [:admin, :reviewer].each do |t|
      write_attribute(t, false)
    end
  end

  class << self
    def guest
      new(GuestDefaults).make_guest
    end

    def github(o)
      if usr = find_oauth(o)
        then usr
        else create_oauth(o)
      end
    end

    def create_oauth(o)
      Account.create({
        :name => o["info"]["name"],
        :oauth_token => o["credentials"]["token"],
        :email => o["info"]["email"],
        :oauth_uid => o["uid"]
      })
    end

    def find_oauth(o)
      Account.find_by({
        :oauth_uid => o["uid"],
        :oauth_token => o["credentials"]["token"]
      })
    end

    # -------------------------------------------------------------------
    # You send in the same where hash that you would normally except in
    # this case you always get back a record, just in the case of
    # nothing you will get back a new record that is marked readonly.
    # -------------------------------------------------------------------

    def find_account_or_give_guest(args)
      if args.values.any?(&:blank?)
        return guest
      end

      usr = find_by(args)
      usr.present? ? usr : guest
    end
  end
end
