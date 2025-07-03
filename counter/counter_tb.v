module counter_tb;

    wire [7:0] tout;
    reg tload,tclk,trst,tenb,tmode,tload_data;

    // Instantiate the DUT
    counter DUT (
        .out(tout),
        .load(tload),
        .clk(tclk),
        .rst(trst),
        .enb(tenb),
        .mode(tmode),
        .load_data(tload_data)
    );

    // Clock generation
    always begin
        #5 tclk = ~tclk;
    end


    initial begin

        $dumpfile("dump.vcd");       // Name of the VCD file
        $dumpvars(0, counter_tb);    // Dump all variables in this module

        // Initialize signals
        tclk = 0;
        trst = 0;
        tenb = 0;
        tload = 0;
        tmode=0;
        tload_data=0;

        // Apply reset
        #10 trst = 1;
        #10 trst = 0;

        // Enable counting
        #10 tenb = 1;
// Load 8'b10101010 into counter
tload = 1; tload_data = 8'b10101010;
#10 tload = 0;

// Count up
tmode = 1; tenb = 1;
#50

// Count down
tmode = 0;
#50

        // Run simulation
        #100 $finish;
    end

endmodule
