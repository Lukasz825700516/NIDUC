# Układ mnożący

Układ mnożący jest układem cyfrowym wykonującym działanie mnożenia.

## Układ z kodami resztowymi

Zrealizowano układ mnożący obrazek \ref{img:mul_main} z układem mnożenia kodów resztowych.

![Układ mnożący zabezpieczony kodami resztowymi, używa \ref{img:mul_mul4}, \ref{img:mul_mul2}](assets/mul_main.png)

![Układ 4 bitowy wykonujący mnożenie, z możliwością wprowadzania błędów \label{img:mul_mul4}, używa \ref{img:mul_rca}](assets/mul_mul4.png)

![Układ 2 bitowy wykonujący mnożenie, z możliwością wprowadzania błędów\label{img:mul_mul2}, używa \ref{img:mul_rca}](assets/mul_mul2.png)

![Układ RCA, z możliwością wprowadzania błędów\label{img:mul_rca}](assets/mul_rca.png)

## Symulacja błędów

Dla układu przeprowadzono symulację, dla której dla każdego miejsca 
w którym mógł pojawić się błąd miękki, wprowazono błąd. Na każdą wersję
symulacji wprowadzono jeden błąd.

Zgodnie z teorią kodów resztowych, układ dla kodu resztowego MOD 3, wykrywał
wszyskie błędy pojedyńcze, które w implementacji układu przy użyciu wielu układów
RCA, generowały wyłącznie błędy o różnicy będącej potęgą dwójki.

Podczas symulacji w której występowały dwa błędy na raz, układ czasami nie był
w stanie wykryć wystąpienia błędu (testy błędu fałszywie negatywne), a czasami błąd 
był wykrywany. Zgodnie z przewidywaniami, było to spowodowane przez wynik arytmetyczny
który pokrywał się z bazą za którą wybrano 3.
