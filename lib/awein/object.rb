class Object

  def to_hms
    Time.at(self.to_f).utc.strftime("%H:%M:%S")
  end

  def to_normal_time
    self.strftime("%H:%M %p")
  end

  def rcall(*args)
    options = {:d => nil}.merge(args.last.is_a?(Hash) ? args.pop : {})
    target = self

    while target && m = args.shift
      target = target.send(m) if target.respond_to?(m)
    end

    return target if target
    return options[:d].call if options[:d].respond_to? :call
    return options[:d]
  end

  def is?(other_object)
    self == other_object
  end

  def is_not?(other_object)
    self != other_object
  end

end
