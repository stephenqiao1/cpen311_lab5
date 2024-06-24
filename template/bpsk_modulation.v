module BPSK_Modulation(
	input logic clk,
	input logic reset,
	input logic [11:0] dds_out,
	input logic lfsr_bit,
	output logic [11:0] bpsk_out
);

	always_ff @(posedge clk, posedge reset) begin
		if (reset) begin
			bpsk_out <= 12'b0;
		end else begin
			if (lfsr_bit) begin
				bpsk_out <= dds_out; // Send the DDS signal
			end else begin
				bpsk_out <= ~dds_out + 1; // Send the inverted DDS signal
			end
		end
	end

endmodule