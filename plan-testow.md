## PLAN TESTÓW
Przedmiotem Testów jest projekt https://github.com/KSIUJ/gutenberg 

1) Zakres Testów
   
Ze względu na wielkość projektu oraz dbałość o jakość kodu się pokryć testami wszystkie istniejące funkcjonalności *(eg. w kolorze, rozne typy plikow, konkretne strony, ilości kopii, podgląd, łączenie z inną drukarką, ...)*

Główną uwagę skupimy na kodzie w którym już są defekty oraz na funkcjonalnościach, które według badania środowiskowego zostaną uznane za krytyczne.

2) Strategia Testowania 
- Rodzaje testów:
  - **Testy funkcjonalne:** Weryfikacja, czy każda funkcja działa zgodnie z oczekiwaniami.
  - **Testy niefunkcjonalne:** Testy użyteczności (czy stronka jest intuicyjna i łatwa w obsłudze) oraz wydajności (czy czas ładowania jest akceptowalny)
  - **Testy jednostkowe.**
  - **Testy E2E.**
- Podejście do testowania: 
  - **Testy manualne:** przejście przez ścieżki użytkownika - funkcjonalne i niefunkcjonalne 
  - **Testy automatyczne:** funkcjonalne, jednostkowe i e2e
 

3) Środowisko Testowe (Konfiguracja sprzętowa i programowa)
- python - pytest
- wirtualna drukarka (cups pdf)
- GitHub

4) Kryteria Wejścia/Wyjścia
- wejścia:
  -  ~~Dominik zrobi nam tutorial obsługi wirtualnej drukarki i stawiania tego lokalnie~~ *alternatywnie* nowa wersja Gutenberga wyjdzie i nie będziemy musieli tego stawiać lokalnie, wtedy tylko wirtualna drukarka (w międzyczasie wyszedł gutenberg)
- wyjścia:
  - wszystkie testy manualne zostaną przeprowadzone przynajmniej raz
  - testy jednostkowe i e2e zostaną napisane

5) Zarządzanie Defektami oraz Raportowanie Postępu i Wyników
Do repozytorium projektu dodamy plan testów - a także *issues* dla każdej z partii przeprowadzanych testów, po przeprowadzeniu będziemy zamykać issue testu a następnie, jeśli test nie przechodzi stworzymy nowe issue z bugiem
  
6) Analiza ryzyk

- skill issue nasze
- lenistwo testerów
- dodanie automatycznych testów może wymagać znacznych refactorów kodu
- niektóre testy mogą utrudnić przyszłe modyfikacje

7) Harmonogram

* Przeprowadzenie wywiadu środowiskowego, żeby zidentyfikować istniejące defekty oraz funkcjonalności o wysokim ryzyku występowania defektów
* Analiza istniejących defektów
* Kontakt z developerem i ustalenie krytycznych według niego partii kodu
* Analiza ryzyk na podstawie zebranych informacji
* Testy jednostkowe
* Testy E2E
* Testy eksploracyjne

*jesli umiejętności pozwolą chcemy dodać także code coverage przy automatycznych testach*
