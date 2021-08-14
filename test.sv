// test saturated rounding signed fixed point Q10.8(Q[INT_LENGTH].[DATA_WIDTH-INTLENGTH-1]) to Q3.4
module test_rounding (
);
    parameter DATA_WIDTH = 19;
    parameter INT_LENGTH = 10;
    logic signed [DATA_WIDTH-1:0] inp;
    logic signed [7:0] res;
// fraction part just keep the most significant bits
// integer part needs to do satruation
// if all truncated bits are same to the signed bit, no satruation is 
// needed, otherwise needs satruation. 
    always_comb begin
        res[7] = inp[DATA_WIDTH-1];
        res[3:0] = inp[DATA_WIDTH-INT_LENGTH-2:DATA_WIDTH-INT_LENGTH-5];
        if((inp[DATA_WIDTH-1]==0&&(~|inp[DATA_WIDTH-2:DATA_WIDTH-INT_LENGTH+2]))||
        (inp[DATA_WIDTH-1]==1&&(&inp[DATA_WIDTH-2:DATA_WIDTH-INT_LENGTH+2]))) begin
            res[6:4] = inp[DATA_WIDTH-INT_LENGTH+1:DATA_WIDTH-INT_LENGTH-1];
        end
        else begin
            res[6:4] = {3{~inp[DATA_WIDTH-1]}};
        end

    end

    initial begin
        inp = 0;
        #10;
        inp = 19'b000_0000_0111_1100_0011;
        #10;
        inp = 19'b000_0000_1111_1100_0011;
        #10;
        inp = 19'b111_1111_1010_1100_0011;
        #10;
        inp = 19'b100_0000_0001_1101_0111;
        #10;
        inp = 19'b111_1100_0000_1100_0011;
    end
endmodule