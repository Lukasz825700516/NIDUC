# Sumator z propagacją przeniesień (RCA)

Sumator z propagacją przeniesień jest układem sumującym opierającym się na szeregowo
podłączonych ogniwach sumatora pełnego.
Zbudowano ten układ z zabezpieczeniem przy użyciu kodów resztowych.

![Schemat 4 bitowego sumatora RCA, zabezpieczconego kodami resztowymi \label{fig:rca_main}

## Symulacja błędów

Przeprowadzono symulację układu, podczas której podano do niego wszystkie kombinacje błędów pojedyńczych.
Dla błędów pojedyńczych układ zawsze syngalizował wykrycie błędu.

##Budowa komparatora

W celu porównania wyników resztowych, użyliśmy układu komparatora

###Synteza strukturalna

W celu utworzenia układu komparatora wykorzystaliśmy metodę siatek Karnough'a, gdzie X1, X0, Y1 i Y0 
są kolejnymi sygnałami kodów resztowych, a błąd jest naszym sygnałem wykrycia błędu. 

| X1 | X0 | Y1 | Y0 | Błąd |
|----|----|----|----|------|
| 0  | 0  | 0  | 0  |   1  |
| 0  | 0  | 0  | 1  |   0  |
| 0  | 0  | 1  | 0  |   0  |
| 0  | 0  | 1  | 1  |   0  |
| 0  | 1  | 0  | 0  |   0  |
| 0  | 1  | 0  | 1  |   1  |
| 0  | 1  | 1  | 0  |   0  |
| 0  | 1  | 1  | 1  |   0  |
| 1  | 0  | 0  | 0  |   0  |
| 1  | 0  | 0  | 1  |   0  |
| 1  | 0  | 1  | 0  |   1  |
| 1  | 0  | 1  | 1  |   0  |
| 1  | 1  | 0  | 0  |   0  |
| 1  | 1  | 0  | 1  |   0  |
| 1  | 1  | 1  | 0  |   0  |
| 1  | 1  | 1  | 1  |   1  |

|######| Y1Y0 | 0 0 | 0 1 | 1 1 | 1 0 |
|------|------|-----|-----|-----|-----|
| X1X0 |######|#####|#####|#####|#####|
| 0  0 |######|  1  |  0  |  0  |  0  |
| 0  1 |######|  0  |  1  |  0  |  0  |
| 1  1 |######|  0  |  0  |  1  |  0  |
| 1  0 |######|  0  |  0  |  0  |  1  |

$Sygnał    błędu = \overline{X1}\overline{X0}\overline{Y1}\overline{Y0} + \overline{X1}X0\overline{Y1}Y0 + X1X0Y1Y0 + X1\overline{X0}Y1\overline{Y0}$

![Układ RCA z wprowadzonym błędem pojedyńczym \label{img:rca_err1}](assets/rca_err_1.png)

![Układ RCA z wprowadzonym błędem podwójnym, różnica styczna z 3 \label{img:rca_err0}](assets/rca_err_0.png)

![Układ RCA z wprowadzonym błędem podwójnym, różnica niestyczna z 3 \label{img:rca_err2}](assets/rca_err_2.png)
