# CLA adder

Carry look ahead (CLA) adder, jest sumatorem generującym niezależnie wszystkie 
wartości bitu carry dla każdej pozycji.

Działa on na podstawie rozszerzania wzoru $C_i = G_i + P_i C_{i-1}$ gdzie odpowiednio
$G_i = A_i B_i$, i $P_i = A_i + B_i$.

![Schemat 4 bitowego sumatora CLA zabezpieczonego kodami resztowymi, używa \ref{fig:cla_gen4}, \ref{fig:cla_gen2}, \ref{fig:cla_unit} \label{fig:cla_main}](assets/cla_main.png)

![Schemat 4 bitowego generatora carry \label{fig:cla_gen4}](assets/cla_gen4.png)

![Schemat 2 bitowego generatora carry \label{fig:cla_gen2}](assets/cla_gen2.png)

![Jedno ogniwo sumatora CLA, z możliwością wprowadzania błędów \label{fig:cla_unit}](assets/cla.png)

## Symulacja błędów

Aby zasymulować błędy tymczasowe które mogą się pojawić podczas czasu pracy działania układu,
za większością bramek logicznych zamocowano bramkę XOR, 
mającą umożliwić modyfikację sygnału wyjściowego.

Symulację przeprowadzono podając wszystkie wszystkie kombinacje błędów pojedyńczych, i sprawdzając 
czy układ wykryje wprowadzenie błędu.
Dla błędów pojedyńczych (obrazek \ref{img:cla_err1}), układ był w stanie wykryć błąd.

W przypadku błędów podwójnych, układ gdy powstała różnica arytmetyczna była styczna z 3, 
układ nie wykrywał błędu (obrazek \ref{img:cla_err0}), a gdy nie była równa, wykrywał 
go (obrazek \ref{img:cla_err2})

![Układ CLA z wprowadzonym błędem pojedyńczym \label{img:cla_err1}](assets/cla_err_1.png)

![Układ CLA z wprowadzonym błędem podwójnym, różnica styczna z 3 \label{img:cla_err0}](assets/cla_err_0.png)

![Układ CLA z wprowadzonym błędem podwójnym, różnica niestyczna z 3 \label{img:cla_err2}](assets/cla_err_2.png)
