`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/04/2026 12:11:55 PM
// Design Name: 
// Module Name: Hamming_encoder
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


module Hamming_encoder(
    input [3:0] data_in,
    input  parity, // 0 even , 1 odd 
    output [6:0] data_out
);

wire p3 , p2 ,p1 ; 

// wire d1 = data_in[0];
// wire d2 = data_in[1];
// wire d3 = data_in[2];
// wire d4 = data_in[3];
wire d1, d2, d3, d4;
assign {d4, d3, d2, d1} = data_in;

assign p1 = d1 ^ d2 ^ d3 ^d4 ^ parity ;
assign p2 = d1 ^ d3 ^ d4 ^ parity ; 
assign p3 = d2 ^ d3 ^ d4 ^ parity ;

assign data_out = {d4,d3,d2,p3,d1,p2,p1};

endmodule
