class Array
  def average
    self.sum.to_f / self.length
  end

  def symbolize_keys_recursive
    inject([]) do |options, value|
      value = value.symbolize_keys_recursive if value.instance_of? Hash
      value = value.symbolize_keys_recursive if value.instance_of? Array
      options << value
      options
    end
  end
end
