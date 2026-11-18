# TRADING DESK - Aplikacja iOS (SwiftUI)

Zaawansowana graficznie i technicznie aplikacja tradingowa na system iOS (iPhone), stworzona w oparciu o najnowsze standardy **Swift 5.9 / Swift 6** i framework **SwiftUI (iOS 17+)** zgodnie z regułami `swiftui-pro`.

---

## 🚀 Architektura i Wygląd (Zgodnie ze Screenem)

- **Styl wizualny:** Pure OLED Black (`#0A0C10`, `#11141A`, `#161A22`), z akcentami neonowej zieleni (`#00FFA3`), delikatnymi gradientami i subtelnymi cyber-ramkami.
- **Header & Live Desk:** Pulsujący wskaźnik `● LIVE DESK`, saldo `$10.00`, dynamiczne pille `↗ +$0.00 (0.00%)` oraz mnożnik `1.00x`.
- **Wykres falowy (Oscyloskop):** Akcelerowany sprzętowo wykres w `SwiftUI.Canvas` zasilany przez `TimelineView` (płynne 60/120 FPS na ekranach ProMotion, minimalne zużycie baterii).
- **Filtry ram czasowych:** Kapsułki `● LIVE`, `1H`, `4H`, `1D`, `1W`, `ALL` z haptyczną reakcją na dotyk.
- **Karty aktywności (Activity):** 
  - `SOL / USDT` (Long Scalp, Take Profit 100%, +$42.80 / +14.2%)
  - `BTC / USDT` (Breakout, Auto Compound Exit, +$118.50 / +8.9%)
  - `ETH / USDT` (Momentum, Active Scalp, +$27.40 / +5.1%)
  - `PEPE / USDT` (Pump Hunter, Trailing Stop, +$384.10 / +45.6%)
- **Nawigacja dolna (Custom Cyber Tab Bar):**
  1. `Home`
  2. `Management`
  3. `Radar`
  4. `Wallet`
  5. `History`

---

## 🔐 Moduł Autoryzacji (Logowanie i Rejestracja)

- **Ekran powitalny:** Przełącznik segmentowy *Logowanie* / *Rejestracja*.
- **Pola rejestracji:**
  - Numer telefonu (`+48 ...` z klawiaturą numeryczną)
  - Adres e-mail
  - Hasło
  - Powtórz hasło (weryfikacja zgodności na żywo)
- **Animacja rejestracji (`RegistrationSuccessView`):**
  - Rozszerzający się neonowy pierścień i pulsujący checkmark
  - Komunikat o generowaniu kluczy i szyfrowaniu
- **Płynne przejście:**
  - Sprężynowa, szybka animacja przejścia (Spring Morph) do głównego pulpitu aplikacji po zalogowaniu lub ukończeniu rejestracji.

---

## 📦 Jak Skompilować do Pliku IPA na Codemagic.io

Projekt posiada gotową konfigurację `codemagic.yaml` oraz schemat Xcode `APP.xcscheme`.

### Krok 1: Wypchnięcie kodu na GitHub / GitLab
1. Zainicjalizuj repozytorium git w folderze `APP`:
   ```bash
   cd c:\Users\kuba\Desktop\TradingPL\APP
   git init
   git add .
   git commit -m "Initial commit of Trading Desk iOS app"
   ```
2. Utwórz nowe repozytorium na [GitHub.com](https://github.com) i połącz je:
   ```bash
   git remote add origin https://github.com/TWOJA_NAZWA/TradingApp.git
   git branch -M main
   git push -u origin main
   ```

### Krok 2: Konfiguracja na Codemagic.io
1. Zaloguj się na [Codemagic.io](https://codemagic.io).
2. Kliknij **Add application** i wybierz swoje repozytorium z GitHub.
3. Wybierz typ projektu: **iOS App** (Codemagic automatycznie wykryje plik `codemagic.yaml`).
4. Kliknij **Start new build**.

### Krok 3: Pobranie pliku .IPA
Po zakończeniu procesu budowania (zazwyczaj 2-4 minuty), w sekcji **Artifacts** pojawi się gotowy plik:
- `TradingDesk.ipa`

Plik `.ipa` można zainstalować bezpośrednio na iPhone za pomocą:
- **TrollStore** / **AltStore** / **SideStore** / **Sideloadly**, lub
- Po podpięciu certyfikatu Apple Developer w Codemagic — dystrybucją przez TestFlight / Ad-Hoc.
