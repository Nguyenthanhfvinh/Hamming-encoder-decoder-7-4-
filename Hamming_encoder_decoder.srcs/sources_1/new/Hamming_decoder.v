`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/04/2026 12:11:55 PM
// Design Name: 
// Module Name: Hamming_decoder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Hamming_decoder(
    input [6:0] data_in,
    output [3:0] data_out,
    output  error_detected 
);
wire [2:0] syndrome;
wire r1, r2, r3, r4, r5, r6, r7 ;
reg [6:0] data_corrected;

assign {r7, r6 , r5 ,r4, r3 , r2 , r1} = data_in; 
// assign {r1, r2, r3, r4, r5, r6, r7} = data_in;
assign syndrome[0] = r1 ^ r3 ^ r5 ^ r7; // c1
assign syndrome[1] = r2 ^ r3 ^ r6 ^ r7; // c2
assign syndrome[2] = r4 ^ r5 ^ r6 ^ r7; // c4

always @(*) begin
    data_corrected = data_in;
    if (syndrome != 3'b000) begin
        data_corrected[syndrome - 3'd1] = ~data_corrected[syndrome - 3'd1];

    end
end

// Trích xu?t d? li?u g?c t? chu?i ?ã s?a
    assign data_out[0] = data_corrected[2]; // D3
    assign data_out[1] = data_corrected[4]; // D5
    assign data_out[2] = data_corrected[5]; // D6
    assign data_out[3] = data_corrected[6]; // D7
    
    assign error_detected = (syndrome != 0);

endmodule 
