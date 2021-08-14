module Stage2 (inp,weights,clk,reset,enable,out_vector);
    parameter S1_NUM = 8;
    parameter S2_NUM = 8;
    parameter DATA_WIDTH = 8;
    localparam MAC_OUT_WIDTH = DATA_WIDTH*2+S1_NUM-1;
    input signed [DATA_WIDTH-1:0] inp;
    input signed [DATA_WIDTH-1:0] weights[S2_NUM];
    input clk;
    input reset;
    input enable;
    output signed [DATA_WIDTH-1:0] out_vector[S2_NUM];

    logic mac_rdy[S2_NUM];
    logic signed [MAC_OUT_WIDTH-1:0] mac_out[S2_NUM];
    logic signed [DATA_WIDTH-1:0] rounding_out[S2_NUM];
    genvar i;
    generate
        for(i=0;i<S2_NUM;i++) begin
            MAC_unit #(
                .DATA_WIDTH(DATA_WIDTH),
                .S1_NUM(S1_NUM)
            )
            MAC_mod
            (
                .inp(inp),
                .weight(weights[i]),
                .clk(clk),
                .reset(reset),
                .enable(enable),
                .mac_out(mac_out[i]),
                .rdy(mac_rdy[i])
            );    
            sat_rounding_Q44 #(
                .DATA_WIDTH(MAC_OUT_WIDTH),
                .INT_LENGTH(MAC_OUT_WIDTH-8+1)
            )
            rounding_mod
            (
                .inp(mac_out[i]),
                .res(rounding_out[i])
            );

            Sigmoid_unit #(
                .DATA_WIDTH(DATA_WIDTH)
            )
            Sigmoid_mod
            (
                .inp(rounding_out[i]),
                .out(out_vector[i])
            );
        end
    endgenerate
endmodule