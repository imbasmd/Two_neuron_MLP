module tb_sigmoid (
);
    localparam DATA_WIDTH=8;
    localparam SF=2**4;
    logic signed [DATA_WIDTH-1:0] inps[10] = '{1,2,3,4,5,6,-1,-2,-5,-4};
    logic signed [DATA_WIDTH-1:0] inp;
    logic signed [2*DATA_WIDTH-1:0] out;
    Sigmoid_unit #(
        .DATA_WIDTH(DATA_WIDTH)
    )
    sigmoid_mod
    (
        .inp(inp),
        .out(out)
    );
    logic clk;
    always begin
	clk = 0; #5;
	clk = 1; #5;
    end
    integer cursor;

    int i;
    always @(posedge clk) begin
        inp<=inps[i]*SF;
        i=i+1;
        $display("input=%b,output=%f",inp,out*2.0**-8.0);
    end

    initial begin
        $display("Testing sigmoid");
        i=0;

    end
    
endmodule
