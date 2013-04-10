class Hash
  # To access 'value' with 'key' method.
  #   {:key => value }.key
  def method_missing(method, *args)
    ret = self[method] || self[method.to_s]
    return ret if ret
    super
  end
end
