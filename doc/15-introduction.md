# Wstęp

"
Układy cyfrowe są narażone na występowanie czasowych błędów miękkich[1],
powodowanych przez wysoko energetyczne cząsteczki (np. promieniowanie kosmiczne).

Układy cyfrowe mogą być zabezpieczone w przed tym rodzajem błędów dzięki 
kodom detekcji i naprawy błędów, lub powielaniu układów i porównywaniu ich działania.
" - wszystko z 1. Introduction z pdf

## Układ arytmetyczny odporny na błędy

Układ arytmetyczny odporny na błędy to układ którego wejścia, stany wewnętrzne i 
wyjścia są zakodowane za pomocą kodów wykrywających błędy. W przypadku wystąpienia 
błędu, jest on naprawiany, lub jest on wykrywany.

## Błędy

W kontekście układów arytmetycznych, ilość bitów o błędnej wartości nie ma aż takiego 
znaczenia, w porównaniu do wartości arytmetycznej błędu będącej dla pojedyńczych błędów
potęgą dwójki. Na tym założeniu, kody resztowe obliczane jako reszta z dzielenia przez
jakąś liczbę całkowitą nieparzystą, umożliwiają 100% wykrycie błędów pojedyńczych.

## Jednostka arytmetyczna z wykrywaniem błędów przy użyciu kodów resztowych

Jednostkę arytmetyczną można by zabiezpieczyć przy pomocy kodów resztowych przez
przez dołożenie do niej układu realizującego tę samą operację, na kodzie resztowym
wygenerowanym z generatora reszt do którego podano wejście orginalnego układu.
Wyjście pierwotnego układu artymetycznego, jest następnie podawane do generatora
reszt, i porównywane z wyjściem układu arytmetycznego na którego wejście podano
kod resztowy. W przypadku gdy kody są nie równe, stwierdzane jest wystąpienie błędu.

## Projekt

Podczas realizacji projektu, zaprojektowano jednostkę arytmetyczną odporną
na błędy miękkie, dzięki wymienionym wcześniej sposobie.
