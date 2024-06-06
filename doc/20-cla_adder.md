# CLA adder

Carry look ahead (CLA) adder, jest sumatorem generującym niezależnie wszystkie 
wartości bitu carry dla każdej pozycji.

Działa on na podstawie rozszerzania wzoru $C_i = G_i + P_i C_{i-1}$ gdzie odpowiednio
$G_i = A_i B_i$, i $P_i = A_i + B_i$.

![Schemat 4 bitowego sumatora CLA \label{fig:cla}](assets/cla.png)

![Schemat 2 bitowego sumatora CLA obliczającego z liczb w mod 3 \label{fig:cla_mod3}](assets/cla_mod3.png)

\label{cla_adder}
Dzięki porównywaniu wyników z układu figura \ref{fig:cla} strona \pageref{fig:cla} i figura \ref{fig:cla_mod3} strona \pageref{fig:cla_mod3} możliwe jest do sprawdzenia 
wystąpienie błędów miękkich (soft errors)[1] za pomocą kodów resztkowych.

## Symulacja błędów

Aby zasymulować błędy miękkie (soft errors)[1] które mogą się pojawić podczas czasu pracy działania układu,
za większością bramek logicznych - pominięto szereg bramek w części obliczającej sumę, 
ze względu na powstałą redundancję w tamtym segmencie ugładu - zamocowano bramkę XOR, 
mającą umożliwić modyfikację sygnału wyjściowego.

Na potrzeby symulacji założono że błędy mogą powstać w części sumatora działającej na niezmodfikowanych
wejściach jak i działającej na kodach resztkowych. Wyniki symulacji widoczne są w tabeli \ref{tab:cla} strona \pageref{tab:cla}
