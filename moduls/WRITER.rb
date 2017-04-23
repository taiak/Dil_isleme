  module Writer
  class ::File
    def write_line(str)
      self.write(str)
      self.write("\n")
    end
    def arr_write(arr)
      arr.each do |word|
        self.write_line(word)
     end
    end
  end
end
