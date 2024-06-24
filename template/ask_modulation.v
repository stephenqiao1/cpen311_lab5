module ASK_Modulation (
	input logic clk,
	input logic reset,
	input logic [11:0] dds_out, // 12-bit DDS output
	input logic lfsr_bit,
	output logic [11:0] ask_out
);

	always_ff @(posedge clk, posedge reset) begin
		if (reset) begin
			ask_out <= 12'b0;
		end else begin
			if (lfsr_bit) begin
				ask_out <= dds_out; // Send the DDS signal
			end else begin
				ask_out <= 12'b0; // Send zero
			end
		end
	end

endmodule