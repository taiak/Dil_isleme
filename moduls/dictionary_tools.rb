# DictionarySearcherTools
module DST
  class ::String
    BIG_CHARS =   /[AÂBCÇDEFGĞHIÎİJKLMNOÖPQRSŞTUÛÜVWYZ]/.freeze
    SMALL_CHARS = /[aâbcçdefgğhıîijklmnoöpqrsştuûüvwyz]/.freeze

    # büyük harfle başlıyarsa true döner
    def start_with_big?
       (BIG_CHARS =~ self[0])?true:false
    end
    # küçük harfle başlıyorsa true döner
    def start_with_small?
      (SMALL_CHARS =~ self[0])?true:false 
    end
  end
  class ::Array
    # kelimelerin başındaki ve sonundaki boşlukları siler
    def strip
      self.dup.strip!
    end
    def strip!
      self.collect! { |word| word.strip }
    end
    # nil veya false olan kelimeleri seçer
    def not?
      self.select { |word| !word }
    end
    # nil veya false olmayan kelimeleri seçer
    def is_true?
      self.select { |word| word }
    end
    # false olan değerleri döner
    def is_false?
      self.select { |word| word == false }
    end
    # nil olan değerleri döner
    def is_nil?
      self.select { |word| word == nil }
    end
    # FIXME: Türkçeye uyarla
    # upcase işlemini sağlar
    def upcase
      self.dup.upcase!
    end
    def upcase!
      self.collect! { |word| word.upcase }
    end
    # FIXME: Türkçeye uyarla
    # downcase işlemini sağlar
    def downcase
      self.dup.downcase!
    end
    def downcase!
      self.collect! { |word| word.downcase }
    end
    # büyük harfle başlayan kelimeleri seç
    def start_big?
      self.select { |word| word.start_with_big? }
    end
    # küçük harfle başlayan kelimeleri seç
    def start_small?
      self.select { |word| word.start_with_small? }
    end
    # herbir elemanı sembole çevirir
    def each_to_sym
      self.dump.each_to_sym!
    end
    def each_to_sym!
      self.collect! { |word| word.to_sym }
    end
    # verilen dizideki boşlukları siler 
    def unspace
      self.dup.unspace!
    end
    def unspace!
      self.collect! { |word| (word.index ' ')? word.gsub(' ',''): word }
    end
  end
end
