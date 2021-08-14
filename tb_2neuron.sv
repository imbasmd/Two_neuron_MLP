`include "SV_RAND_CHECK.sv"
module tb_2neuron ();
    parameter S0_NUM = 8;
    parameter S1_NUM = 8;
    parameter S2_NUM = 8;
    parameter DATA_WIDTH = 8;

    logic clk;
    logic reset;
    logic enable;
    logic signed [DATA_WIDTH-1:0] wgt1[S0_NUM];
    logic signed [DATA_WIDTH-1:0] wgt2[S2_NUM];
    logic signed [DATA_WIDTH-1:0] inp[S0_NUM];
    logic signed [DATA_WIDTH-1:0] out_vector[S2_NUM];

    class randinp;
        randc logic signed [DATA_WIDTH-1:0] w1[S0_NUM];
        randc logic signed [DATA_WIDTH-1:0] w2[S2_NUM];
        randc logic signed [DATA_WIDTH-1:0] ip[S0_NUM];
        function new();
        endfunction //new()
    endclass //randinp
    always begin
        clk=1'b0;#5;
        clk=1'b1;#5;
    end

    Two_neuron #(
        .S0_NUM(S0_NUM),
        .S1_NUM(S1_NUM),
        .S2_NUM(S2_NUM),
        .DATA_WIDTH(DATA_WIDTH)
    )
    test_mod
    (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .wgt1(wgt1),
        .wgt2(wgt2),
        .inp(inp),
        .out_vector(out_vector)
    );

    initial begin
        randinp e;
        e=new();
        `SV_RAND_CHECK(e.randomize());
        reset=1'b1;
        enable=1'b1;
        #10;
        reset=1'b0;
        wgt1=e.w1;
        wgt2=e.w2;
        inp=e.ip;
    end
endmodule
