module Sync_Clk_Sig(
	input async_in,
	input clk,
	output sync_sig
);

	reg ff1, ff2, ff3;
	logic auto_reset;

	always_ff @(posedge clk) begin
		ff2 <= ff1;
	end

	always_ff @(posedge clk) begin
		ff3 <= ff2;
	end

	always_ff @(posedge async_in or posedge auto_reset)	begin
		if (auto_reset) begin
			ff1 <= 1'b0;
		end else begin
			ff1 <= 1'b1;
		end
	end

	assign auto_reset = ff3 && (!async_in);
	assign sync_sig = ff3;

endmodule