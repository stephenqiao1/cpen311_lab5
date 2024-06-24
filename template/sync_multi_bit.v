module Sync_Multi_Bit (
    input logic clk,    
    input logic rst,      
    input logic [11:0] sig, 
    output logic [11:0] sync_out
);

    reg [11:0] ff1, ff2;

    always_ff @(posedge clk, posedge rst) begin
        if (rst) begin
            ff1 <= 12'b0;
            ff2 <= 12'b0;
            sync_out <= 12'b0;
        end else begin
            ff1 <= sig;
            ff2 <= ff1;
            sync_out <= ff2;
        end
    end

endmodule
