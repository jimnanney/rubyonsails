require "content/pipeline"

module ApplicationHelper
  MarkdownProcessor = Content::Pipeline.new([
    Content::Pipeline::Filters::Markdown
  ])

  def login_logout_account_links
  out = "".html_safe
    if @account.guest?
      then out += content_tag(:li, link_to("Login with Github", :auth_github))
    else
      out += content_tag(:li, link_to("Edit Account", :account))
      out += content_tag(:li, link_to("Logout, #{@account.name}", :auth_logout))
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
