class Hash
  # To access 'value' with 'key' method.
  #   {:key => value }.key
  def method_missing(method, *args)
    if self.has_key?(method)
      return self[method]
    elsif self.has_key?(method.to_s)
      return self[method.to_s]
    end
    super
  end
end
