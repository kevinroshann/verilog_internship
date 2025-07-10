module gray_fifo_tb;

    reg clk_wr = 0, clk_rd = 0, rst = 1;
    reg wr_en = 0, rd_en = 0;
    reg [7:0] din = 0;
    wire [7:0] dout;
    wire full, empty;

    gray_fifo dut (
        .wr_clk(clk_wr),
        .rd_clk(clk_rd),
        .rst(rst),
        .wr_en(wr_en),
        .rd_en(rd_en),
        .din(din),
        .dout(dout),
        .full(full),
        .empty(empty)
    );

    // Write and read clocks
    always #5 clk_wr = ~clk_wr;
    always #7 clk_rd = ~clk_rd;

    initial begin
        $dumpfile("gray_fifo_tb.vcd");
        $dumpvars(0, gray_fifo_tb);

        #10 rst = 0;

        // Write 10 values
        repeat(10) begin
            @(posedge clk_wr);
            if (!full) begin
                wr_en <= 1;
                din <= din + 1;
            end
        end
        wr_en <= 0;

        // Delay before reading
        #50;

        // Read 10 values
        repeat(10) begin
            @(posedge clk_rd);
            if (!empty)
                rd_en <= 1;
        end
        rd_en <= 0;

        #50 $finish;
    end

endmodule
