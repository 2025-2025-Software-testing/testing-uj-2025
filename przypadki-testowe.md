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
  - drukuj bez koloru
  - jedną kopię
  - przedział stron dokumentu np; 1-3, 5, 13-22(gdzie max nr strony podany w przedziale > od długości dokumentu)
- **Oczekiwany rezultat:**  
  Uzytkownik otrzymuje wydrukowane kartki w wybranej konfiguracji, gdzie ostatni przedzial drukuje (a,min(len,b))
- **Rzeczywisty rezultat:** _todo_
- **Rezultat testu:** _todo_

---

# 2. Łączenie z lokalną drukarką przez IPP

## Happy Path

### TC1.1 - tc1

- **Stan początkowy:**  
  Uzytkownik ma internet i drukarkę
- **Kroki testowe:**
  1. Uzytkownik loguje się.
  2. krok 2
  3. ...
- **Oczekiwany rezultat:**  
  opis oczekiwanego rezultatu
- **Rzeczywisty rezultat:** _todo_
- **Rezultat testu:** _todo_
- **Stan końcowy:**  
  opis stanu koncowego

---

## Scenariusze alternatywne

### TC1.2 - tc2

- **Stan początkowy:**  
  opis stanu poczatkowego
- **Kroki testowe:**
  1. krok 1
  2. krok 2
  3. ...
- **Oczekiwany rezultat:**  
  opis oczekiwanego rezultatu
- **Rzeczywisty rezultat:** _todo_
- **Rezultat testu:** _todo_
- **Stan końcowy:**  
  opis stanu koncowego

---
