`timescale 1ns / 1ps

module servo_speed_control_test;

reg clk;
reg go;

reg [15:0] start_pos;
reg [15:0] end_pos;
reg [15:0] prescale;

servo_speed_control SSCTest(
    .start_pos(start_pos),
    .end_pos(end_pos),
    .prescale(prescale),
    .go(go),
    .clk(clk)
);

initial begin
    
    go = 0;
    clk = 0;
    start_pos = 50;
    end_pos = 127;
    prescale = 5;
    
    #20 go = 1;
    #20 go = 0;

end

always #25 clk = ~clk;

endmodule
