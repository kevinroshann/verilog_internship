module pattern_detector (
    input wire clk,
    input wire rst,
    input wire data_in,
    output reg detected
);

    // State encoding
    parameter S0 = 2'b00,
              S1 = 2'b01,
              S2 = 2'b10,
              S3 = 2'b11;

    reg [1:0] state;
    reg [1:0] next_state;

    // State register
    always @(posedge clk or posedge rst) begin
        if (rst)
            state <= S0;
        else
            state <= next_state;
    end

    // Next-state logic and output
    always @(*) begin
        next_state = state;
        detected = 0;

        case (state)
            S0: begin
                if (data_in)
                    next_state = S1;
                else
                    next_state = S0;
            end

            S1: begin
                if (data_in)
                    next_state = S2;
                else
                    next_state = S0;
            end

            S2: begin
                if (data_in)
                    next_state = S2;
                else
                    next_state = S3;
            end

            S3: begin
                detected = 1;
                if (data_in)
                    next_state = S1;
                else
                    next_state = S0;
            end

            default: begin
                next_state = S0;
                detected = 0;
            end
        endcase
    end

endmodule
