module Sync_Clk_Sig(
	input logic clk,
	input logic rst,
	input logic sig,
	output logic sync_out
);

	reg ff1, ff2;
	
	always_ff @(posedge clk, posedge rst) begin
		if (rst) begin
			ff1 <= 1'b0;
			ff2 <= 1'b0;
			sync_out <= 1'b0;
		end else begin
			ff1 <= sig;
			ff2 <= ff1;
			sync_out <= ff2;
		end
	end

endmodule