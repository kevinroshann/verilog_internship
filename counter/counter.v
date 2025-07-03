module counter(
    output reg [7:0] out,
    input load,clk,rst,enb,mode,load_data
);
    always @(posedge clk) 
    begin
        if(rst)
            out=8'b0;
        else if (enb)
        begin
            if(load)
                out<=load_data;
            else if(mode)
                out<=out+1;
            else if (~mode)
                out<=out-1;
        end
    end

endmodule
