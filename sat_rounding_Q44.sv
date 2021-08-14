// test saturated rounding signed fixed point Q10.8(Q[INT_LENGTH].[DATA_WIDTH-INTLENGTH-1]) to Q3.4
module sat_rounding_Q44 (inp,res);
    parameter DATA_WIDTH = 19;
    parameter INT_LENGTH = 10;
    input signed [DATA_WIDTH-1:0] inp;
    output reg signed [7:0] res;
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

endmodule
