require "content/pipeline"

module ApplicationHelper
  MarkdownProcessor = Content::Pipeline.new([
    Content::Pipeline::Filters::Markdown
  ])

  def login_logout_link
    if ! @account.guest?
      then content_tag(:li, link_to("Logout, #{@account.name}", :auth_logout))
    else
      content_tag(:li, link_to("Login with Github",
        :auth_github, "data-for-modal" => "login-modal"))
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

  def _step_helper(num, msg, where = nil)
    msg = "Step #{num}: #{msg}"

    if ! where
      then return msg
      else link_to msg, where
    end
  end

  def markdown(content)
    MarkdownProcessor.filter(content)
  end
end
