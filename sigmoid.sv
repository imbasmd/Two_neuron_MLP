// piecewise linear implementation
// f(x)=1-0.5(x/4-1)**2 (0<=x<=4)
//     =1               (x>4)
//     =1-f(-x)         (-4<=x<0)  
//     =0               (x<-4)
module Sigmoid_unit #(
    parameter DATA_WIDTH = 8
) (
    input signed [DATA_WIDTH-1:0] inp,
    output signed [DATA_WIDTH-1:0] out
);
    localparam SF = 2**((DATA_WIDTH+1)/2);
    logic signed [DATA_WIDTH-1:0] y,z,sum;
    logic signed [2*DATA_WIDTH-1:0] sq,sh,sr;

    always@(*)
    begin
    if(inp[DATA_WIDTH-1]==1'b1)
        y=-inp;
    else
        y=inp;
    z=y>>>2 ;
        
    sum= z+(-1*SF);
        
    sq=sum*sum;

    sh=sq>>>1;

    if(inp[DATA_WIDTH-1]==1'b1)
        if(y>=4*SF)
            sr=0;
        else
            sr=sh;
    else
        if(y>=4*SF)
            sr=1*SF*SF;
        else
            sr=1*SF*SF-sh;
    end

    assign out={sr[15],sr[10:4]};

    
endmodule
