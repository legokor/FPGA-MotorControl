`timescale 1ns / 1ps

module pwm_generator_test;

reg clk;
reg enable;
reg reset;
reg [15:0] compare;
reg [15:0] period;

pwm_generator pwmGen(
    .en(enable),
    .clk(clk),
    .rst(reset),
    .cmp(compare),
    .period(period)
);

initial begin
    enable = 0;
    reset = 0;
    clk = 0; 
    compare = 0;
    period = 0;
    
    #50
    
    #10 enable = 1;
    #10 reset = 1;
    #10 reset = 0;
    
    #20 period = 255;
        compare = 50;
    
    #100000 compare = 100;
    
    #100000 compare = 150;
    
    #100000 compare = 200;
    
    #100000 compare = 250;
    
end

always #25 clk = ~clk;

endmodule

