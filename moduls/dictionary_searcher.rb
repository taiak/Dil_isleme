# Dictionary Searcher
module DS
  class ::String
    private
    VOWELS =  /[aâeıîioöuûüAÂEIİÎOÖUÜÛ]/.freeze
    CONSONANT = /[bcçdfgğhjklmnprsştvyzBCÇDEFGHJKLMNPRSŞTVYZ]/.freeze
    # VOWELS_STR = "aâeıîioöuûüAÂEIİÎOÖUÜÛ".freeze
    # CONSONANT_STR = "bcçdfgğhjklmnprsştvyzBCÇDEFGHJKLMNPRSŞTVYZ".freeze
    #BIG_CHARS =   /[AÂBCÇDEFGĞHIÎİJKLMNOÖPQRSŞTUÛÜVWYZ]/.freeze
    #SMALL_CHARS = /[aâbcçdefgğhıîijklmnoöpqrsştuûüvwyz]/.freeze
    #CHARS = "AÂBCÇDEFGĞHIÎİJKLMNOÖPQRSŞTUÛÜVWYZaâbcçdefgğhıîijklmnoöpqrsştuûüvwyz".freeze

    # sonu mak veya mekle bitiyorsa true döner
    def verb?
      self.end_with?('mak', 'mek')
    end
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
    # kontrol işlemi gerçekleştirerek gsub'ın daha hızlı gerçekleşmesini sağlar
    def fast_gsub(exp, change)
      self.dup.fast_gsub!
    end
    def fast_gsub!(exp, change)
      (self.index exp) ? self.gsub!(exp,change) : self
    end
    # türkçe alfabedeki harfleri bit şekline çevirir
    # sesli harfleri 0'a sessizleri 1'e çevir
    def to_bit
      self.fast_gsub(/['-]/, '').fast_gsub(VOWELS, '0').fast_gsub(CONSONANT, '1')
    end
    def to_bit!
      # ! veya - olanları sil
      self.gsub!(/['-]/, '') if (self.index "'" or self.index "-")
      # VOWELS ve CONSONANT'ı kontrol ettirmek performans problemlerine sebep olmakta
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
    def limit? (low_limit, up_limit)
      self.size < up_limit and self.size > low_limit
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
    protected
    # [[symbole, number],[symbole, number]] şeklindeki diziden sembolleri seçer
    def catch_class(clss)
      self.flatten.class? clss
    end
    public
    # herbir elemanı sringe dönüştürür
    def to_str
      self.dup.to_str!
    end
    def to_str!
      self.collect! { |word| word.to_s }
    end
    # gsub işlemini diziye uyarla
    def gsub!(before, after)
      self.collect! { |word| (word.index before) ? word.gsub(/#{before}/, after): word }
    end
    def gsub(before, after)
      self.dup.gsub!(before, after)
    end
    # dizideki stringleri heceler ve heceleri döner. uniq değildir 
    def spell_split(bracket = '-')
      return self.map { |word| word.spell.split(bracket) }.flatten
    end
    # herbir stringin tekrar sayısını verir. her eleman [isim, sayi] şeklinde döner
    def syll_count
      self.spell_split.rep_count
    end
    # verilen dizideki elemanları sayar ve [adı, sayısı] şeklinde uniq bir liste verir
    def rep_count
      self.each_with_object(Hash.new(0)){ |key,hash| hash[key] += 1 }.sort {|sym, rep| rep[1].to_i <=> sym[1].to_i }
    end
    # heceleri(syllables) verir. sembol olarak dönüş yapar
    def syll
      self.syll_count.catch_class(String)
    end
    # verilen patternle başlayan kelimeleri döner
    def start_pattern?(pattern)
      self.select { |word| word.to_bit.start_with?(pattern) }
    end
    # verilen patterni kelimelerde arar ve geçerli kelimeleri döner
    def index_pattern?(pattern)
      self.select { |word| word.to_bit.index(pattern) }
    end
    # verilen dizideki elemanları türkçeye göre heceler
    def spell
      self.dup.spell!
    end
    def spell!
      self.collect! { |word| word.spell }
    end
    # kelimeleri bit şeklinde 0 ve 1'e çevirir
    def to_bit
      self.dup.to_bit!
    end
    def to_bit!
      self.collect! { |word| word.to_bit! }
    end
    # verilen sınıftaki nesneleri döner
    def class?(clss)
      self.select { |word| word.class == clss }
    end
    # wordy kelimesini içeren kelimeleri seçer 
    def search?(wordy)
      self.select { |word| word.include? wordy}
    end
    # wordy kelimesini içermeyen kelimeleri seçer
    def search_not?(wordy)
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
      self.select { |word| word.verb? }.collect { |word| word[0...-3] }
    end
    # boyutu size'a göre, verilen işaretle işleme sok ve koşula uyanları seç
    # ön tanımlı işlem parametre verilmezse == işlemi öntanımlı
    def size? (size, comp_op = :==)
      self.select { |word| word.size?(size, comp_op) }
    end
    # boyutu size? koşullarına uymayan sonuçları getir
    def not_size? (size, comp_op = :==)
      self.select { |word| !word.size?(size, comp_op) }
    end
    # uzunluğu low_limit ve up_limit arasında olan kelimeleri seç
    def limit? (low_limit, up_limit)
      self.select { |word| word.limit?(low_limit, up_limit) }
    end
    # verilen dizideki boşlukları siler 
    def unspace
      self.dup.unspace!
    end
    def unspace!
      self.collect! { |word| (word.index ' ')? word.gsub(' ',''): word }
    end
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
  end
end
