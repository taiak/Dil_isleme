# Modüller Hakkında

**Turkish_Sort**  modülü türkçe için sıralama yapmak amaçlı hazırlanmıştır. *Hazır değil.*

**WRITER** modülü bir dizideki kelimeleri sözlük
şeklinde dosyaya yazmak amaçlı hazırlanmıştır.

**Dictionary Searcher(DS)** modülü string dizisi
üzerinde bazıişlemler yapmak için hazırlanmıştır.
Bazı metotlar türkçe için özelleştirilmiştir.(spell gibi)

**Dictionary Searcher Tools(DST)** modülü strip, upcase, downcase gibi bazı
metotların diziye uyarlanmış hallerini içerir.

## WRITER Modülü

`arr_write(dizi)` dizinin içerisindekileri bir dosyaya yazmak için kullanılır.

`write_line(dizge)` bir dizgeyi dosyaya yazıp alt satıra geçmek için kullanılır.

~~~ruby
  arr = %w(bu bir deneme cümlesi)
  dosya = open('dosya.txt', 'w')
  dosya.arr_write(arr)
  dosya.write_line("son_elemanı")
  dosya.close
~~~

## Dictionary Searcher( DS ) Modülü

### String Metotları

#### vowel?(n = 0)

Verilen stringin n. elemanının sesli harf olup olmadığını kontrol eder.

~~~ruby
   "example".vowel?  #=> true
   "example".vowel?(1) #=> false
~~~

#### const?(n = 0)

Verilen stringin n. elemanının sessiz harf olup olmadığını kontrol eder.

~~~ruby
   "example".const?  #=> false
   "example".const?(1) #=> true  
~~~

#### fast_gsub(exp, change)

String exp ifadesini içeriyorsa gsub işlemini gerçekleştirir. gsub'dan farkı eğer ifade
exp ifadesini içermiyorsa gsuba girmediğinden işlemin daha hızlı çalışması.

~~~ruby
  "deneme".fast_gsub("e","i") #=> "dinimi"
~~~

#### to_bit

Sesli harfleri 0, sessiz harfleri 1 yapar.

~~~ruby
  "deneme".to_bit #=> "101010"
~~~
#### size?(size, comp_op = :==)

Verilen işleme göre size'ı kontrol eder. Doğruysa true döner.

~~~ruby
  "deneme".size?(6) #=> true
  # comp yerine başka işleçlerde kullanılabilir
  "deneme".size?(3, :<) #=> false
  
  # işleçler string olarak da girilebilir
  "deneme"size?(2, ">") #=> true
  
  # yanlış girile işleç sonucunda işlem nil üretir
  "deneme".size?(5, "aboo") #=> nil
~~~

#### limit? (low_limit, up_limit)

Verilen stringin boyutu low_limit ve up_limit arasında mı diye kontrol eder.
Verilen sınırlarda low_limit ve up_limit sınırlara dahil değildir.

~~~ruby
  "sergüzeşt".limit?(1,9) #=> false
  "sergüzeşt".limit?(1,10) #=> true
~~~

#### spell

Verilen stringi türkçe kurallara göre heceler. Kelimenin hecelenmiş halini
aralarında "-" olan şekilde string türde döner.

~~~ruby
  "deneme".spell  #=> "de-ne-me"
  "sergüzeşt".spell  #=> "ser-gü-zeşt"
~~~

### Dizi Metotları

#### to_str

Dizinin elemanlarını stringe çevirir.

~~~ruby
    dizi = [:a, :aaa, :woa, :woaaaa]
    print dizi.to_str
    #=> ["a", "aaa", "woa", "woaaaa"]
~~~

#### gsub(before, after)

gsub'ı diziye uyarlar.
~~~ruby
    dizi = %w(de de de deneme bi bi bir)
    print dizi.gsub("de", "ne")
    #=> ["ne", "ne", "ne", "neneme", "bi", "bi", "bir"]
~~~

#### spell_split(bracket = '-')

Bütün kelimeleri heceler ve '-' ile ayrılan kelimeleri ayıklar.
Sonuç dizisi her hecenin ayrılmış halidir. Uniq değildir.

~~~ruby
    dizi = %w(de de de deneme bi bi bir)
    print dizi.spell_split
    #=> ["de", "de", "de", "de", "ne", "me", "bi", "bi", "bir"]
~~~

#### syll_count

Herbir stringin tekrar sayısını verir. Her eleman [hece, sayı] şeklinde döner.

~~~ruby
    dizi = %w(de de de deneme bi bi bir)
    print dizi.syll_count
    #=> [["de", 4], ["bi", 2], ["ne", 1], ["me", 1], ["bir", 1]]~
~~~

#### rep_count

Verilen dizideki elemanları sayar ve [kelime, sayı] şeklinde uniq bir liste verir.
Listeleri kendi aralarında tekrar sayısı en fazla olacak şekilde sıralar.

~~~ruby
    dizi = %w(de de de deneme bi bi bir)
    print dizi.rep_count
    #=> [["de", 3], ["bi", 2], ["deneme", 1], ["bir", 1]]
~~~

#### syll

Heceleri(syllables) string olarak verir.

~~~ruby
    dizi = %w(hünkarbeğendi tanrıverdi)
    print dizi.syll
    #=> ["di", "hün", "kar", "be", "ğen", "tan", "rı", "ver"]
~~~
#### start_pattern?(pattern)

Kelimeleri bite çevirir ve verilen patternle başlayanları seçer.

~~~ruby
    dizi = %w(bu ikinci deneme cümlem)
    print dizi.start_pattern?("1010")
    #=> ["deneme"]
~~~
#### index_pattern?(pattern)

Kelimeleri bite çevirir ve verilen patterni içerisinde arar.

~~~ruby
    dizi = %w(kara dağlar kar altında kalanda)
    print dizi.index_pattern?("1010")
    #=> ["kara", "kalanda"]
~~~

#### spell

Bütün kelimeleri heceler.

~~~ruby
    dizi = %w(kara dağlar kar altında kalanda)
    print dizi.spell
    #=> ["ka-ra", "dağ-lar", "kar", "al-tın-da", "ka-lan-da"]
~~~

#### to_bit

Bütün kelimelar için sesli harfleri 0, sessiz harfleri 1 yapar.

~~~ruby
    dizi = %w(kara dağlar kar altında kalanda)
    print dizi.to_bit
    #=> ["1010", "101101", "101", "0110110", "1010110"]
~~~

#### class?(clss)

clss sınıfına ait elemanları seçer.

~~~ruby
    dizi = %w(kara dağlar kar altında kalanda)
    dizi << :deneme
    print dizi.class?(Symbol)
    #=> [:deneme]
~~~

#### search?(word)

Word kelimesini içeren kelimeleri seçer.

~~~ruby
    dizi = %w(kara dağlar kar altında kalanda)
    print dizi.search?("kar")
    #=> ["kara", "kar"]
~~~

#### search_not?(wordy)

Word kelimesini içermeyen kelimeleri seçer.

~~~ruby
    dizi = %w(kara dağlar kar altında kalanda)
    print dizi.search?("kar")
    #=> ["dağlar", "altında", "kalanda"]
~~~

#### start_with? (*prefix)

Prefixlerden herhangi biriyle başlayan kelimeleri seçer.

~~~ruby
    dizi = %w(saklanbaç oynadınız mı sizde çocukken)
    print dizi.start_with?("siz", "m")
    #=> ["m", "sizde"]
~~~


#### end_with? (suffix)

Suffix ile biten kelimeleri seçer.

~~~ruby
    dizi = %w(ikimiz birden sevinebiliriz göğe bakalım)
    print dizi.end_with?("iz")
    #=> ["ikimiz", "sevinebiliriz"]
~~~

#### non_space?

İçerisinde boşluk karakteri bulunmayan kelimeleri döner.

~~~ruby
    dizi = ["Between", "flowers and sills", "the cats", "will", "know"]
    print dizi.non_space?
    #=> ["Between", "will", "know"]
~~~

#### with_space?

İçerisinde boşluk karakteri bulunan kelimeleri döner.

~~~ruby
    dizi = ["Between", "flowers and sills", "the cats", "will", "know"]
    print dizi.with_space?
    #=> ["flowers and sills", "the cats"]
~~~

#### verb?

Sadece sonu -mak ve -mek'le biten kelimelerin kökünü alır.

~~~ruby
    dizi = %w(olmak ya da olmamak işte bütün mesele bu)
    print dizi.verb?
    #=> ["ol", "olma"]
~~~

#### size? (size, comp_op = :==)

Verilen ölçüt ve kontrol seçeneğine uyan elemanları seçer.

~~~ruby
    dizi = %w(olmak ya da olmamak işte bütün mesele bu)
    print dizi.size? 2 #=> ["ya", "da", "bu"]
    print dizi.size?(5, :>)
    #=> ["olmamak", "mesele"]
~~~

#### not_size? (size, comp_op = :==)

Verilen ölçüt ve kontrol seçeneğine uyanmayan elemanları seçer.

~~~ruby
    dizi = %w(olmak ya da olmamak işte bütün mesele bu)
    print dizi.not_size? 2 
    #=> ["olmak", "olmamak", "işte", "bütün", "mesele"]
    print dizi.not_size?(5, :>)
    #=>["olmak", "ya", "da", "işte", "bütün", "bu"]
~~~

#### limit? (low_limit, up_limit)

low_limit ve up_limit uzunlukları arasında uzunluğu olan stringleri seçer.

#### unspace

Verilen dizideki herbir elemanın içerisindeki boşlukları siler.

~~~ruby
    dizi = [" Between ", " flowers and sills ", " the cats ", " will ", " know "]
    print dizi.unspace
    #=> ["Between", "flowersandsills", "thecats", "will", "know"]
~~~

#### strip

Her kelimenin başındaki ve sonundaki boşlukları siler.

~~~ruby
    dizi = [" Between ", " flowers and sills ", " the cats ", " will ", " know "]
    print dizi.unspace
    #=> ["Between", "flowers and sills", "the cats", "will", "know"]
~~~

#### not?

nil veya false olan elemanları döner.

~~~ruby
    dizi = [nil, false, "cats", "will", "know", false, true, "it"]
    print dizi.not?
    #=> [nil, false, false]
~~~

#### is_true?

nil veya false olmayan değerleri döner.

~~~ruby
    dizi = [nil, false, "cats", "will", "know", false, true, "it"]
    print dizi.not?
    #=> ["cats", "will", "know", true, "it"]
~~~
