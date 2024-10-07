# 🏛️ Core Module - Sports Betting App

Bu modül, Sports Betting App'in temel bileşenlerini içerir. Bu bileşenler, uygulamanın ana işlevselliğini, güvenliğini ve tutarlı kullanıcı deneyimini sağlar.

## 📚 İçindekiler

1. [📊 Analytics](#-analytics)
2. [🧩 Components](#-components)
3. [⚙️ Configuration](#️-configuration)
4. [🌐 Networking](#-networking)
5. [🔐 Security](#-security)
6. [🎨 Theme](#-theme)

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

### 🧩 Bileşenler

- `AppearanceConfigurator`: Uygulamanın genel görünümünü yapılandırmak için kullanılan yapı
- `ConfigurationManager`: Uygulama yapılandırma değerlerini yöneten singleton sınıf

## 🌐 Networking

Bu modül, uygulamanın ağ işlemlerini ve API yapılandırmasını yönetir.

### 🌟 Özellikler

- Asenkron ağ istekleri yapma
- Ortam yönetimi (development, staging, production)
- Hata yönetimi ve yanıt işleme

### 🧩 Bileşenler

- `APIConfiguration`: API anahtarı yönetimi ve ortam yapılandırması için kullanılan singleton sınıf
- `Environment`: Uygulama ortamlarını tanımlayan enum
- `NetworkError`: Ağ işlemleri sırasında oluşabilecek hataları tanımlayan enum
- `NetworkManager`: Ağ isteklerini yöneten ana sınıf

## 🔐 Security

Bu modül, uygulamanın güvenlik ile ilgili bileşenlerini içerir ve hassas verilerin güvenli bir şekilde saklanmasını ve yönetilmesini sağlar.

### 🌟 Özellikler

- Keychain kullanarak hassas verileri güvenli şekilde saklama

### 🧩 Bileşenler

- `KeychainManager`: iOS'un Keychain servisini kullanarak hassas verileri yöneten yardımcı sınıf

## 🎨 Theme

Bu modül, uygulamanın görsel temasını tanımlayan bileşenleri içerir ve tutarlı bir görünüm sağlar.

### 🌟 Özellikler

- Merkezi renk paleti yönetimi
- Görsel öğelerin merkezi yönetimi
- Kolay özelleştirme ve genişletme imkanı

### 🧩 Bileşenler

- `Theme`: Uygulamanın renk şemasını ve görsel öğelerini tanımlayan enum

Bu Core modülü, Sports Betting App'in temelini oluşturur ve uygulamanın güvenli, tutarlı ve verimli çalışmasını sağlar. Her bir alt modül, belirli bir işlevsellik alanına odaklanarak, uygulamanın modüler ve bakımı kolay bir yapıya sahip olmasını sağlar.
