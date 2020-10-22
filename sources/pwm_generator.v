`timescale 1ns / 1ps

module pwm_generator #(
    parameter CNTR_BITS = 16
)(
    input clk,  // órajel
    input en,   // enable
    input rst,  // reset
    input [CNTR_BITS - 1:0] cmp,
    input [CNTR_BITS - 1:0] period, 
    output pwm_out
);

reg [CNTR_BITS-1 : 0] cnt;
reg out;

always@ (posedge clk) begin

if(rst) begin

    cnt <= 0;
    
end else begin    
       
    if(en) begin
        
        if(cnt == period) begin
            
            cnt <= 0;
            
        end else begin
          
            cnt <= cnt + 1;
            
        end
    
    end

end

end



always@ (posedge clk) begin

if(rst) begin

    out <= 0;
    
end else begin

    if(en) begin
       
        if(cmp[CNTR_BITS - 1:0] > cnt[CNTR_BITS - 1:0]) begin
        
            out <= 1;
        
        end else begin
        
            out <= 0;
        
        end
    
    end
    
end

end

assign pwm_out = out & en;

endmodule
