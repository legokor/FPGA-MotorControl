`timescale 1ns / 1ps

module servo_speed_control #(
    parameter CNTR_BITS = 16 
)(
    input [CNTR_BITS - 1:0] start_pos,
    input [CNTR_BITS - 1:0] end_pos,
    input [CNTR_BITS - 1:0] speed,
    
    input go,
    
    input clk,
    
    output rdy,
    output [CNTR_BITS - 1:0] out_cmp
);
    
    reg [CNTR_BITS - 1:0] current;
    reg [CNTR_BITS - 1:0] end_reg;
    reg [CNTR_BITS - 1:0] speed_reg;
    
    always@ (posedge clk) begin
            
        if(go) begin
            
            current <= start_pos;
            end_reg <= end_pos;
            speed_reg <= speed;
            
        end else begin
            
            if(current < end_reg) begin
                
                if(current + speed_reg > end_reg)begin
                    current <= end_reg;
                end else begin
                    current <= current + speed_reg;
                end
                
            end
            
            if(current > end_reg) begin
                
                if(current - speed_reg < end_reg)begin
                    current <= end_reg;
                end else begin
                    current <= current - speed_reg;
                end
                
            end
            
        end
    
    end
    
    assign rdy = (current == end_reg);
    assign out_cmp = current;
    
endmodule
 