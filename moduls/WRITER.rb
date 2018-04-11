module Writer
  class ::File
    def write_line(str)
      write(str)
      write("\n")
    end

    def arr_write(arr)
      arr.each do |word|
        write_line(word)
      end
    end
  end
end
