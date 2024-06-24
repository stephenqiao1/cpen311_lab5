module DDS(
	input logic clk,
	input logic reset_n,
	input logic en,
	input logic [31:0] phase_inc,
	output logic [11:0] sin_out,
	output logic [11:0] cos_out,
	output logic [11:0] squ_out,
	output logic [11:0] saw_out
);

	 // Internal registers and logic
    reg [31:0] phase_accumulator = 32'b0;
	 
	 always_ff @(posedge clk, negedge reset_n) begin
		if (~reset_n) begin
			phase_accumulator <= 32'b0;
		end if (en) begin
			phase_accumulator <= phase_accumulator + phase_inc;
		end else begin
			phase_accumulator <= phase_accumulator;
		end 
	 end
	 
	  // Instantiate the waveform_gen VHDL module
    waveform_gen waveform_gen_inst (
        .clk(clk),
        .reset(!reset_n),
        .en(en),
        .phase_inc(phase_inc),
        .sin_out(sin_out),
        .cos_out(cos_out),
        .squ_out(squ_out),
        .saw_out(saw_out)
    );
	
	
endmodule