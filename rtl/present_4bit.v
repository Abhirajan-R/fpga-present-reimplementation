module present_4bit(
    input             clk,
    input             rst,
    input             start,
    input      [63:0] plaintext,
    input      [79:0] key,
    output reg        done,
    output reg [63:0] cipher
);
    reg [63:0] data_reg;
    reg [79:0] key_reg;
    reg [5:0]  round_cnt;
    reg [1:0]  state;

    wire [63:0] ark_out;
    assign ark_out = data_reg ^ key_reg[79:16];

    wire [3:0] s0,s1,s2,s3,s4,s5,s6,s7;
    wire [3:0] s8,s9,s10,s11,s12,s13,s14,s15;

    sbox u0 (.in(ark_out[63:60]),.out(s0));
    sbox u1 (.in(ark_out[59:56]),.out(s1));
    sbox u2 (.in(ark_out[55:52]),.out(s2));
    sbox u3 (.in(ark_out[51:48]),.out(s3));
    sbox u4 (.in(ark_out[47:44]),.out(s4));
    sbox u5 (.in(ark_out[43:40]),.out(s5));
    sbox u6 (.in(ark_out[39:36]),.out(s6));
    sbox u7 (.in(ark_out[35:32]),.out(s7));
    sbox u8 (.in(ark_out[31:28]),.out(s8));
    sbox u9 (.in(ark_out[27:24]),.out(s9));
    sbox u10(.in(ark_out[23:20]),.out(s10));
    sbox u11(.in(ark_out[19:16]),.out(s11));
    sbox u12(.in(ark_out[15:12]),.out(s12));
    sbox u13(.in(ark_out[11:8]), .out(s13));
    sbox u14(.in(ark_out[7:4]),  .out(s14));
    sbox u15(.in(ark_out[3:0]),  .out(s15));

    wire [63:0] sbox_out;
    assign sbox_out = {s0,s1,s2,s3,s4,s5,s6,s7,
                       s8,s9,s10,s11,s12,s13,s14,s15};

    wire [63:0] pbox_out;
    pbox u_pbox(.in(sbox_out),.out(pbox_out));

    wire [79:0] key_next;
    key_transform u_kt(
        .key_in(key_reg),
        .round(round_cnt[4:0]),
        .key_out(key_next)
    );

    localparam IDLE = 2'd0;
    localparam ENC  = 2'd1;
    localparam DONE = 2'd2;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state     <= IDLE;
            round_cnt <= 6'd0;
            done      <= 1'b0;
            data_reg  <= 64'd0;
            key_reg   <= 80'd0;
            cipher    <= 64'd0;
        end else begin
            case (state)
                IDLE: begin
                    done <= 1'b0;
                    if (start) begin
                        data_reg  <= plaintext;
                        key_reg   <= key;
                        round_cnt <= 6'd1;
                        state     <= ENC;
                    end
                end

                ENC: begin
                    if (round_cnt <= 6'd31) begin
                        $display("  [4bit] Round %0d : %h",
                            round_cnt, pbox_out);
                        data_reg  <= pbox_out;
                        key_reg   <= key_next;
                        round_cnt <= round_cnt + 1;
                    end else begin
                        cipher <= data_reg ^ key_reg[79:16];
                        state  <= DONE;
                    end
                end

                DONE: begin
                    done  <= 1'b1;
                    state <= IDLE;
                end
            endcase
        end
    end
endmodule