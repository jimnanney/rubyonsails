require "content/pipeline"

module ApplicationHelper
  MarkdownProcessor = Content::Pipeline.new([
    Content::Pipeline::Filters::Markdown
  ])

  def main_links
    out = "".html_safe
    out += content_tag :ul do
      case @account.account_type
        when :submitter then submission_link
        when :admin     then admin_links
      end
    end
  end

  def admin_links
    out = "".html_safe
    if @account.account_type == :admin
      out += content_tag :li do
        link_to "Manage Users", :admin_users
      end
    end
  out
  end

  def submission_link
    out = "".html_safe
    if @account.account_type == :submitter
      if @account.submissions.any?
        out += content_tag :li do
          link_to "Review Submission", :submission
        end
      else
        out += content_tag :li do
          link_to "Create Submission", :submission_new
        end
      end
    end
  out
  end

  def login_logout_account_links
    out  = "".html_safe
    out += content_tag :ul do
      if @account.guest?
        out += content_tag :li do
          link_to "Login with Github", :auth_github
        end
      else
        account = @account.name
        out += content_tag(:li, link_to("Edit Account", :account))
        out += content_tag(:li, link_to("Logout, #{account}", :auth_logout))
      end
    end
  out
  end

  private
  def nav_link(title, to)
    content_tag :li do
      out = content_tag :i,
          "<!-- EMPTY -->".html_safe, {
        :class => "glyphicon glyphicon-step-forward"
      }

      link_to out + title, to
    end
  end

  def flash_messages(opts = {})
  out = "".html_safe
    if flash.any?
      out =
        content_tag(:div, :class => "alerts text-center") do
          flash.map { |k, v|
            content_tag :p, v.html_safe, :class => k }.join("\n").html_safe
        end

      flash.clear
    end
  out
  end

  def markdown(content)
    MarkdownProcessor.filter(content)
  end
end
