# Wstęp

"
Układy cyfrowe są narażone na występowanie uszkodzeń przemijających[1],
powodowanych przez wysoko energetyczne cząsteczki np. promieniowanie kosmiczne (single-event upset).

Układy cyfrowe mogą być zabezpieczone w przed tym rodzajem błędów dzięki 
kodom detekcji błędów, lub powielaniu układów i porównywaniu ich działania.
" - 1. Introduction z Fault-Tolerant Implementation of Direct FIR Filters Protected Using Residue Codes

## Układ arytmetyczny odporny na błędy

Układ arytmetyczny odporny na błędy to układ którego wejścia, stany wewnętrzne i 
wyjścia są zakodowane za pomocą kodów wykrywających błędy. W przypadku wystąpienia 
błędu, jest on naprawiany, lub jest on wykrywany.

## Błędy

W kontekście układów arytmetycznych, ilość bitów o błędnej wartości nie ma aż takiego 
znaczenia, w porównaniu do wartości arytmetycznej błędu będącej dla pojedyńczych błędów
potęgą dwójki. Na tym założeniu, kody resztowe obliczane jako reszta z dzielenia przez
jakąś liczbę całkowitą nieparzystą, umożliwiają wykrycie błędów pojedyńczych, poza przypadkami, gdzie
wynik jest wielokrotnością liczby przez którą dzieliliśmy z resztą.

## Kody resztowe

Słowa kodowe kodów resztowych mod A są tworzone z części $X$ (liczba całkowita na której operujemy)
oraz $|X|_A$ (część kontrolna wynikająca z reszty dzielenie $X$ przez $A$ czyli $|X|_A \equiv X mod A$) w postaci $(X, |X|_A)$. 
Ponieważ $|X|_A$ jest resztą z dzielenia $X$ przez $A$, to $|X|_A$ zawsze przyjmuje wartości $(0 \leq |X|_A \leq A - 1)$. 
Z tego wynika własność kodów resztowych mod A, czyli, że wykrywają wszystkie błędy pojedyńcze
, których wartości kumulują się do wielokrotności A, 
gdy A jest liczbą całkowitą nieparzystą większą niż 1.

Kody resztowe mogą być stosowane do wszelkich układów arytmetycznych m.in. sumatory, subtraktory,
układy mnożące i dzielące. 

Mając liczby $X$ i $Y$, które są całkowitymi liczbami i ich reszty $|X|_A |Y|_A$, 
czyli mając operandy $C(X) = (X, |X|_A)$ oraz $C(Y) = (Y, |Y|_A)$, można zapisać operacje arytmetyczne
dodawania, odejmowania oraz mnożenia w następujący sposób:

$|X \pm Y|_A = ||X|_A \pm |Y|_A|_A$

$|X \cdot Y|_A = ||X|_A \cdot |Y|_A|_A$

Jak to pokazują powyższe równania, operacje arytmetyczne na całkowitych liczbach 
oraz ich resztach mod A można wykonywać osobno. Dzięki tej własności układ kontrolny kodów resztowych 
może składać się z generatora reszt mod A oraz komparatora. 

Sposób sprawdzania relacji i wykrywania błędów przez ten układ jest opisany w części poniżej.

## Jednostka arytmetyczna z wykrywaniem błędów przy użyciu kodów resztowych

Jednostkę arytmetyczną można by zabiezpieczyć przy pomocy kodów resztowych przez 
dołożenie do niej układu generatora reszt z wynikiem oryginalnego działania na wejściu.
Wynik generatora reszt jest następnie porównywany z wyjściem układu arytmetycznego mod A. 
W przypadku, gdy kody nie są równe, stwierdzane jest wystąpienie błędu.

Na obrazku \ref{img:piestrak} jest pokazany układ arytmetyczny zabezpieczony kodem resztowym mod A,
który ilustruje tę strukturę.

![Samosprawdzalny układ arytmetyczny zabezpieczony kodem resztowym mod A z prezentacji S. J. Piestrak "Wiarygodne systemy cyfrowe: pojęcia podst". \label{img:piestrak}](assets/uklad_zabezpieczony.png)

## Projekt

Podczas realizacji projektu, zaprojektowano jednostkę arytmetyczną odporną
na błędy przemijające, dzięki wymienionemu wcześniej sposobowi.
