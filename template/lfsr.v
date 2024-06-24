module LFSR(
		input logic clk,
		input logic clr,
		output logic [4:0] lfsr
);

	always_ff @(posedge clk or posedge clr) begin
		if (clr) begin
			lfsr[4] <= 1'b0;
			lfsr[3] <= 1'b0;
			lfsr[2] <= 1'b0;
			lfsr[1] <= 1'b0;
			lfsr[0] <= 1'b1;
		end else begin
			lfsr[3] <= lfsr[4];
			lfsr[2] <= lfsr[3];
			lfsr[1] <= lfsr[2];
			lfsr[0] <= lfsr[1];
			lfsr[4] <= (lfsr[0] ^ lfsr[2]);
		end
	end


endmodule