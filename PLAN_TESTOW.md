# Plan testów – Projekt Gutenberg

## 1. Informacje podstawowe

| Pole                | Wartość                                                              |
|---------------------|-----------------------------------------------------------------------|
| Nazwa projektu      | Testowanie aplikacji Gutenberg                              |
| Nazwa aplikacji     | Gutenberg (https://github.com/KSIUJ/gutenberg)           |
| Wersja aplikacji    | v4.0.0-rc2  (commit główny na dzień 2025-11-07)                           |
| Skład zespołu       | Karolina Kulas, Piotr Janiszewski, Diego Ostoja-Kowalski <br>**Role:** <br> brak formalnego lidera; podział zadań wg kompetencji i dostępności |
| Data utworzenia     | 2025-10-18                                                        |

## 2. Historia zmian

| Data       | Autor         | Opis zmian                        |
|------------|--------------|-----------------------------------|
| 2025-10-18 | KK, PJ | Wersja inicjalna |
| 2025-10-19 | KK, PJ | |
| 2025-10-25 | KK, PJ | |
| 2025-11-07 | KK, DOK, PJ | Dostosowanie do wymagań dokumentacji, <br> aktualizacja składu zespołu i ról |

## 3. Wprowadzenie

### 3.1 Opis aplikacji
Projekt Gutenberg to otwartoźródłowa aplikacja, której celem jest wygodne zarządzanie drukowaniem dokumentów PDF za pomocą interfejsu webowego i wirtualnej drukarki (np. CUPS PDF). Projekt obsługuje różne tryby druku i pozwala na kontrolę liczby kopii i wyboru stron do druku. Repozytorium: [Gutenberg](https://github.com/KSIUJ/gutenberg).

### 3.2 Cel testowania
Celem testowania jest zapewnienie wysokiej jakości aplikacji Gutenberg poprzez wykrycie i raportowanie defektów w krytycznych obszarach, weryfikację funkcjonalności oraz ocenę stabilności rozwiązania w perspektywie użytkownika końcowego i administratora.

### 3.3 Zakres testów
Testy obejmują następujące funkcjonalności:
- Obsługa różnych typów plików (PDF, DOCX, inne popularne)
- Zarządzanie kolejką drukowania
- Konfiguracja liczby i rozmiaru kopii
- Podgląd plików
- Obsługa autoryzacji użytkowników (logowanie, uprawnienia)
- Wydajność backendu przy większym obciążeniu

Zakres nie obejmuje: testów instalacyjnych całego środowiska (o ile będzie udostępniona wersja demo), tłumaczeń, integracji z urządzeniami fizycznymi poza CUPS.

### 3.4 Odniesienia do dokumentacji
- Dokumentacja projektu: [dokumentacja Gutenberga](https://github.com/KSIUJ/gutenberg)
- Issues do analizy: [Issues](https://github.com/KSIUJ/gutenberg/issues)
- Analiza ryzyk: patrz `dokumentacja/analiza_ryzyk.md`

## 4. Strategia testowania

### 4.1 Typy testów do wykonania
- **Testy funkcjonalne:** Sprawdzenie poprawności działania określonych funkcji (proces drukowania, zarządzanie użytkownikami, API)
- **Testy niefunkcjonalne:** Wydajność (czas odpowiedzi, obsługa wielu żądań), użyteczność API, odporność na defekty wejścia
- **Testy regresji:** Porównanie najnowszej wersji ze starszą wersją Gutenberga.

### 4.2 Poziomy testów
- Testy jednostkowe (unit tests) – poszczególne komponenty
- Testy integracyjne – wymiana danych pomiędzy modułami, obsługa całego procesu drukowania
- Testy systemowe/end-to-end – symulacja typowych ścieżek użytkownika

### 4.3 Podejście do testowania
- **Testy manualne** – poznawcze dla nowych funkcjonalności, eksploracyjne (na podstawie zidentyfikowanych defektów)
- **Testy automatyczne** – głownie jednostkowe (pytest) i e2e
- **Priorytetyzacja obszarów do testowania:**  
  1. Funkcje zgłaszane jako awaryjne/issues  
  2. Podstawowe ścieżki happy-path  
  3. Funkcjonalności o wysokim ryzyku (np. upload plików, autoryzacja)

## 5. Kryteria wejścia i wyjścia

### 5.1 Kryteria wejścia
- Udostępniona wersja aplikacji lub demo/backend na testowym serwerze
- Konfiguracja środowiska testowego (python, pytest, CUPS PDF)
- Każdy członek zespołu ma dostęp do repozytorium
- Zdefiniowane test cases do kluczowych funkcji

### 5.2 Kryteria wyjścia
- Pokrycie wszystkich scenariuszy testowych min. 1 przebiegiem
- Ukończona dokumentacja działań testowych (raporty)

### 5.3 Kryteria zawieszenia i wznowienia testów
- Zawieszenie: awaria środowiska, brak dostępu do repo, blokujące błędy uniemożliwiające kontynuację
- Wznowienie: usunięcie blokad, ponowna dostępność środowiska

## 6. Środowisko testowe

- **Specyfikacja sprzętowa:** Laptop/PC z 8 GB RAM, 2-rdzeniowy CPU, SSD
- **Wymagania systemowe:** Linux (Ubuntu 22.04 preferowany), wsparcie dla Docker/CUPS
- **Przeglądarki:** Chrome, Firefox (dla testów API przez Postman)
- **Narzędzia testowe:** pytest, wirtualna drukarka CUPS PDF
- **Dane testowe:** zestaw przykładowych dokumentów PDF, DOCX, pliki testowe o różnych rozmiarach

## 7. Harmonogram i kamienie milowe

| Etap                                   |
|----------------------------------------|
| Analiza aplikacji i dokumentacji       |
| Opracowanie przypadków testowych       |
| Wywiad środowiskowy                    |
| Konfiguracja środowiska testowego      |
| Implementacja testów jednostkowych     |
| Testy integracyjne i e2e               |
| Testy eksploracyjne/manualne           |
| Zbieranie metryk i raport podsumowujący|

## 8. Zarządzanie ryzykiem

1. *Zidentyfikowane ryzyka, ocena i mitygacja:*
Patrz `dokumentacja/analiza_ryzyk.md`.

| ID  | Ryzyko                            | Prawdopodobieństwo | Wpływ | Priorytet | Mitygacja                         |
|-----|-----------------------------------|--------------------|-------|-----------|-----------------------------------|
| R01 | Niewystarczająca dokumentacja API | Średnie            | Niski| 2         | Analiza kodu źródłowego, kontakt z devami |
| R02 | Niedostępność środowiska testowego| Średnie            | Wysoki| 6         | Lokalne serwery testowe           |
| R03 | Opór przed refaktorem             | Niskie            | Niski| 1         | Wcześniejsza identyfikacja        |
| R04 | Brak doświadczenia zespołu        | Średnie            | Średni| 4         | Konsultacje, dokumentacja, podział zadań|

## 9. Metryki i raportowanie

- **Metryki:**
  - Liczba wykonanych test cases / zaplanowane
  - Liczba wykrytych i zamkniętych defektów (wg typu/krytyczności)
  - Code coverage (% pokrycia testami automatycznymi kodu źródłowego)
  - Czas trwania poszczególnych etapów testowych

- **Raportowanie:**
  - Częstotliwość: po każdym zakończonym etapie oraz na koniec projektu
  - Format: raport Markdown w repozytorium (raporty/testy_YYYY-MM-DD.md), issues dla defektów
  - Komunikacja wewnątrz zespołu: serwer Discord

---

Repozytorium projektu: https://github.com/2025-2025-Software-testing/testing-uj-2025  
Wersja pliku: 2025-11-07
