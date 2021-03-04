`timescale 1ns / 1ps

module servo_speed_control #(
    parameter CNTR_BITS = 16 
)(
    input [CNTR_BITS - 1:0] start_pos,
    input [CNTR_BITS - 1:0] end_pos,
    input [CNTR_BITS - 1:0] prescale,
    input go,
    input clk,
    
    output rdy,
    output [CNTR_BITS - 1:0] out_cmp
);
    
    reg [CNTR_BITS - 1:0] current;          // kimenethez tartozo regiszter
    reg [CNTR_BITS - 1:0] end_reg;          // végállapotot tartalmazó regiszter
    reg [CNTR_BITS - 1:0] prescale_reg;     // prescale érték regiszter
    reg [CNTR_BITS - 1:0] cntr;             // sebességszabályzáshoz órajlosztó regiszter
    
    always@ (posedge clk) begin
            
        if(go) begin                        // go jelre beolvassuk a bemenetet
            
            current <= start_pos;
            end_reg <= end_pos;
            prescale_reg <= prescale;
            cntr <= 0;
            
        end else begin
            
            if(current < end_reg) begin     // ha a jelenlegi kimenet kisebb a célnál
                
                if(cntr < prescale_reg) begin   // órajelet prescalelünk
                    cntr <= cntr + 1;
                end
                
                if(cntr == prescale_reg) begin  // és osztott órajelre növeljük a kimenetet
                    cntr <= 0;
                    current = current + 1;
                end
                                
            end
            
        end
    
    end
    
    assign rdy = (current == end_reg);          // folyamatot befejeztük
    assign out_cmp = current;
    
endmodule
 