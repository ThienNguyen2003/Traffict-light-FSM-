module traffic_light (
    input wire clk,
    input wire reset,          // active-low reset
    output reg [2:0] north_light,
    output reg [2:0] south_light,
    output reg [2:0] east_light,
    output reg [2:0] west_light
);
reg[1:0] state;
       parameter [1:0] S0 = 2'b00;  // North and South green, East and West red
    parameter [1:0] S1 = 2'b01;  // North and South yellow, East and West red
    parameter [1:0] S2 = 2'b10;  // North and South red, East and West green
    parameter [1:0] S3 = 2'b11;  // North and South red, East and West yellow

    reg [5:0] timer;

    always @(posedge clk) begin
        if (reset==1'b0) begin
            state <= S0;
            timer <= 0;
        end else begin
            // timer count
            if ((state==S0 || state==S2) && timer==30) begin
                state <= state + 1;
                timer <= 0;
            end else if ((state==S1 || state==S3) && timer==5) begin
                state <= (state==S3) ? S0 : state + 1;
                timer <= 0;
            end else begin
                timer <= timer + 1;
            end
        end
    end

    // Output logic
    always @(*) begin
        case(state)
            S0: begin // NS xanh
                north_light = 3'b100; south_light = 3'b100;
                east_light  = 3'b001; west_light  = 3'b001;
            end
            S1: begin // NS vàng
                north_light = 3'b010; south_light = 3'b010;
                east_light  = 3'b001; west_light  = 3'b001;
            end
            S2: begin // EW xanh
                north_light = 3'b001; south_light = 3'b001;
                east_light  = 3'b100; west_light  = 3'b100;
            end
            S3: begin // EW vàng
                north_light = 3'b001; south_light = 3'b001;
                east_light  = 3'b010; west_light  = 3'b010;
            end
            default: begin
                north_light = 3'b001; south_light = 3'b001;
                east_light  = 3'b001; west_light  = 3'b001;
            end
        endcase
    end
endmodule





