# 🎯 Features Module - Sports Betting App

Bu modül, Sports Betting App'in temel özelliklerini içerir. Bu özellikler, uygulamanın ana işlevselliğini oluşturur ve kullanıcı deneyimini şekillendirir.

## 📚 İçindekiler

1. [🧺 Betting Basket](#-betting-basket)
2. [📊 Betting Dashboard](#-betting-dashboard)

## 🧺 Betting Basket

Betting Basket özelliği, kullanıcıların seçtikleri bahisleri yönetmelerini sağlar.

### 🧩 Bileşenler

- **Modeller**: `Basket`, `BasketItem`
- **ViewModel**: `BettingBasketViewModel`
- **Views**: `BasketItemTableViewCell`, `BettingBasketViewController`

### 🌟 Özellikler

- Sepete bahis ekleme ve çıkarma
- Toplam maç sayısı, toplam oran
- Analitik olaylarını kaydetme

### 📊 Analitikler

- Bahis güncelleme
- Bahis kaldırma
- Sepet güncelleme
- Sepet görüntüleme

## 📊 Betting Dashboard

Betting Dashboard özelliği, kullanıcılara mevcut bahis etkinliklerini gösterir ve bahis seçimi yapmalarını sağlar.

### 🧩 Bileşenler

- **API İstekleri**: `BetsListRequest`
- **ViewModels**: `BettingDashboardViewModel`, `BettingEventCellViewModel`
- **Views**: `BettingEventTableViewCell`
- **View Controller**: `BettingDashboardViewController`

### 🌟 Özellikler

- Bahis etkinliklerini API'den alma
- Etkinlikleri listeleme ve filtreleme
- Sepete bahis ekleme
- Arama işlevselliği

### 📊 Analitikler

- Arama yapma
- Bahis ekleme
- Bahis güncelleme
- Sepet güncelleme

