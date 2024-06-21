# Sumator z propagacją przeniesień (RCA)

Sumator z propagacją przeniesień jest układem sumującym opierającym się na szeregowo
podłączonych ogniwach sumatora pełnego.
Zbudowano ten układ z zabezpieczeniem przy użyciu kodów resztowych.

![Schemat 4 bitowego sumatora RCA, zabezpieczconego kodami resztowymi \label{fig:rca_main}

## Symulacja uszkodzeń

Przeprowadzono symulację układu, podczas której podano do niego wszystkie kombinacje uszkodzeń pojedyńczych,
a następnie parę podwójnych.

Dla uszkodzeń pojedyńczych układ syngalizował wykrycie błędu (obrazek \ref{img:rca_err1}) w przypadku gdy jego różnica arytmetyczna
była potęgą dwójki.

## Budowa komparatora

W celu porównania wyników resztowych, użyliśmy układu komparatora

### Synteza strukturalna

W celu utworzenia układu komparatora wykorzystaliśmy metodę siatek Karnough'a
utworzoną na podstawie tabeli prawdy gdzie X1, X0, Y1 i Y0 
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

\label{tab:kranuh_1}
Tabela prawdy komparatora

|######| Y1Y0 | 0 0 | 0 1 | 1 1 | 1 0 |
|------|------|-----|-----|-----|-----|
| X1X0 |######|#####|#####|#####|#####|
| 0  0 |######|  1  |  0  |  0  |  0  |
| 0  1 |######|  0  |  1  |  0  |  0  |
| 1  1 |######|  0  |  0  |  1  |  0  |
| 1  0 |######|  0  |  0  |  0  |  1  |
\label{tab:kranuh_2}
Tabela Karnough komparatora

$Sygnał    błędu = \overline{X1}\overline{X0}\overline{Y1}\overline{Y0} + \overline{X1}X0\overline{Y1}Y0 + X1X0Y1Y0 + X1\overline{X0}Y1\overline{Y0}$

![Układ RCA z wprowadzonym uszkodzeniem pojedyńczym \label{img:rca_err1}](assets/rca_err_1.png)

Na podstawie rysunków napisano symulację w system verilog, przechodzą przez wszystkie permutacje 
jednokrotnchy możliwych uszkodzeń układu.

```verilog
module testCLA ();
    reg[3:0] a, b, sum;
    reg[20:0] err;
    reg[2:0] cla_err;
    reg carry_in;
    wire [4:0]carry_out;

    reg clk;
	
    carry_gen4 carry_gen(
	    .a(a),
	    .b(b),
	    .carry_in(carry_in),
	    .carry_out(carry_out),
	    .err(err)
    );

    adder4_cla _adder(
        .a (a),
        .b(b),
        .err(err[11:14]),
        .carry_in(carry_in),
        .sum(sum),
        .carry_out(carry_out)
    );

    wire [1:0]amod, bmod, testmod, summod;
    mod3_gen atest(
	    .x({1'b0,a[3:0]}),
	    .y(amod),
	    .err(err[0:2])
    );
    mod3_gen btest(
	    .x({1'b0,b[3:0]}),
	    .y(bmod),
	    .err(err[3:5])
    );
    mod3_gen ctest(
	    .x({carry_out, sum[3:0]}),
	    .y(summod),
	    .err(err[6:8])
    );
    mod3_sum mod3sum(
	    .a(amod),
	    .b(bmod),
	    .sum(testmod),
	    .err(err[9:10])
    );

    wire err_detected;
    assign err_detected = !(testmod == summod);

    initial begin
        clk = 0;
        forever #1 clk = ~clk;
    end

    for (genvar j = 0; j < 15; j = j + 1) begin: g_err_2
        for (genvar i = 0; i < 6; i = i + 1) begin: g_err_1
            initial begin
                #((j * (5 * 4)) + (i * 2))
                a[3:0] = 4'd9;
                b[3:0] = 4'd1;
                carry_in = 0;
                err[j] = 5'b00001 << i;

                #1 $display("ok:%d err?:%d sum:%d %d %d", sum == 4'd10, err_detected, sum, j, i);
            end
        end
    end
endmodule
```
