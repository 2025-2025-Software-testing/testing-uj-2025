<h1 align="center">Przypadki Testowe: gutenberg</h1>

# 1. Drukowanie - różne konfiguracje ustawień drukowania (ilosc, przedzialy, jedno/dwustronne, w kolorze) 

## Happy Path

### TC1.1 czarno białe, pojedyńczego dokumentu

- **Stan początkowy:**  
  Uzytkownik ma internet, gutenberg jest połączony z _KSI_ drukarką.
- **Kroki testowe:**
  1. Uzytkownik loguje się.
  2. Uzytkownik wybiera plik do wydrukowania.
  3. Uzytkownik wybiera:
  - drukuj bez koloru
  - jedną kopię
  - jednostronnie
  - cały dokument
  4. Uzytkownik klika drukuj.
- **Oczekiwany rezultat:**  
  Uzytkownik otrzymuje wydrukowane kartki w wybranej konfiguracji.
- **Rzeczywisty rezultat:** _todo_
- **Rezultat testu:** _todo_
- **Stan końcowy:**  
  Ponownie pokazuje się ekran do drukowania(widok jak w kroku 2.), uzytkownik pozostaje zalogowany.

---

## Scenariusze alternatywne - pokrycie pozostałych konfiguracji drukowania

W scenariuszach alternatywnych jedyną róznica jest krok 3., pozostałe kroki oraz stany bez zmian

### TC1.2 - > 1 ilość kopii

- **Kroki testowe:** 3. Uzytkownik wybiera:
  - drukuj bez koloru
  - /\* kopii
  - jednostronnie
  - cały dokument
- **Oczekiwany rezultat:**  
  Uzytkownik otrzymuje wydrukowane kartki w wybranej konfiguracji.
- **Rzeczywisty rezultat:** _todo_
- **Rezultat testu:** _todo_

---

### TC1.3 - przedziały faktyczne

- **Kroki testowe:** 3. Uzytkownik wybiera:
  - drukuj bez koloru
  - jedną kopię
  - jednostronnie
  - przedział stron dokumentu np; 1-3, 5, 13-22(gdzie max nr strony podany w przedziale <= od długości dokumentu)
- **Oczekiwany rezultat:**  
  Uzytkownik otrzymuje wydrukowane kartki w wybranej konfiguracji.
- **Rzeczywisty rezultat:** _todo_
- **Rezultat testu:** _todo_

---

### TC1.4 - przedziały bez sensu
- **Kroki testowe:** 3. Uzytkownik wybiera:
  - drukuj bez koloru
  - jedną kopię
  - jednostronnie
  - przedział stron dokumentu np; 1-3, 5, 13-22(gdzie max nr strony podany w przedziale > od długości dokumentu)
- **Oczekiwany rezultat:**  
  Uzytkownik otrzymuje wydrukowane kartki w wybranej konfiguracji, gdzie ostatni przedzial drukuje (a,min(len,b))
- **Rzeczywisty rezultat:** _todo_
- **Rezultat testu:** _todo_

---

### TC1.5 - drukowanie w kolorze
- **Stan początkowy:**  
  Uzytkownik ma internet, gutenberg jest połączony z _KSI_ drukarką. **Ponadto** posiada konto z pozwoleniem na drukowanie w kolorze.
- **Kroki testowe:** 3. Uzytkownik wybiera:
  - drukuj w kolorze
  - jedną kopię
  - jednostronnie
  - przedział stron dokumentu (dowolny)
- **Oczekiwany rezultat:**  
  Uzytkownik otrzymuje wydrukowane kartki w wybranej konfiguracji
- **Rzeczywisty rezultat:** _todo_
- **Rezultat testu:** _todo_

---

### TC1.6 - drukowanie w kolorze, dwustronnie, pionowo
- **Stan początkowy:**  
  Uzytkownik ma internet, gutenberg jest połączony z _KSI_ drukarką. **Ponadto** posiada konto z pozwoleniem na drukowanie w kolorze.
- **Kroki testowe:** 3. Uzytkownik wybiera:
  - drukuj w kolorze
  - jedną kopię
  - dwustronnie, pionowo
  - przedział stron dokumentu (dowolny)
- **Oczekiwany rezultat:**  
  Uzytkownik otrzymuje wydrukowane kartki w wybranej konfiguracji
- **Rzeczywisty rezultat:** _todo_
- **Rezultat testu:** _todo_

---

### TC1.7 - drukowanie w kolorze, dwustronnie, poziomo
- **Stan początkowy:**  
  Uzytkownik ma internet, gutenberg jest połączony z _KSI_ drukarką. **Ponadto** posiada konto z pozwoleniem na drukowanie w kolorze.
- **Kroki testowe:** 3. Uzytkownik wybiera:
  - drukuj w kolorze
  - jedną kopię
  - dwustronnie, poziomo
  - przedział stron dokumentu (dowolny)
- **Oczekiwany rezultat:**  
  Uzytkownik otrzymuje wydrukowane kartki w wybranej konfiguracji
- **Rzeczywisty rezultat:** _todo_
- **Rezultat testu:** _todo_

---

# 2. Łączenie z lokalną drukarką przez CUPS

## Happy Path

### TC2.1 - dodawanie drukarki

- **Stan początkowy:**  
  Uzytkownik ma internet, komputer(Linux/macOS) i drukarkę
- **Kroki testowe:**
  1. Uzytkownik wchodzi na guthenberga
  2. Uzytkownik loguje się
  3. Uzytkownik wchodzi na http://localhost:631/
  4. Przechodzi do zakładki **Administration**
  5. Podaje dane do konta użytkownika w OSie
  6. Wybiera **Add Printer** (nie **Find New Printers**)
  7. Wybiera **Internet Printing Protocol (ipps)** jako sposób połączenia
  8. W polu **Connection** wkleja link "*Personal API endpoint*" z Gutenberga (czyli ten z tokenem w URLu)
  9. Ustawia własny **Name**
  10. Ustawia: **Make**: `Generic` i **Model**: `IPP Everywhere`
  11.  Domyślne opcje można zostawić takie jakie są
- **Oczekiwany rezultat:**  
  Uzytkownik ma możliwość drukowania plikow na prywatnej drukarce
- **Rzeczywisty rezultat:** _todo_
- **Rezultat testu:** _todo_
- **Stan końcowy:**  
  Pokazuje się ekran do drukowania, uzytkownik pozostaje zalogowany, wybrana drukarka pozostaje połączona.


---
