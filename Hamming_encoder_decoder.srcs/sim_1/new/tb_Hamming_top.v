`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/04/2026 02:02:11 PM
// Design Name: 
// Module Name: tb_Hamming_top
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


module tb_Hamming_top;

    reg  [3:0] data_in;
    reg        parity;
    reg  [2:0] error_pos;

    wire [3:0] data_out;
    wire       error_detected;

    integer i, j;
    integer error_count;

    // DUT
    Hamming_top dut (
        .data_in        (data_in),
        .parity         (parity),
        .error_pos      (error_pos),
        .data_out       (data_out),
        .error_detected (error_detected)
    );

    initial begin
        parity = 1'b0; // even parity
        error_count = 0;

        $display("=== START FULL HAMMING TEST ===");

        // Quét toàn b? data_in (0 ? 15)
        for (i = 0; i < 16; i = i + 1) begin
            data_in = i[3:0];

            // Quét toàn b? error_pos (0 ? 7)
            for (j = 0; j < 8; j = j + 1) begin
                error_pos = j[2:0];
                #10;

                // CHECK 1: d? li?u ph?i ???c khôi ph?c
                if (data_out !== data_in) begin
                    $display("FAIL DATA  : data_in=%b error_pos=%0d data_out=%b",
                              data_in, error_pos, data_out);
                    error_count = error_count + 1;
                end

                // CHECK 2: error_detected ph?i ?úng
                if (error_detected !== (error_pos != 0)) begin
                    $display("FAIL ERROR : data_in=%b error_pos=%0d error_detected=%b",
                              data_in, error_pos, error_detected);
                    error_count = error_count + 1;
                end
            end
        end

        // K?T LU?N
        if (error_count == 0)
            $display("=== ALL TESTS PASSED SUCCESSFULLY ===");
        else
            $display("=== TEST FAILED : %0d ERRORS FOUND ===", error_count);

        $stop;
    end

endmodule

