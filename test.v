module adder (
    input a, b, carry_in,
    input[4:0] err,
    output sum, carry_out
);
    wire z1, z2, z3, z4, z5;

    assign z1 = (a ^ b) ^ err[0];
    assign z2 = (a & b) ^ err[1];
    assign z3 = (z1 ^ carry_in) ^ err[2];
    assign z4 = (z1 & carry_in) ^ err[3];
    assign z5 = (z4 | z2) ^ err[4];

    assign sum = z3;
    assign carry_out = z5;
endmodule

module cla_add(
	input a,b, carry,
	input[2:0] err,
	output sum
);
    wire z1, z2, z3;

    assign z1 = (a ^ b) ^ err[0];
    assign z2 = (a & b) ^ err[1];
    assign z3 = (z1 ^ carry_in) ^ err[2];

    assign sum = z3;
endmodule

module carry_gen4 (
	input [3:0] a,b,
	input carry_in,
	output [4:0] carry_out,
	input[20:0] err
);

	wire z0,z1,z2,z3,z4,z5,z6,z7,z8,z9;
	wire a0,a1,a2,a3;
	wire o0,o1,o2,o3;

	assign a0 = (a[0] & b[0]) ^ err[0];
	assign o0 = (a[0] | b[0]) ^ err[1];
	assign a1 = (a[1] & b[1]) ^ err[2];
	assign o1 = (a[1] | b[1]) ^ err[3];
	assign a2 = (a[2] & b[2]) ^ err[4];
	assign o2 = (a[2] | b[2]) ^ err[5];
	assign a3 = (a[3] & b[3]) ^ err[6];
	assign o3 = (a[3] | b[3]) ^ err[7];
	

	assign carry_out[0] = carry_in;
	assign z0 = (o0 & carry_in) ^ err[8];
	assign carry_out[1] = (z0 | a0) ^ err[11];
	assign z1 = (o1 & o0 & carry_in) ^ err[9];
	assign z2 = (o1 & a0) ^ err[10];
	assign carry_out[2] = (z1 | z2 | a1) ^ err[15];
	assign z3 = (o2 & o1 & o0 & carry_in) ^ err[12];
	assign z4 = (o2 & o1 & a0) ^ err[13];
	assign z5 = (o2 & a1) ^ err[14];
	assign carry_out[3] = (z3 | z3 |z5 | a2) ^ err[15];
	assign z6 = (o3 & o2 & o1 & o0 & carry_in) ^ err[16];
	assign z7 = (o3&o2 & o1 & a0) ^ err[17];
	assign z8 = (o3&o2 & a1) ^ err[18];
	assign z9 = (o3&a2) ^ err[19];
	assign carry_out[3] = (z6 | z7 | z8| z9| a3) ^ err[20];

endmodule

module mod3_gen(
	input[4:0] x,
	output [1:0] y,
	input [4:0]err[3]
);
	wire sum[10];

	adder _a(
		.carry_in(x[0]),
		.a(!x[1]),
		.b(x[2]),
		.err(err[0]),
		.sum(sum[0]),
		.carry_out(sum[1])
	);
	adder _b(
		.carry_in(sum[0]),
		.a(!sum[1]),
		.b(!x[3]),
		.err(err[1]),
		.sum(sum[2]),
		.carry_out(sum[3])
	);
	adder _c(
		.carry_in(sum[2]),
		.a(!sum[3]),
		.b(x[4]),
		.err(err[2]),
		.sum(sum[4]),
		.carry_out(sum[5])
	);

	assign y[0] = sum[4] ^ sum[5];
	assign y[1] = !sum[4];
endmodule

module mod3_sum(
	input [1:0] a,b,
	output [1:0] sum,
	input [4:0] err[2]
);
	wire [1:0]x;

	adder _a(
		.carry_in(a[0]),
		.a(!a[1]),
		.b(b[0]),
		.err(err[0]),
		.sum(x[0]),
		.carry_out(x[1])
	);
	adder _b(
		.carry_in(x[0]),
		.a(!x[1]),
		.b(!b[1]),
		.err(err[1]),
		.sum(sum[0]),
		.carry_out(sum[1])
	);
endmodule
module mod3_mul(
	input [1:0] a,b,
	output [1:0] sum,
	input [5:0] err
);
	wire z2, z3, z4, z5;

	assign sum[1] = (z1 | z2) ^ err[0];
	assign z1 = (b[1] & a[0]) ^ err[1];
	assign z2 = (b[0] & a[1]) ^ err[5];
	assign sum[0] = (z4 | z5) ^ err[2];
	assign z4 = (a[0] & b[0]) ^ err[3];
	assign z5 = (a[1] & b[1]) ^ err[4];
endmodule

module rca(
	input [3:0] a, b,
	input carry_in,
	output [3:0] sum,
	output carry_out,
	output error
);
	wire carry[4 + 1];
	wire carrymod[2 + 1];
	wire [1:0] amod, bmod;

	assign carry[0] = carry_in;
	assign amod = a % 3'd3;
	assign bmod = b % 3'd3;



	genvar i;
	for (i = 0; i < 4; i = i + 1) begin: g_ripple
		adder _adder(
			.a(a[i]),
			.b(b[i]),
			.err(err[i]),
			.carry_in(carry[i]),
			.sum(sum[i]),
			.carry_out(carry[i + 1])
		);
	end

	for (i = 0; i < 2; i = i + 1) begin: g_ripplemod
		adder _adder(
			.a(amod[i]),
			.b(bmod[i]),
			.err(err[i]),
			.carry_in(carrymod[i]),
			.sum(sum[i]),
			.carry_out(carry[i + 1])
		);
	end

    assign carry_out = carry[4];
	
endmodule

module adder32 (
    input[31:0] a, b,
    input carry_in,
    input[4:0] err[32],
    output[31:0] sum,
    output carry_out
);
    wire carry[32 + 1];

    assign carry[0] = carry_in;

    genvar i;
    for (i = 0; i < 32; i = i + 1) begin: g_ripple
        adder _adder(
            .a(a[i]),
            .b(b[i]),
            .err(err[i]),
            .carry_in(carry[i]),
            .sum(sum[i]),
            .carry_out(carry[i + 1])
        );
    end

    assign carry_out = carry[31];
endmodule

module adder4 (
    input[3:0] a, b,
    input carry_in,
    input[4:0] err[4],
    output[3:0] sum,
    output carry_out
);
    wire carry[4 + 1];

    assign carry[0] = carry_in;

    genvar i;
    for (i = 0; i < 4; i = i + 1) begin: g_ripple
        adder _adder(
            .a(a[i]),
            .b(b[i]),
            .err(err[i]),
            .carry_in(carry[i]),
            .sum(sum[i]),
            .carry_out(carry[i + 1])
        );
    end

    assign carry_out = carry[4];
endmodule

module adder4_cla (
    input[3:0] a, b, c,
    input[2:0] err[4],
    output[3:0] sum,
    output carry_out
);
    genvar i;
    for (i = 0; i < 4; i = i + 1) begin: g_ripple
        cla_add _adder(
            .a(a[i]),
            .b(b[i]),
            .err(err[i]),
            .carry_in(c[i]),
            .sum(sum[i]),
        );
    end
endmodule

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
