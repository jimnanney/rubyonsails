class Submission < ActiveRecord::Base
  self.class.send(:attr_accessor, :running_single_current)
  [:comments, :votes].map { |f| has_many f, :dependent => :destroy }
  [:title   , :text ].map { |f| validates_presence_of f }
  belongs_to :account

  # ---------------------------------------------------------------------------
  # Clean up before we save, so that they only have one current submission but
  # the old should be preserved for auditing purposes if an issue ever arises.
  # ---------------------------------------------------------------------------

  before_save :single_current
  private
  def single_current
    with_running(__method__) do
      self.account.submissions.where(:current => true).each do |s|
        s.update(:current => false)
      end
    end
  end

  # ---------------------------------------------------------------------------
  # Allows you to set a running state on the class so that you can avoid stack
  # errors when you loop over yourself like a madman.  Some might say to
  # disable callbacks, but IMO that is not smart because what if we need?
  # ---------------------------------------------------------------------------

  private
  def with_running(var, s = self.class, &block)
    unless s.send("running_#{var}") || ! s.send("running_#{var}=", true)
      yield
    end
  ensure
    # Don't break, because it's bad.
    s.send("running_#{var}=", false)
  end
end
