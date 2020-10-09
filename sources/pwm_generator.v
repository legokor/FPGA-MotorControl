`timescale 1ns / 1ps

module pwm_generator #(
    parameter CNTR_BITS = 16
)(
    input clk,
    input [CNTR_BITS-1 : 0] period,
    input [CNTR_BITS-1 : 0] compare,

    output pwm_out
);

endmodule
