# Sumator z antycypacją przeniesień (CLA)

Sumator z antycypacją przeniesień, jest sumatorem generującym niezależnie wszystkie 
wartości bitu carry dla każdej pozycji.

Działa on na podstawie rozszerzania wzoru $C_i = G_i + P_i C_{i-1}$ gdzie odpowiednio
$G_i = A_i B_i$, i $P_i = A_i + B_i$.

![Schemat 4 bitowego sumatora CLA zabezpieczonego kodami resztowymi, używa \ref{fig:cla_gen4}, \ref{fig:cla_gen2}, \ref{fig:cla_unit} \label{fig:cla_main}](assets/cla_main.png)

![Schemat 4 bitowego generatora carry \label{fig:cla_gen4}](assets/cla_gen4.png)

![Schemat 2 bitowego generatora carry \label{fig:cla_gen2}](assets/cla_gen2.png)

![Jedno ogniwo sumatora CLA, z możliwością wprowadzania błędów \label{fig:cla_unit}](assets/cla.png)

## Symulacja błędów

Aby zasymulować błędy przemijające które mogą się pojawić podczas czasu pracy działania układu,
za większością bramek logicznych zamocowano bramkę XOR, 
mającą umożliwić modyfikację sygnału wyjściowego.

Symulację przeprowadzono podając wszystkie wszystkie kombinacje błędów pojedyńczych, i sprawdzając 
czy układ wykryje wprowadzenie błędu.
Dla błędów pojedyńczych, układ był w stanie wykryć większość błędów. Poza tymi będącymi wilokrotnością 3.

![Układ CLA z wprowadzonym błędem pojedyńczym \label{fig:cla_err1}](assets/cla_err_1.png)

## Propagacja błędu

Z uwagi na równoległe przetwarzanie przeniesień układu, może zdarzyć się sytuacja, w której błąd pojedyńczy
propagowany jest przez cały układ. Przykład takiego zdarzenia jest widoczny poniżej.

![Sumator CLA, propagujący błąd \label{fig:cla_propagacja}](assets/cla_propagacja.png)
