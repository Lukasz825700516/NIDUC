# Ripple carry adder

Ripple carry adder jest układem sumującym opierającym się na szeregowo
podłączonych ogniwach sumatora pełnego.
Zbudowano ten układ z zabezpieczeniem przy użyciu kodów resztowych na obrazku \ref{fig:rca_main}.

![Schemat 4 bitowego sumatora CLA, zabezpieczconego kodami resztowymi \label{fig:rca_main}, używa \ref{img:mul_rca}](assets/rca_main.png)

## Symulacja błędów

Przeprowadzono symulację układu, podczas której podano do niego wszystkie kombinacje błędów pojedyńczych,
a następnie parę podwójnych.

Dla błędów pojedyńczych układ zawsze syngalizował wykrycie błędu (obrazek \ref{img:rca_err1}). Dla błędów podwójnych,
jeśli różnica arytmetyczna błędu była styczna z 3, bąd nie był wykrywany (obrazek \ref{img:rca_err0}), w 
przeciwnym przypadaku, błąd był pomyślnie wykrywany (obrazek \ref{img:rca_err2}).

![Układ RCA z wprowadzonym błędem pojedyńczym \label{img:rca_err1}](assets/rca_err_1.png)

![Układ RCA z wprowadzonym błędem podwójnym, różnica styczna z 3 \label{img:rca_err0}](assets/rca_err_0.png)

![Układ RCA z wprowadzonym błędem podwójnym, różnica niestyczna z 3 \label{img:rca_err2}](assets/rca_err_2.png)
