module tb_sv ();
    parameter DATA_WIDTH = 8;
    parameter S1_NUM = 4;
    localparam SF = 4;
    localparam MAC_OUT_WIDTH=DATA_WIDTH*2+S1_NUM-1;

    logic signed [DATA_WIDTH-1:0] inps[S1_NUM];
    logic signed [DATA_WIDTH-1:0] weights[S1_NUM];
    logic clk;
    logic signed [MAC_OUT_WIDTH-1:0] res;
    logic rdy;
    logic signed [DATA_WIDTH-1:0] inp;
    logic signed [DATA_WIDTH-1:0] weight;
    logic signed [DATA_WIDTH-1:0] sig_out;
    logic reset;
    MAC_unit #(
        .DATA_WIDTH(DATA_WIDTH),
        .S1_NUM(S1_NUM)
    )
    MAC_mod
    (
        .inp(inp),
        .weight(weight),
        .clk(clk),
        .reset(reset),
        .enable(1'b1),
        .mac_out(res),
        .rdy(rdy)
    );
    Sigmoid_unit #(
        .DATA_WIDTH(DATA_WIDTH)
    )
    sigmoid_mod
    (
        .inp(res),
        .out(sig_out)
    );
    always begin
        clk=1'b0;#5;
        clk=1'b1;#5;
    end
    int i;
    always@(posedge clk) begin
            inp<=inps[i];
            weight<=weights[i];
            i=i+1;
    end
    initial begin
        weights={8'd1,8'd2,8'd3,8'd4};
        inps={8'd1,8'd2,8'd3,8'd4};
        i=0;
        reset=1'b1;
        #10;
        reset=1'b0;
    end
endmodule
