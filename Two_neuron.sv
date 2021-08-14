module Two_neuron (clk,reset,enable,wgt1,wgt2,inp,out_vector);
    parameter S0_NUM = 8;
    parameter S1_NUM = 8;
    parameter S2_NUM = 8;
    parameter DATA_WIDTH = 8;

    input clk;
    input reset;
    input enable;
    input signed [DATA_WIDTH-1:0] wgt1[S0_NUM];
    input signed [DATA_WIDTH-1:0] wgt2[S2_NUM];
    input signed [DATA_WIDTH-1:0] inp[S0_NUM];
    output signed [DATA_WIDTH-1:0] out_vector[S2_NUM];

    logic signed [DATA_WIDTH-1:0] s1_out;
    
    Stage1 #(
        .DATA_WIDTH(DATA_WIDTH),
        .LENGTH(S0_NUM)
    )
    S1_mod
    (
        .inp(inp),
        .wgt(wgt1),
        .clk(clk),
        .reset(reset),
        .out(s1_out)
    );

    Stage2 #(
        .S1_NUM(S1_NUM),
        .S2_NUM(S2_NUM),
        .DATA_WIDTH(DATA_WIDTH)
    )
    S2_mod
    (
        .inp(s1_out),
        .weights(wgt2),
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .out_vector(out_vector)
    );

endmodule
