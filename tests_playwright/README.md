# Testy GUI z Playwright

Instrukcja zakłada korzystania z `npm` jako menedżera paczek JavaScript.

## Instalowanie po spullowaniu

W folderze `tests_playwright` należy uruchomić polecenie

```commandline
npm install
```

Należy też ustawić sobie na już działającym Gutenbergu swojego admina, obecna wersja zakłada nazwę `diego_tester` i hasło `diego_tester`.

## Uruchamianie testów

Kiedy już działa w tle Gutenberg i jest dostępny pod `localhost/3000`, należy uruchomić polecenie
```commandline
npx playwright test
```

Zaleca się dodać następujące flagi: `tests/<nazwa pliku testowego>` dla wywołania konkretnego testu,
`--headed` dla otwierania okna przeglądarki podczas testów, oraz `--project=chromium`, aby wywoływało się
testowanie tylko w Chrome (są problemy z Firefoxem przy klikaniu różnych przycisków).

## Pisanie testów

Pliki z testami w folderze `/tests` powinny nazywać się `*.spec.js`.