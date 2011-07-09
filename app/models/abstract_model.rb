class AbstractModel
  def self.cache_key(name)
    "#{self}:#{name}"
  end
end
