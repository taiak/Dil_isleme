# turkce kelimelerin siralanmasi icin duzenlenecek
# 250 kelimeden fazlasi icin hata veriyor
# hash benzeri bir yapiyla kullanilabilir
# FIXME: optimize bir cozum bulunacak!

module SortTurkish
  class ::Array
    attr_reader :CHARS
    CHARS = "0123456789AaÂâBbCcCcDdEeFfGgGgHhIiÎîIiJjK
            kLlMmNnOoOoPpQqRrSsSsTtUuÛûUuVvWwYyZz".freeze
    ASCII_CHARS = "0123456789AÂBCCDEFGGHIÎIJKLMNOOPQRSSTUÛUVWYZ
            aâbccdefgghiîijklmnoopqrsstuûuvwyz".freeze
    def sirala
      sort_by do |item|
        if item.is_a?(String)
          item.chars.map { |ch| CHARS.index(ch) }
        else
          super
        end
      end
    end

    def sirala!
      replace(sirala)
    end
  end
end
