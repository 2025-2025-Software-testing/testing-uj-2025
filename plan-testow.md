## PLAN TESTÓW
Przedmiotem Testów jest projekt https://github.com/KSIUJ/gutenberg 

1) Zakres Testów
   
Ze względu na wielkość projektu oraz dbałość o jakość kodu się pokryć testami wszystkie istniejące funkcjonalności *(eg. w kolorze, rozne typy plikow, konkretne strony, ilości kopii, podgląd, łączenie z inną drukarką, ...)*
z testów jednostkowych w szczególności chcemy się skupić na funkcjonalnościach opisanych w https://github.com/KSIUJ/gutenberg/issues/123

2) Strategia Testowania 
- Rodzaje testów:
  - **Testy funkcjonalne:** Weryfikacja, czy każda funkcja działa zgodnie z oczekiwaniami.
  - **Testy niefunkcjonalne:** Testy użyteczności (czy stronka jest intuicyjna i łatwa w obsłudze) oraz wydajności (czy czas ładowania jest akceptowalny)
  - **Testy jednostkowe.**
  - **Testy E2E.**
- Podejście do testowania: 
  - **Testy manualne:** przejście przez ścieżki użytkownika - funkcjonalne i niefunkcjonalne 
  - **Testy automatyczne:** funkcjonalne, jednostkowe i e2e
 
Ponadto, w ramach przeprowadzania testów, będziemy zbierać opinię użytkowników, dzięki temu będziemy lepiej wiedzieć, na których aspektach/funkcjonalnościach się skupić. (też będą testerami manualnymi:))

3) Środowisko Testowe (Konfiguracja sprzętowa i programowa)
- pytest
- wirtualna drukarka (cups pdf)

5) Kryteria Wejścia/Wyjścia
- wejścia:
  - Dominik zrobi nam tutorial obsługi wirtualnej drukarki i stawiania tego lokalnie *alternatywnie* nowa wersja guthenberga wyjdzie i nie będziemy musieli tego stawiać lokalnie, wtedy tylko wirtualna drukarka
- wyjścia:
  - wszystko działa bez zarzutów:)

6) Zarządzanie Defektami oraz Raportowanie Postępu i Wyników
- Do repozytorium projektu dodamy plan testów - a także *issues* dla każdego z przeprowadzanych testów, po przeprowadzeniu każdego z nich będziemy:
  - Zamykać issue - Jeśli test działa
  - Utworzenie issue z bugiem - Jeśli jest bug
  
6) Analiza ryzyk

Główną uwagę skupimy na kodzie w którym już są defekty oraz na funkcjonalnościach, które według badania środowiskowego zostaną uznane za krytyczne.

Ryzyka:
- drukarka losowo przestanie działać

7) Harmonogram

* Przeprowadzenie wywiadu środowiskowego, żeby zidentyfikować istniejące defekty oraz funkcjonalności o wysokim ryzyku występowania defektów
* Analiza istniejących defektów
* Kontakt z developerem i ustalenie krytycznych według niego partii kodu
* Analiza ryzyk na podstawie zebranych informacji
* Testy jednostkowe
* Testy E2E
* Testy eksploracyjne
