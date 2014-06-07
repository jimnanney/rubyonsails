module StringExtends
  UUIDRegexp = \
    /\A[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}\Z/

  def valid_uuid?
    self =~ UUIDRegexp ? true : false
  end

  # -------------------------------------------------------------------
  # Because Ruby fucking sucks at dealing with Invalid UTF-8 (mostly
  # because it's impossible to have a sane default here...) we create
  # our own fixer so that we can block out shitty UTF-8 chars.
  # -------------------------------------------------------------------

  def fix_utf8
    self.encode!("utf-8", {
      :invalid => :replace,
      :replace => "<Invalid:UTF-8>"
    })
  end

  def to_slug
    self.gsub(/[^A-Za-z\-0-9]/, "-").gsub(/-{2,}/, "-").gsub(/-\Z/, "").downcase
  end
end

String.send(:include, StringExtends)
