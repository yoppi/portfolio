# Hash Open class
class Hash
  # To access 'value' with 'key' method.
  #   {:key => value }.key
  def method_missing(method, *args)
    if self.has_key?(method)
      self[method]
    elsif self.has_key?(method.to_s)
      self[method.to_s]
    end
  end
end
