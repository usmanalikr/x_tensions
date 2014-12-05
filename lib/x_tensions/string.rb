
class String
  def humanize
    result = self.to_s.dup
    result.gsub(/_/, " ").capitalize
  end

  def to_utf8
    self.encode!('UTF-16', 'UTF-8', :invalid => :replace, :replace => '')
    self.encode!('UTF-8', 'UTF-16')
  end

  def ellipsisize(minimum_length=4,edge_length=3)
    return self if self.length < minimum_length or self.length <= edge_length*2
    edge = '.' * edge_length
    mid_length = self.length - edge_length*2
    gsub(/(#{edge}).{#{mid_length},}(#{edge})/, '\1...\2')
  end

  def words
    self.split(/\s+/)
  end

  def urlize
    self.strip.downcase.gsub(/[^a-z]+/, '_')
  end

  def shortize
    self.words.first.downcase
  end

  def to_slug
    ret = self.strip
    ret.gsub! /['`]/,""
    ret.gsub! /\s*@\s*/, " at "
    ret.gsub! /\s*&\s*/, " and "
    ret.gsub! /\s*\.\.\.\s*/, "  "
    ret.gsub! /\s*\.\s*/, " dot "
    ret.gsub! /\s*\#\s*/, " hash "
    ret.gsub! /\s*\+\s*/, " plus "
    ret.gsub! /\s*[^A-Za-z0-9\.\-]\s*/, '-'
    ret.gsub! /-+/,"-"
    ret.gsub! /\A[-\.]+|[-\.]+\z/,""
    ret.downcase!

    {
      }[ret] || ret
    end
  end
