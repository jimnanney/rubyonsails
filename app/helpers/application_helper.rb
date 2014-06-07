module ApplicationHelper
  def gravatar_for(user)
    return "" unless user.present? && user.is_a?(User)
    gid = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gid}"
    image_tag(gravatar_url, :alt => user.name, :class => "gravatar")
  end
end
