module Multiplier #(
    parameter DATA_WIDTH = 8,
    parameter LENGTH = 8

)
(
    input [DATA_WIDTH-1:0] inp,
    input [DATA_WIDTH-1:0] weight,
    output [DATA_WIDTH*2-1:0] out
);
    assign out=inp*weight;
endmodule
