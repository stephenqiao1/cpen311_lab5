module LFSR(
		input logic clk,
		input logic clr,
		output logic [4:0] lfsr = 5'b00001
);
	
	logic feedback;
	
	always_ff @(posedge clk or posedge clr) begin
    if (clr) begin
        lfsr <= 5'b00001; // Reset to default value
    end else begin
        lfsr <= {feedback, lfsr[4:1]}; // LFSR with feedback polynomial
    end
end

	assign feedback = lfsr[0] ^ lfsr[2];

endmodule