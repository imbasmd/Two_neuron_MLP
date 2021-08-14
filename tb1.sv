module tb1  (
);
    parameter DATA_WIDTH = 8;
    parameter LENGTH = 4;

    logic signed [DATA_WIDTH-1:0] addends[LENGTH];
    logic signed [DATA_WIDTH-1:0] res;

    Addertree #(
        .DATA_WIDTH(DATA_WIDTH),
        .LENGTH(LENGTH)
    )
    adtree
    (

        .in_addends(addends),
        .out_sum(res)
    );
int truevalue;
initial begin
    $display("Testing AdderTree");
    addends = '{1,-2,3,-4};
    foreach(addends[i]) begin
        truevalue = truevalue+addends[i];
    end
    #10
    if (res!=truevalue) begin
        $display("fail,truevalue=%b,res=%b",truevalue,res);
    end
    else begin
        $display("success,truevalue=%b,res=%b",truevalue,res);
    end
end

endmodule
