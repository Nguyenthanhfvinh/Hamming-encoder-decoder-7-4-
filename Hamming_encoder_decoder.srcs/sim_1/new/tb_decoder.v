`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/04/2026 03:09:21 PM
// Design Name: 
// Module Name: tb_decoder
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


module tb_decoder;


    // ===== Signals =====
    reg  [3:0] data_in;
    reg        parity;

    wire [6:0] encoded_data;

    reg  [6:0] received_data;
    wire [3:0] data_out;
    wire       error_detected;

    integer i, j;
    integer error_count;

    // ===== Encoder (reference) =====
    Hamming_encoder u_encoder (
        .data_in  (data_in),
        .parity   (parity),
        .data_out (encoded_data)
    );

    // ===== Decoder (DUT) =====
    Hamming_decoder dut (
        .data_in       (received_data),
        .data_out      (data_out),
        .error_detected(error_detected)
    );

    initial begin
        parity = 1'b0; // even parity
        error_count = 0;

        $display("=== START HAMMING DECODER TEST ===");

        // Quét toàn b? data_in
        for (i = 0; i < 16; i = i + 1) begin
            data_in = i[3:0];
            #10;

            // ---- Case 1: Không l?i ----
            received_data = encoded_data;
            #10;

            if (data_out !== data_in || error_detected !== 1'b0) begin
                $display("FAIL NO ERROR | data_in=%b data_out=%b err=%b",
                          data_in, data_out, error_detected);
                error_count = error_count + 1;
            end

            // ---- Case 2: L?i 1-bit (1 ? 7) ----
            for (j = 1; j <= 7; j = j + 1) begin
                received_data = encoded_data ^ (7'b1 << (j - 1));
                #10;

                if (data_out !== data_in || error_detected !== 1'b1) begin
                    $display("FAIL BIT %0d | data_in=%b recv=%b data_out=%b err=%b",
                              j, data_in, received_data, data_out, error_detected);
                    error_count = error_count + 1;
                end
            end
        end

        // ---- K?t lu?n ----
        if (error_count == 0)
            $display("=== DECODER TEST PASSED ===");
        else
            $display("=== DECODER TEST FAILED : %0d ERRORS ===", error_count);

        $stop;
    end

endmodule

