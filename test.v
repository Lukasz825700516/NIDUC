module adder (
	input a, b, carry_in,
	output sum, carry_out
);
	assign sum = a ^ b ^ carry_in;
	assign carry_out = (a | b) ^ carry_in;
endmodule

module adder32 (
	input a[32], b[32], carry_in,
	output sum[32], carry_out
);
	wire carry[32 + 1];

	assign carry[0] = carry_in;

	genvar i;
	for (i = 0; i < 32; i = i + 1) begin 
		adder _adder(
			.a(a[i]), 
			.b(b[i]),
			.carry_in(carry[i]),
			.sum(sum[i]),
			.carry_out(carry[i + 1])
		);
	end

	assign carry_out = carry[31];
endmodule

module test ();
	reg a[32], b[32], sum[32], carry_in, carry_out;


	adder32 _adder(
		.a (a),
		.b(b),
		.carry_in(carry_in),
		.sum(sum),
		.carry_out(carry_out)
	);

	initial begin
		a[31:0] = 32'h69;
		b[31:0] = 32'h1000;
		carry_in = 0;
		$display("sum %d+%d+%d = %d + %d", a, b, carry_in, sum, carry_out);
	end
endmodule
