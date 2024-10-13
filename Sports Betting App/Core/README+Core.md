# 🏛️ Core Module - Sports Betting App

Bu modül, Sports Betting App'in temel bileşenlerini içerir. Bu bileşenler, uygulamanın ana işlevselliğini, güvenliğini ve tutarlı kullanıcı deneyimini sağlar.

## 📚 İçindekiler

1. [📊 Analytics](#-analytics)
2. [🧩 Components](#-components)
3. [⚙️ Configuration](#️-configuration)
4. [🌐 Networking](#-networking)
5. [🔐 Security](#-security)
6. [🎨 Theme](#-theme)
7. [📜 Localization](#-localization)

## 📊 Analytics

Bu modül, Firebase Analytics kullanarak kullanıcı davranışlarını ve uygulama performansını izler.

### 🌟 Özellikler

- Özel analitik olaylarını tanımlama ve kaydetme
- Kullanıcı davranışlarını ve uygulama performansını izleme

### 🧩 Bileşenler

- `AnalyticsEvent`: Tüm analitik olayları için temel protokol
- `AnalyticsLogger`: Analitik olaylarını kaydetmek için kullanılan singleton sınıf
- `AnalyticsManager`: Analitik yönetimi için temel protokol
- `BettingAnalyticsEvent`: Bahis ile ilgili özel analitik olayları
- `FirebaseAnalyticsManager`: Firebase Analytics'e özgü implementasyon

## 🧩 Components

Bu modül, uygulamanın temel UI bileşenlerini içerir ve tutarlı bir kullanıcı deneyimi sağlar.

### 🌟 Özellikler

- Yeniden kullanılabilir UI bileşenleri
- Otomatik düzen (Auto Layout) kullanımı
- Özelleştirilebilir görünüm ve davranış

### 🧩 Bileşenler

- `EmptyStateView`: Veri olmadığında veya hata durumunda kullanılan özel görünüm

## ⚙️ Configuration

Bu modül, uygulamanın temel yapılandırma ve görünüm ayarlarını yönetir.

### 🌟 Özellikler

- Uygulama genelinde tutarlı görünüm sağlama
- Yapılandırma değerlerini yönetme
- Uygulama başlatma işlemlerini yönetme

### 🧩 Bileşenler

- `AppearanceConfigurator`: Uygulamanın genel görünümünü yapılandırmak için kullanılan yapı
- `ConfigurationManager`: Uygulama yapılandırma değerlerini yöneten singleton sınıf
- `AppInitializer`: Uygulama başlatma işlemlerini yöneten sınıf

## 🌐 Networking

Bu modül, uygulamanın ağ işlemlerini ve API yapılandırmasını yönetir.

### 🌟 Özellikler

- Asenkron ağ istekleri yapma
- Ortam yönetimi (development, staging, production)
- Hata yönetimi ve yanıt işleme

### 🧩 Bileşenler

- `Protocols/APIRequestProtocol`: API isteklerini standartlaştıran protokol
- `APIConfiguration`: API anahtarı yönetimi ve ortam yapılandırması için kullanılan singleton sınıf
- `Environment`: Uygulama ortamlarını tanımlayan enum
- `NetworkError`: Ağ işlemleri sırasında oluşabilecek hataları tanımlayan enum
- `NetworkManager`: Ağ isteklerini yöneten ana sınıf

## 🔐 Security

Bu modül, uygulamanın güvenlik ile ilgili bileşenlerini içerir ve hassas verilerin güvenli bir şekilde saklanmasını ve yönetilmesini sağlar.

### 🌟 Özellikler

- Keychain kullanarak hassas verileri güvenli şekilde saklama
- Kullanıcı izinlerini yönetme

### 🧩 Bileşenler

- `KeychainManager`: iOS'un Keychain servisini kullanarak hassas verileri yöneten yardımcı sınıf
- `TrackingPermissionManager`: Kullanıcı izleme izinlerini yöneten sınıf

## 🎨 Theme

Bu modül, uygulamanın görsel temasını tanımlayan bileşenleri içerir ve tutarlı bir görünüm sağlar.

### 🌟 Özellikler

- Merkezi renk paleti yönetimi
- Görsel öğelerin merkezi yönetimi

### 🧩 Bileşenler

- `Theme`: Uygulamanın renk şemasını ve görsel öğelerini tanımlayan enum

Bu Core modülü, Sports Betting App'in temelini oluşturur ve uygulamanın güvenli, tutarlı ve verimli çalışmasını sağlar. Her bir alt modül, belirli bir işlevsellik alanına odaklanarak, uygulamanın modüler ve bakımı kolay bir yapıya sahip olmasını sağlar.

## 📜 Localization

Bu modül, uygulamanın çoklu dil desteğini yönetir.

### 🌟 Özellikler

- Dinamik ve statik lokalizasyon anahtarları
- Merkezi lokalizasyon yönetimi
- Tarih formatlarının lokalizasyonu
- Çoklu dil desteği

### 🧩 Bileşenler

- `LocalizationKey`: Lokalizasyon anahtarlarını tanımlayan protokol
- `DynamicLocalizationKey`: Dinamik lokalizasyon anahtarlarını oluşturmak için kullanılan yapı
- `L10n`: Lokalizasyon işlemlerini yöneten ana enum
  - `General`: Genel kullanım için lokalizasyon anahtarları
  - `BettingDashboard`: Bahis panosu için lokalizasyon anahtarları
  - `BettingBasket`: Bahis sepeti için lokalizasyon anahtarları
  - `Tabbar`: Tab bar için lokalizasyon anahtarları
  - `BetTypes`: Bahis türleri için lokalizasyon anahtarları

### 🚀 Özelleştirilmiş Fonksiyonlar

- Tarih formatlaması için özel fonksiyonlar
- Dinamik metin oluşturma için genişletilmiş fonksiyonlar (örneğin, takım isimleri, bahis oranları)

Bu modül, uygulamanın tüm metin içeriklerinin farklı dillerde sunulmasını sağlar ve kullanıcı deneyimini kişiselleştirir. Ayrıca, dinamik içerik oluşturma yeteneği ile esnek bir lokalizasyon altyapısı sunar.
