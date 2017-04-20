  module Writer
  class ::File
    def yaz(str)
      self.write(str)
      self.write("\n")
    end
    def arr_write(arr)
      arr.each do |word|
        self.yaz(word)
     end
    end
  end
end
