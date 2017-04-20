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
    private
    VOWELS =  /[aâeıîioöuûüAÂEIİÎOÖUÜÛ]/.freeze
    CONSONANT = /[bcçdfgğhjklmnprsştvyzBCÇDEFGHJKLMNPRSŞTVYZ]/.freeze
    BIG_CHARS =   "AÂBCÇDEFGĞHIÎİJKLMNOÖPQRSŞTUÛÜVWYZ".freeze
    SMALL_CHARS = "aâbcçdefgğhıîijklmnoöpqrsştuûüvwyz".freeze

    public
    # sesli mi diye bakar.
    def vowel?(n = 0)
      return false unless self[n] # nil veya false olma ihtimaline karşı
      (VOWELS =~ self[n])?true:false
    end
    # sessiz mi diye bakar. var sayılan 0.indis
    def consonant?(n = 0)
      return false unless self[n] # nil veya false olma ihtimaline karşı
      (CONSONANT =~ self[n])?true:false
    end
    # türkçe alfabedeki harfleri bit şekline çevirir
    # sesli harfleri 0'a sessizleri 1'e çevir
    def to_bit
      self.gsub(/['-]/, '').gsub(VOWELS, '0').gsub(CONSONANT, '1')
    end
    def to_bit!
      # ! veya - olanları sil
      self.gsub!(/['-]/, '')
      self.gsub!(VOWELS, '0')
      self.gsub!(CONSONANT, '1') 
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
    # türkçe kurallara göre hecelemeyi sağlar
    def spell
      heceli = self.downcase
      sinir = self.size
      i = 1
      while i < sinir
        if vowel?(-i)
          if vowel?(-(i+1))
            heceli.insert( sinir-i, "-")
          else
            i += 1
            if ( sinir-i > 2 ) || vowel?(-(i+1)) 
              heceli.insert( sinir-i, "-")
            elsif vowel? # ilk harf sesliyse
              heceli.insert( 2, "-") 
            end
          end
        end
        i += 1
      end
      return heceli
    end
    def spell!
      self.replace( self.spell )
    end
  end
  class ::Array
    # verilen patternle başlayan kelimeleri döner
    def start_pattern?(pattern)
      self.select { |word| word.to_bit.start_with?(pattern) }
    end
    # verilen patterni kelimelerde arar ve geçerli kelimeleri döner
    def pattern?(pattern)
      self.select { |word| word.to_bit.index(pattern) }
    end
    # verilen dizideki elemanları türkçeye göre heceler
    def spell
      self.collect { |word| word.spell }
    end
    def spell!
      self.collect! { |word| word.spell }
    end
    # kelimeleri bit şeklinde 0 ve 1'e çevirir
    def to_bit
      self.collect { |word| word.to_bit }
    end
    def to_bit!
      self.collect! { |word| word.to_bit! }
    end
    # kelimelerin başındaki ve sonundaki boşlukları siler
    def unspace!
      self.collect! { |word| word.strip }
    end
    def unspace
      self.collect { |word| word.strip }
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
    def not_true?
      self.select { |word| !word }
    end
    # nil veya false olmayan kelimeleri seçer
    def is_true?
      self.select { |word| word }
    end
  end
end

# türkçe kelimelerin sıralanması için düzenlenecek
# module SortTurkish
#   class ::Array
#     attr_reader :CHARS
#     CHARS = "0123456789AÂBCÇDEFGĞHIÎİJKLMNOÖPQRSŞTUÛÜVWYZ
#               aâbcçdefgğhıîijklmnoöpqrsştuûüvwyz".freeze
#     def sırala
#       sort_by do |item|
#         if item.is_a?(String)
#           item.chars.map { |ch| CHARS.index(ch) }
#         else
#           super
#         end
#       end
#     end
#     def sırala!
#       replace(sırala)
#     end
#   end
# end
