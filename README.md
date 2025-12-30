**[Türkçe](#turkce) | [English](#english)**

# <a name="turkce"></a>Flutter ile Yazılmış Haber Uygulaması

Flutter Haber Uygulaması, kullanıcıların en güncel haberleri keşfedebileceği, favori haberlerini kaydedebileceği ve kişiselleştirilmiş ayarlarını yönetebileceği modern bir arayüze sahip bir mobil uygulamadır. Uygulamada **state management** için `BLoC (flutter_bloc)`, **routing** için `go_router` ve **dependency injection** için `get_it` kullanılmaktadır. Uygulama, kullanıcı deneyimini ve etkileşimini artırmak için çeşitli özellikler sunmaktadır.

## Özellikler

- **BLoC ile State Management**
    - Uygulamanın durum yönetimi `flutter_bloc` (BLoC) ile sağlanmaktadır.
- **Routing**
    - Sayfa geçişleri ve yönlendirme `go_router` ile sağlanmaktadır.
- **Dependency Injection**
    - Servis ve repository bağımlılıkları `get_it` ile enjekte edilmektedir.
- **Firebase Authentication**
    - Kullanıcıların kayıt, giriş ve e-posta doğrulama işlemleri Firebase Authentication ile yönetilir.
- **Firebase Firestore**
    - Kullanıcı bilgileri (isim, soyisim, e-posta) Firestore'da saklanır ve güncellenebilir.
- **Haber Verileri**
    - Haberler [NewsAPI](https://newsapi.org/) üzerinden alınır ve `dio` paketi ile çekilir.
- **Favori Haberler**
    - Kullanıcılar favori haberlerini kaydedebilir ve favoriler listesinden yönetebilir.
- **Haber Arama Sistemi**
    - Haberler arasında anahtar kelime ile arama yapılabilir.
- **Kategorize Edilmiş Haberler**
    - Haberler kategori bazında filtrelenebilir ve tabbar ile görüntülenebilir.
- **Açık & Koyu Mod**
    - Kullanıcı tercihlerine göre tema değiştirilebilir.
- **Responsive Tasarım**
    - Farklı ekran boyutlarına uyumlu arayüz.
- **Animasyonlar**
    - Lottie animasyonları ile zenginleştirilmiş kullanıcı deneyimi.
- **Webview ile Haber Detayı**
    - Haber detayları uygulama içi webview ile gösterilir.

## APK Dosyası

[APK Dosyasını indir](https://drive.google.com/file/d/10NV2DAhAOwNo2e9hSELKiJN6zF_y60nf/view?usp=sharing)

## Kullanılan Teknolojiler ve Paketler

 Paket İsmi              | Versiyon 
-------------------------|----------
 Flutter                 | >=3.7.2
 bloc                    | ^9.1.0
 flutter_bloc            | ^9.1.1
 get_it                  | ^8.2.0
 go_router               | ^16.3.0
 dio                     | ^5.8.0+1
 flutter_dotenv          | ^5.0.2  
 firebase_core           | ^3.13.1
 firebase_auth           | ^5.5.4
 cloud_firestore         | ^5.6.8
 hive_flutter            | ^1.1.0
 cached_network_image    | ^3.4.1
 responsive_sizer        | ^3.3.1
 lottie                  | ^3.3.1
 webview_flutter         | ^4.13.0
 intl                    | ^0.20.2
 equatable               | ^2.0.7
 logging                 | ^1.3.0
 rxdart                  | ^0.28.0
 auto_size_text          | ^3.0.0
 skeleton_text           | ^3.0.1
 expandable_page_view    | ^1.0.17
 cupertino_icons         | ^1.0.8

## Test ve Geliştirme Paketleri (Dev)

 Paket İsmi              | Versiyon 
-------------------------|----------
 flutter_test            | sdk
 bloc_test               | ^10.0.0
 mocktail                | ^1.0.4
 fake_cloud_firestore    | ^3.1.0

1. **Projeyi klonlayın**

   ```bash
   git clone https://github.com/cengizhanerturan/flutter_news_app_bloc.git
   cd flutter_news_app_bloc
   ```

2. **Gerekli bağımlılıkları yükleyin**

   ```bash
   flutter pub get
   ```

3. **API anahtarınızı alın ve `.env` dosyasına ekleyin**

   - Proje API anahtarını çalışma zamanında `.env` dosyasından okuyor. Proje kök dizininde bir `.env` dosyası oluşturun veya `.env.example` dosyasını kopyalayın ve `API_KEY` değerini ekleyin:

   ```text
   API_KEY=your_api_key
   ```

4. **Projeyi çalıştırın**

   ```bash
   flutter run
   ```

## Uygulama Tanıtım Videosu (Youtube)

<p>Kayıt, giriş, e-posta değiştirme, şifre değiştirme ve kullanıcı bilgileri değiştirme bölümleri, YouTube kurallarına uymadığı gerekçesiyle videodan çıkartılmıştır.</p>

[Uygulama tanıtım videosunu youtube'dan izle.](https://youtube.com/shorts/6MVdNm9iYk0)

## Ekran Görüntüleri

<p>Aşağıda uygulamanın açık ve koyu mod olarak ekran görüntülerini bulabilirsiniz</p>

## Açık Mod

### 1. Giriş ve Kayıt Ekranları

<a><img src="https://github.com/cengizhanerturan/flutter_news_app_bloc/blob/main/assets/screenshots/light/auth-1.png" alt="Giriş ve Kayıt" style="max-width: 100%;" /></a>
<a><img src="https://github.com/cengizhanerturan/flutter_news_app_bloc/blob/main/assets/screenshots/light/auth-2.png" alt="Giriş ve Kayıt" style="max-width: 100%;" /></a>

### 2. Anasayfa, Keşfet, Favoriler ve Arama Ekranları

<a><img src="https://github.com/cengizhanerturan/flutter_news_app_bloc/blob/main/assets/screenshots/light/home.png" alt="Anasayfa, Keşfet, Favoriler ve Arama" style="max-width: 100%;" /></a>

### 3. Haber Detay Ekranı

<a><img src="https://github.com/cengizhanerturan/flutter_news_app_bloc/blob/main/assets/screenshots/light/details.png" alt="Haber Detay" style="max-width: 100%;" /></a>

### 4. Ayarlar Ekranı

<a><img src="https://github.com/cengizhanerturan/flutter_news_app_bloc/blob/main/assets/screenshots/light/settings.png" alt="Ayarlar" style="max-width: 100%;" /></a>

## Koyu Mod

### 1. Giriş ve Kayıt Ekranları

<a><img src="https://github.com/cengizhanerturan/flutter_news_app_bloc/blob/main/assets/screenshots/dark/auth-1.png" alt="Giriş ve Kayıt" style="max-width: 100%;" /></a>
<a><img src="https://github.com/cengizhanerturan/flutter_news_app_bloc/blob/main/assets/screenshots/dark/auth-2.png" alt="Giriş ve Kayıt" style="max-width: 100%;" /></a>

### 2. Anasayfa, Keşfet, Favoriler ve Arama Ekranları

<a><img src="https://github.com/cengizhanerturan/flutter_news_app_bloc/blob/main/assets/screenshots/dark/home.png" alt="Anasayfa, Keşfet, Favoriler ve Arama" style="max-width: 100%;" /></a>

### 3. Haber Detay Ekranı

<a><img src="https://github.com/cengizhanerturan/flutter_news_app_bloc/blob/main/assets/screenshots/dark/details.png" alt="Haber Detay" style="max-width: 100%;" /></a>

### 4. Ayarlar Ekranı

<a><img src="https://github.com/cengizhanerturan/flutter_news_app_bloc/blob/main/assets/screenshots/dark/settings.png" alt="Ayarlar" style="max-width: 100%;" /></a>

<br><br>

# <a name="english"></a>News Application Written in Flutter

Flutter News Application is a mobile app with a modern interface where users can discover the latest news, save their favorite articles, and manage personalized settings. **BLoC (`flutter_bloc`)** is used for state management; **routing** is handled by `go_router`, and **dependency injection** is done with `get_it`. The app includes various features to enhance user experience and engagement.

## Features

- **State Management with BLoC**
    - State management is handled using `flutter_bloc` (BLoC).
- **Routing**
    - Page navigation and routing are handled using `go_router`.
- **Dependency Injection**
    - Dependency injection is handled using `get_it`.
- **Firebase Authentication**
    - User registration, login, and email verification are managed using Firebase Authentication.
- **Firebase Firestore**
    - User information (name, surname, email) is stored and updated using Firestore.
- **News Data**
    - News articles are fetched from [NewsAPI](https://newsapi.org/) using the `dio` package.
- **Favorite News**
    - Users can save and manage their favorite news articles.
- **News Search System**
    - Search functionality for news articles by keywords.
- **Categorized News**
    - News articles are organized by categories and can be displayed using a tab bar.
- **Light & Dark Mode**
    - Users can switch between light and dark themes.
- **Responsive Design**
    - UI adapts to different screen sizes.
- **Animations**
    - Enhanced user experience with Lottie animations.
- **News Details via Webview**
    - News details are displayed in-app using webview.

## APK File

[Download the APK File](https://drive.google.com/file/d/10NV2DAhAOwNo2e9hSELKiJN6zF_y60nf/view?usp=sharing)

## Technologies and Packages Used

 Package Name             | Version 
-------------------------|---------
 Flutter                 | >=3.7.2
 bloc                    | ^9.1.0
 flutter_bloc            | ^9.1.1
 get_it                  | ^8.2.0
 go_router               | ^16.3.0
 dio                     | ^5.8.0+1
 flutter_dotenv          | ^5.0.2
 firebase_core           | ^3.13.1
 firebase_auth           | ^5.5.4
 cloud_firestore         | ^5.6.8
 hive_flutter            | ^1.1.0
 cached_network_image    | ^3.4.1
 responsive_sizer        | ^3.3.1
 lottie                  | ^3.3.1
 webview_flutter         | ^4.13.0
 intl                    | ^0.20.2
 equatable               | ^2.0.7
 logging                 | ^1.3.0
 rxdart                  | ^0.28.0
 auto_size_text          | ^3.0.0
 skeleton_text           | ^3.0.1
 expandable_page_view    | ^1.0.17
 cupertino_icons         | ^1.0.8

## Dev / Testing Packages

 Package Name             | Version 
-------------------------|---------
 flutter_test            | sdk
 bloc_test               | ^10.0.0
 mocktail                | ^1.0.4
 fake_cloud_firestore    | ^3.1.0

## Setup Instructions

1. **Clone the project**

   ```bash
   git clone https://github.com/cengizhanerturan/flutter_news_app_bloc.git
   cd flutter_news_app_bloc
   ```

2. **Install the required dependencies**

   ```bash
   flutter pub get
   ```

3. **Obtain your API key and add it to a `.env` file**

   - Copy `.env.example` to `.env` in the project root and update `API_KEY` with your NewsAPI key:

   ```text
   API_KEY=your_api_key
   ```

4. **Run the project**

   ```bash
   flutter run
   ```

## Application Demo Video (Youtube)

<p>The registration, login, email change, password change, and user information update sections have been removed from the video due to non-compliance with YouTube policies.</p>

[Watch the application demo video on YouTube.](https://youtube.com/shorts/6MVdNm9iYk0)

## Screenshots

<p>Below are screenshots of the application in both light and dark modes.</p>

## Light Mode

### 1. Login and Sign-up Screens

<a><img src="https://github.com/cengizhanerturan/flutter_news_app_bloc/blob/main/assets/screenshots/light/auth-1.png" alt="Login and Sign-up" style="max-width: 100%;" /></a>
<a><img src="https://github.com/cengizhanerturan/flutter_news_app_bloc/blob/main/assets/screenshots/light/auth-2.png" alt="Login and Sign-up" style="max-width: 100%;" /></a>

### 2. Home, Discover, Favorites and Search Screens

<a><img src="https://github.com/cengizhanerturan/flutter_news_app_bloc/blob/main/assets/screenshots/light/home.png" alt="Home, Discover, Favorites and Search" style="max-width: 100%;" /></a>

### 3. News Detail Screen

<a><img src="https://github.com/cengizhanerturan/flutter_news_app_bloc/blob/main/assets/screenshots/light/details.png" alt="News Detail" style="max-width: 100%;" /></a>

### 4. Settings Screens

<a><img src="https://github.com/cengizhanerturan/flutter_news_app_bloc/blob/main/assets/screenshots/light/settings.png" alt="Settings" style="max-width: 100%;" /></a>

## Dark Mode

### 1. Login and Sign-up Screens

<a><img src="https://github.com/cengizhanerturan/flutter_news_app_bloc/blob/main/assets/screenshots/dark/auth-1.png" alt="Login and Sign-up" style="max-width: 100%;" /></a>
<a><img src="https://github.com/cengizhanerturan/flutter_news_app_bloc/blob/main/assets/screenshots/dark/auth-2.png" alt="Login and Sign-up" style="max-width: 100%;" /></a>

### 2. Home, Discover, Favorites and Search Screens

<a><img src="https://github.com/cengizhanerturan/flutter_news_app_bloc/blob/main/assets/screenshots/dark/home.png" alt="Home, Discover, Favorites and Search" style="max-width: 100%;" /></a>

### 3. News Detail Screen

<a><img src="https://github.com/cengizhanerturan/flutter_news_app_bloc/blob/main/assets/screenshots/dark/details.png" alt="News Detail" style="max-width: 100%;" /></a>

### 4. Settings Screens

<a><img src="https://github.com/cengizhanerturan/flutter_news_app_bloc/blob/main/assets/screenshots/dark/settings.png" alt="Settings" style="max-width: 100%;" /></a>
