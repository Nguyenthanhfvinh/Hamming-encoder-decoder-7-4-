`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/04/2026 03:09:21 PM
// Design Name: 
// Module Name: tb_encoder
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


module tb_encoder;

    reg  [3:0] data_in;
    reg        parity;
    wire [6:0] data_out;

    integer i;

    // DUT
    Hamming_encoder dut (
        .data_in  (data_in),
        .parity   (parity),
        .data_out (data_out)
    );

    initial begin
        parity = 1'b0; // even parity

        $display("=== TEST HAMMING ENCODER ===");

        for (i = 0; i < 16; i = i + 1) begin
            data_in = i[3:0];
            #10;

            $display("ENC | data_in=%b -> encoded=%b",
                      data_in, data_out);
        end

        $display("=== END ENCODER TEST ===");
        $stop;
    end

endmodule

