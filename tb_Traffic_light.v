`timescale 1ns/1ps
module tb_traffic_light;
    
    reg clk;
    reg reset;
    wire [2:0] north_light, south_light, east_light, west_light;

    traffic_light uut (
        .clk(clk),
        .reset(reset),
        .north_light(north_light),
        .south_light(south_light),
        .east_light(east_light),
        .west_light(west_light)
    );

    initial begin
        clk = 0;
        forever #1 clk = ~clk; 
    end

    
    initial begin
        
        reset = 0;  
        #10;      

        
        reset = 1;
        #200;    

        
        $finish;
    end

    initial begin
        $monitor("Time=%0t | Reset=%b | State=%b | North=%b | South=%b | East=%b | West=%b",
                 $time, reset, uut.state, north_light, south_light, east_light, west_light);
    end

endmodule
