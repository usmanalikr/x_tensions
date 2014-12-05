class Hash
  def evaluate(*args)
    options = {:default => nil}.merge(args.last.is_a?(Hash) ? args.pop : {})
    target = self # Initial target is self.
    while target && key = args.shift
      target = target[key]
    end

    return target if target
    return options[:default]
  end

  def get(*keys)
    return nil if keys.blank?
    self.fetch keys.shift, self.get(*keys)
  end

  def clean
    each do |k, v|
      if v.is_a?(Hash)
        v.clean
      elsif v.to_s.empty?
        delete(k)
      end
    end
  end

  def symbolize_keys_recursive
    inject({}) do |options, (key, value)|
      value = value.symbolize_keys_recursive if value.instance_of? Hash
      value = value.symbolize_keys_recursive if value.instance_of? Array
      options[key.to_sym || key] = value
      options
    end
  end

  def rename_keys(mapping)
    result = {}
    self.map do |k,v|
      mapped_key = mapping[k] ? mapping[k] : k
      result[mapped_key] = v.kind_of?(Hash) ? v.rename_keys(mapping) : v
      result[mapped_key] = v.collect{ |obj| obj.rename_keys(mapping) if obj.kind_of?(Hash)} if v.kind_of?(Array)
    end
    result
  end

end
