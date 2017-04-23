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

#### consonant?(n = 0)

Verilen stringin n. elemanının sessiz harf olup olmadığını kontrol eder.

#### fast_gsub(exp, change)

String exp ifadesini içeriyorsa gsub işlemini gerçekleştirir. gsub'dan farkı eğer ifade
exp ifadesini içermiyorsa gsuba girmediğinden işlemin daha hızlı çalışması.

#### to_bit

Sesli harfleri 0, sessiz harfleri 1 yapar.

#### size?(size, comp_op = :==)

Verilen işleme göre size'ı kontrol eder. Doğruysa true döner.

#### limit? (low_limit, up_limit)

Verilen stringin boyutu low_limit ve up_limit arasında mı diye kontrol eder.

#### spell

Verilen stringi türkçe kurallara göre heceler

### Dizi Metotları

#### to_str

Dizinin elemanlarını stringe çevirir.

#### gsub(before, after)

gsub'ı diziye uyarlar.

#### spell_split(bracket = '-')

Bütün kelimeleri heceler ve '-' ile ayrılan kelimeleri ayıklar.
Sonuç dizisi her hecenin ayrılmış halidir. Uniq değildir.

#### syll_count

# herbir stringin tekrar sayısını verir. Her eleman [kelime, sayısı] şeklinde döner.

#### rep_count

Verilen dizideki elemanları sayar ve [kelime, 1] şeklinde uniq bir liste verir

#### syll

Heceleri(syllables) string olarak verir.

#### start_pattern?(pattern)

Kelimeleri bite çevirir ve verilen patternle başlayanları seçer.

#### index_pattern?(pattern)

Kelimeleri bite çevirir ve verilen patterni içerisinde arar.

#### spell

Bütün kelimeleri heceler.

#### to_bit

Bütün kelimelar için sesli harfleri 0, sessiz harfleri 1 yapar.

#### class?(clss)

clss sınıfına ait elemanları seçer.

#### search?(word)

Word kelimesini içeren kelimeleri seçer.

#### search_not?(wordy)

Word kelimesini içermeyen kelimeleri seçer.

#### start_with? (*prefix)

Prefixlerden herhangi biriyle başlayan kelimeleri seçer.

#### end_with? (suffix)

Suffix ile biten kelimeleri seçer.

#### non_space?

İçerisinde boşluk karakteri bulunmayan kelimeleri döner.

#### with_space?

İçerisinde boşluk karakteri bulunan kelimeleri döner.

#### verb?

Sadece sonu -mak ve -mek'le biten kelimelerin kökünü alır.

#### size? (size, comp_op = :==)

Verilen ölçüt ve kontrol seçeneğine uyan elemanları seçer.

#### not_size? (size, comp_op = :==)

Verilen ölçüt ve kontrol seçeneğine uyanmayan elemanları seçer.

#### limit? (low_limit, up_limit)

low_limit ve up_limit uzunlukları arasında uzunluğu olan stringleri seçer.
