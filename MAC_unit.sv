module MAC_unit(inp,weight,clk,reset,enable,mac_out,rdy);
    parameter DATA_WIDTH = 8;
    parameter S1_NUM = 8;
    localparam MAC_OUT_WIDTH=DATA_WIDTH*2+S1_NUM-1;

    input signed [DATA_WIDTH-1:0] inp;
    input signed [DATA_WIDTH-1:0] weight;
    input clk;
    input reset;
    input enable;
    output reg signed [MAC_OUT_WIDTH-1:0] mac_out;
    output reg rdy;

    logic signed [MAC_OUT_WIDTH-1:0] sum;
    integer sum_num;
    always@(posedge clk ) begin
        if(reset==1) begin
            sum<=0;
            sum_num<=0;
            mac_out<=0;
            rdy<=1'b0;
        end else if(sum_num==S1_NUM) begin
            sum<=inp*weight;
            sum_num<=1;
            mac_out<=sum;
            rdy<=1'b1;
        end else if(enable==1) begin
            sum<=sum+inp*weight;
            sum_num<=sum_num+1;
            rdy<=1'b0;
        end
    end
endmodule
