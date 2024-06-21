# Sumator z antycypacją przeniesień (CLA)

Sumator z antycypacją przeniesień, jest sumatorem generującym niezależnie wszystkie 
wartości bitu carry dla każdej pozycji.

Działa on na podstawie rozszerzania wzoru $C_i = G_i + P_i C_{i-1}$ gdzie odpowiednio
$G_i = A_i B_i$, i $P_i = A_i + B_i$.

![Schemat 4 bitowego sumatora CLA zabezpieczonego kodami resztowymi, używa \ref{fig:cla_gen4}, \ref{fig:cla_gen2}, \ref{fig:cla_unit} \label{fig:cla_main}](assets/cla_main.png)

![Schemat 4 bitowego generatora carry \label{fig:cla_gen4}](assets/cla_gen4.png)

![Schemat 2 bitowego generatora carry \label{fig:cla_gen2}](assets/cla_gen2.png)

![Jedno ogniwo sumatora CLA, z możliwością wprowadzania błędów \label{fig:cla_unit}](assets/cla.png)

## Symulacja uszkodzeń

Aby zasymulować uszkodzenie przemijające które mogą się pojawić podczas czasu pracy działania układu,
za większością bramek logicznych zamocowano bramkę XOR, 
mającą umożliwić modyfikację sygnału wyjściowego.

Symulację przeprowadzono podając wszystkie wszystkie kombinacje uszkodzeń pojedyńczych, i sprawdzając 
czy układ wykryje wprowadzenie błędu.
Układ był w stanie wykryć większość uszkodzeń. Poza tymi będącymi generującymi różnicę arytmetyczną będącą wilokrotnością 3.

![Układ CLA z wprowadzonym błędem pojedyńczym \label{fig:cla_err1}](assets/cla_err_1.png)

## Propagacja błędu

Z uwagi na równoległe przetwarzanie przeniesień układu, może zdarzyć się sytuacja, w której błąd pojedyńczy
propagowany jest przez cały układ. Przykład takiego zdarzenia jest widoczny poniżej.

![Sumator CLA, propagujący błąd \label{fig:cla_propagacja}](assets/cla_propagacja.png)
![Układ CLA z wprowadzonym błędem pojedyńczym \label{fig:cla_err1}](assets/cla_err_1.png)

Na podstawie rysunków napisano symulację w system verilog, przechodzą przez wszystkie permutacje 
jednokrotnchy możliwych uszkodzeń układu.

```verilog
module testRCA ();
    reg[3:0] a, b, sum;
    reg[4:0] err[15];
    reg carry_in, carry_out;

    reg clk;

    adder4 _adder(
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
>>>>>>> 26be930 (dpaawd)
