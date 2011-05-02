# Hash Open class
class Hash
  # To access 'value' with 'key' method.
  #   {:key => value }.key
  def method_missing(method, *args)
    if self.has_key?(method)
      self[method]
    elsif self.has_key?(method.to_sym)
      self[method.to_sym]
    end
  end
end
