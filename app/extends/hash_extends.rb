module HashExtends
  def deep_fetch(*names, hash: nil)
    val = (hash || self)[names.shift]
    names.size > 0 ? deep_fetch(*names, hash: val) : val
  end
end

Hash.send(:include, HashExtends)
