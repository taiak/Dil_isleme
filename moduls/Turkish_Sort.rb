# türkçe kelimelerin sıralanması için düzenlenecek
# 250 kelimeden fazlası için hata veriyor
# hash benzeri bir yapıyla kullanılabilir
# FIXME: optimize bir çözüm bulunacak!

module SortTurkish
  class ::Array
    attr_reader :CHARS
    CHARS = "0123456789AaÂâBbCcÇçDdEeFfGgĞğHhIıÎîİiJjK
            kLlMmNnOoÖöPpQqRrSsŞşTtUuÛûÜüVvWwYyZz".freeze
    ASCII_CHARS = "0123456789AÂBCÇDEFGĞHIÎİJKLMNOÖPQRSŞTUÛÜVWYZ
            aâbcçdefgğhıîijklmnoöpqrsştuûüvwyz".freeze
    def sırala
      sort_by do |item|
        if item.is_a?(String)
          item.chars.map { |ch| CHARS.index(ch) }
        else
          super
        end
      end
    end
    def sırala!
      replace(sırala)
    end
  end
end
