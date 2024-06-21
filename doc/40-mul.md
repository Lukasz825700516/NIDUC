# Układ mnożący

Układ mnożący jest układem cyfrowym wykonującym działanie mnożenia.

## Układ z kodami resztowymi

Zrealizowano układ mnożący obrazek z układem mnożenia kodów resztowych.

![Układ mnożący zabezpieczony kodami resztowymi \label{img:mul_main}](assets/mul_main.png)

![Układ 4 bitowy wykonujący mnożenie, z możliwością wprowadzania błędów \label{img:mul_mul4}, używa \ref{img:mul_rca}](assets/mul_mul4.png)

![Układ 2 bitowy wykonujący mnożenie, z możliwością wprowadzania błędów\label{img:mul_mul2}, używa \ref{img:mul_rca}](assets/mul_mul2.png)

![jedno ogniwo układu RCA, z możliwością wprowadzania błędów\label{img:mul_rca}](assets/mul_rca.png)

## Symulacja uszkodzeń

Dla układu przeprowadzono symulację, w której kolejno wprowadzano błąd przmijający na każdej z bramek układu. 

Zgodnie z teorią kodów resztowych, układ dla kodu resztowego MOD 3, wykrywał
wszyskie uszkodzenia pojedyńcze (obrazek \ref{img:mul_err_1}), które w implementacji układu przy użyciu wielu układów
RCA, generowały wyłącznie uszkodzenia o różnicy arytmetycznej będącej potęgą dwójki.

![Symulacja z wprowadzonym pojedyńczym uszkodzeniem \label{img:mul_err_1}](assets/mul_err_1.png)

Na podstawie rysunków napisano symulację w system verilog, przechodzą przez wszystkie permutacje 
jednokrotnchy możliwych uszkodzeń układu.

\newpage

```verilog
module testMUL ();
    reg[3:0] a, b;
    reg [7:0]mul;
    reg[44:0] err;
    reg[2:0] cla_err;
    reg carry_in;
    wire [4:0]carry_out;

    reg clk;
	
    adder4_mul _mul(
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
    mod3_mul mod3mul(
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

        for (genvar i = 0; i < 44; i = i + 1) begin: g_err_1
            initial begin
                #((j * (5 * 4)) + (i * 2))
                a[3:0] = 4'd9;
                b[3:0] = 4'd1;
                carry_in = 0;
                err = 44'b1 << i;

                #1 $display("ok:%d err?:%d mul:%d %d %d", sum == 4'd9, err_detected, sum, j, i);
            end
    end
endmodule
```
