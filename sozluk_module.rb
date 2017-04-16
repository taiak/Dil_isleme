module Sozluk
  module Dosya
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
  class ::String

    # verilen parametreye göre karşılaştırma yapar.
    def size?(size, comp_op = :==)

    	# string olarak girilmiş değerleri sembole çevirir
    	comp_op = comp_op.to_sym if comp_op.class == String

			stat = nil

      case comp_op
      when :==
        stat = self if self.size == size
      when :>
        stat = self if self.size > size
      when :<
        stat = self if self.size < size
      when :>=
        stat = self if self.size >= size
      when :<=
        stat = self if self.size <= size
      end
      return stat
    end
    # string boyutlarına göre true veya false döner
    def size_limit? (low_limit, up_limit)
      self.size < up_limit and self.size > low_limit
    end
    # fiilse true döner
    def fiil?
      self.end_with?('mak', 'mek')
    end
    # fiil değilse true döner
    def fiil_degil?
      !self.fiil?
    end
    # büyük harfle başlıyarsa true döner
    def start_with_big?
       (/[ABCÇDEFGĞHIİJKLMNOÖPRSŞTUÜVYZ]/ =~ self[0])?true:false
    end
    # küçük harfle başlıyorsa true döner
    def start_with_small?
    	(/[abcçdefgğhıijklmnoöprsştuüvyz]/ =~ self[0])?true:false 
    end
  end
  class ::Array
    # prefix ile başlayan kelime veya kelimeleri seç    
    def start_with? (*prefix)
    	self.select { |word| word.start_with?(*prefix) }
    end
    # sonu suffix ile biten kelimeleri seç    
    def end_with? (suffix)
    	self.select { |word| word.end_with? (suffix) }
    end
  	# içinde ' '(boşluk) karakteri olmayan kelimeleri seç
    def non_space?
      self.select { |word| !word.index(' ') }
    end
  	# içinde ' '(boşluk) karakteri olan kelimeleri seç
    def with_space?
      self.select { |word| word.index(' ') }   	
    end
    # fiil kelimeleri seç
    def is_verb?
    	self.select { |word| word.fiil? }
    end
    # fiil olmayan kelimeleri seç
    def not_verb?
    	self.select { |word| word.fiil_degil? }
    end
    # büyük harfle başlayan kelimeleri seç
    def start_big?
    	self.select { |word| word.start_with_big? }
    end
    # küçük harfle başlayan kelimeleri seç
    def start_small?
    	self.select { |word| word.start_with_small? }
    end
    # boyutu size'a göre, verilen işaretle işleme sok ve koşula uyanları seç
    # ön tanımlı işlem parametre verilmezse == işlemi öntanımlı
    def size? (size, comp_op = :==)
    	self.select { |word| word.size?(size, comp_op) }
    end
    # uzunluğu low_limit ve up_limit arasında olan kelimeleri seç
    def limit? (low_limit, up_limit)
    	self.select { |word| word.size_limit?(low_limit, up_limit) }
    end
    # boyutu size? koşullarına uymayan sonuçları getir
    def not_size? (size, comp_op = :==)
    	self.select { |word| !word.size?(size, comp_op) }
    end
  end
end
