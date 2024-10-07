# 🧩 Extensions

Bu klasör, Sports Betting App'in çeşitli Swift sınıflarına ve yapılarına ek işlevsellik kazandıran extension'ları içerir. Bu extension'lar, kodun daha temiz, daha okunabilir ve daha yeniden kullanılabilir olmasına yardımcı olur.

## 📚 İçindekiler

- [URLSession+Extensions](#urlsessionextensions)

## URLSession+Extensions

Bu extension, `URLSession` sınıfına Combine framework'ü kullanarak network isteklerini daha kolay yönetmek için bir yardımcı method ekler.

### 🌟 Özellikler

- Hata yönetimi
- Jenerik tip desteği ile farklı response tiplerini destekler

### 🔍 Nasıl Çalışır

1. Verilen `URLRequest` için bir data task publisher oluşturur.
2. HTTP yanıtını kontrol eder ve status code 200-299 aralığında değilse hata fırlatır.
3. Yanıt verisini belirtilen `Decodable` tipe decode eder.
4. Sonucu bir `AnyPublisher` olarak döndürür.
