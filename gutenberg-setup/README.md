# Magiczny skrypt do uruchamiania Gutenberga

## Uwagi
* Działa tylko na Linuxie (testowane na Ubuntu 22.04)
* Żeby zainstalować należy uprzednio pobrać:
	* Docker-a
	* Docker Compose V2 (na ubuntu paczka nazywa się `docker-compose-v2`)

## Skrypciki
### run.sh
Uruchamia Gutenberga, jeśli nie został jeszcze pobrany i skonfigurowany to konfiguruje go i instaluje — być może z pominięciem dokumentacji, bo paczka mdbook wywala errory przy budowaniu projektu :# Żeby móc korzystać z projektu należy chwilę poczekać. U mnie strona zaczyna działać, kiedy `celery` wyświetli coś takiego:

```
gutenberg-celery   |  
gutenberg-celery   |  -------------- celery@28e55bab5578 v5.5.3 (immunity)
gutenberg-celery   | --- ***** ----- 
gutenberg-celery   | -- ******* ---- Linux-6.8.0-90-generic-x86_64-with-glibc2.41 2025-12-17 08:57:10
gutenberg-celery   | - *** --- * --- 
gutenberg-celery   | - ** ---------- [config]
gutenberg-celery   | - ** ---------- .> app:         gutenberg:0x7495e6bdb620
gutenberg-celery   | - ** ---------- .> transport:   redis://gutenberg-redis:6379/0
gutenberg-celery   | - ** ---------- .> results:     disabled://
gutenberg-celery   | - *** --- * --- .> concurrency: 16 (thread)
gutenberg-celery   | -- ******* ---- .> task events: OFF (enable -E to monitor tasks in this worker)
gutenberg-celery   | --- ***** ----- 
gutenberg-celery   |  -------------- [queues]
gutenberg-celery   |                 .> celery           exchange=celery(direct) key=celery
```

Żeby wyłączyć skubańca, należy ciepnąć CTRL + C (wystarczy raz (chyba że jest się barbarzyńcą))

### purge.sh
Usuwa wszystkie pobrane pliki, usuwa Gutenberga oraz usuwa kontenery dockera powiązane z Gutenbergiem.

### shutdown\_gucio.sh
Usuwa powiązane z Gutenbergiem kontenery.

### add\_admin.sh
Dodaje jednego admina — trzeba wpisać pożądane hasło i nazwę użytkownika.
