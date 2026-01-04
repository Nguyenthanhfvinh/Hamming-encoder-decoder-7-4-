`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/04/2026 12:11:55 PM
// Design Name: 
// Module Name: Hamming_top
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


module Hamming_top(

    input  [3:0] data_in,
    input         parity,     // 0=even, 1=odd
    input  [2:0]  error_pos,  // 0=no error, 1-7 inject error
    output [3:0]  data_out,
    output        error_detected
);

wire [6:0] encoded_data;
wire [6:0] encoded_with_error;

// Encoder
Hamming_encoder u_encoder (
    .data_in (data_in),
    .parity  (parity),
    .data_out(encoded_data)
);

// Inject 1-bit error
assign encoded_with_error =
    (error_pos == 3'd0) ? encoded_data :
    encoded_data ^ (7'b1 << (error_pos - 3'd1));

// Decoder
Hamming_decoder u_decoder (
    .data_in       (encoded_with_error),
    .data_out      (data_out),
    .error_detected(error_detected)
);

endmodule

