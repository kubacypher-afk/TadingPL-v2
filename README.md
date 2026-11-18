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

## 📦 Pliki Wynikowe po Kompilacji na Codemagic.io

W zakładce **Artifacts** na Codemagic otrzymasz dwa pliki:

1. **`TradingDesk-Simulator.zip` (Dla Appetize.io / Simulatora w przeglądarce):**
   - Skompilowany pod architekturę symulatora Apple (`iphonesimulator`).
   - Wgrywasz go bezpośrednio na [Appetize.io](https://appetize.io) — odpala się w przeglądarce bez żadnych błędów.
2. **`TradingDesk.ipa` (Dla Prawdziwego iPhone'a):**
   - Skompilowany pod fizyczne urządzenia (`arm64 iphoneos`).
   - Do instalacji na telefonie przez TrollStore, AltStore, Sideloadly lub Scarlet.
