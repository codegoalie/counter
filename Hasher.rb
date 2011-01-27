class Hasher
  ALLOWED_CHARS = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

  def self.encode(id)
    length = ALLOWED_CHARS.length
    
    while id > length -1
      hash = ALLOWED_CHARS[id % length,1].concat( hash || "" )
      id = (id / length).floor
    end

    ALLOWED_CHARS[id,1].concat(hash || "")
  end

  def self.decode(hash)
    length = ALLOWED_CHARS.length
    size = hash.length - 1
    array = hash.each_char.collect
    id = ALLOWED_CHARS.index(array.pop)
    i = 0
    array.each do |c| 
      id += ALLOWED_CHARS.index(c) * (length ** (size - i))
      i += 1
    end
    id
  end
end
