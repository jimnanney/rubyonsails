module TitleConcerns
  extend ActiveSupport::Concern

  included do |c|
    before_action :_set_page_title!
  end

  # -------------------------------------------------------------------
  # You'll need to set this up in your coontroller in order for it to
  # work properly (also, see: `self.page_title`):
  #
  #     page_title :action_name, "Page Title"
  #
  # By design (and recommendation) this method only accepts one title.
  # -------------------------------------------------------------------

  private
  def _set_page_title!
    self.class.page_titles ||= {}
    @title = self.class.page_titles[action_name] || ""
    @title = instance_eval(&@title.to_proc) if @title.is_a?(Proc)
  end

  module ClassMethods
    attr_accessor :page_titles

    def page_title(action_name, title)
    self.page_titles ||= {}

      if action_name && title
        title = title.to_s unless title.is_a?(Proc)
        self.page_titles[action_name.to_s.freeze] = title
      end
    end
  end
end
