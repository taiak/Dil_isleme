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
    # türkçe alfabedeki harfleri bit şekline çevirir
    # sesli harfleri 0'a sessizleri 1'e çevir
    def to_bit
      sesli = /[aeıioöûuüAEIİOÖUÜ]/
      sessiz = /[bcçdfgğhjklmnprsştvyzBCÇDEFGHJKLMNPRSŞTVYZ]/
      self.gsub(/['-]/, '').gsub(sesli, '0').gsub(sessiz, '1')
    end
    def to_bit!
      sesli = /[aeıioöuûüAEIİOÖUÜ]/
      sessiz = /[bcçdfgğhjklmnprsştvyzBCÇDEFGHJKLMNPRSŞTVYZ]/
      # ! veya - olanları sil
      self.gsub!(/['-]/, '')
      self.gsub!(sesli, '0')
      self.gsub!(sessiz, '1') 
    end
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
    def verb?
      self.end_with?('mak', 'mek')
    end
    # fiil değilse true döner
    def not_verb?
      !(self.verb?)
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
    # kelimeleri bit şeklinde 0 ve 1'e çevirir
    def to_bit
      self.collect { |word| word.to_bit }
    end
    def to_bit!
      self.collect! { |word| word.to_bit! }
    end
    # wordy kelimesini içeren kelimeleri seçer 
    def search(wordy)
      self.select { |word| word.include? wordy}
    end
    # wordy kelimesini içermeyen kelimeleri seçer
    def search_not(wordy)
      self.select { |word| !word.include? wordy}
    end
    # prefix'le başlayan kelimeleri seçer
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
    def verb?
    	self.select { |word| word.verb? }
    end
    # fiil olmayan kelimeleri seç
    def not_verb?
    	self.select { |word| word.not_verb? }
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
    # nil veya false olan kelimeleri seçer
    def not?
      self.select { |word| !word }
    end
    # nil veya false olmayan kelimeleri seçer
    def is?
      self.select { |word| word }
    end
  end
end
