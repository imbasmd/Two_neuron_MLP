// first layer's neuron, all weights and input vectors are 8-bits width(signed Q3.4)
module Stage1 (clk,reset,wgt,inp,out);
    parameter DATA_WIDTH = 8;
    parameter LENGTH = 8;
    localparam MULOUT_DATA_WIDTH = 2*DATA_WIDTH;
    localparam ADTREE_DATA_WIDTH = MULOUT_DATA_WIDTH + $clog2(LENGTH);
    input clk;
    input reset;
    input signed [DATA_WIDTH-1:0] wgt[LENGTH];
    input signed [DATA_WIDTH-1:0] inp[LENGTH];
    output signed [DATA_WIDTH-1:0] out;

    logic signed [MULOUT_DATA_WIDTH-1:0] mul_out[LENGTH];
    logic signed [ADTREE_DATA_WIDTH-1:0] adtree_out;
    logic signed [DATA_WIDTH-1:0] rounding_out;


    genvar i;
    generate
        for(i=0;i<LENGTH;i++) begin
            Multiplier #(
                .DATA_WIDTH(DATA_WIDTH)
            )
            Mul_mod
            (
                .inp(inp[i]),
                .weight(wgt[i]),
                .out(mul_out[i])
            );
        end
    endgenerate

    Addertree #(
        .DATA_WIDTH(MULOUT_DATA_WIDTH),
        .LENGTH(LENGTH)
    )
    Adtree_mod
    (
        .in_addends(mul_out),
        .out_sum(adtree_out)
    );

    // saturated rounding to Q4.4
    sat_rounding_Q44 #(
        .DATA_WIDTH(ADTREE_DATA_WIDTH),
        .INT_LENGTH(ADTREE_DATA_WIDTH-8+1)
    )
    rounding_mod
    (
        .inp(adtree_out),
        .res(rounding_out)
    );

    Sigmoid_unit #(
        .DATA_WIDTH(DATA_WIDTH)
    )
    Sigmoid_mod
    (
        .inp(rounding_out),
        .out(out)
    );
    
endmodule
