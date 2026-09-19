module present_kd(
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

    wire [3:0] sel;
    assign sel = key_reg[79:76] ^ key_reg[75:72] ^
                 key_reg[71:68] ^ key_reg[67:64];

    wire [63:0] ark_out;
    assign ark_out = data_reg ^ key_reg[79:16];

    wire [3:0] kd0,kd1,kd2,kd3,kd4,kd5,kd6,kd7;
    wire [3:0] kd8,kd9,kd10,kd11,kd12,kd13,kd14,kd15;

    kd_sbox k0 (.in(ark_out[63:60]),.sel(sel),.out(kd0));
    kd_sbox k1 (.in(ark_out[59:56]),.sel(sel),.out(kd1));
    kd_sbox k2 (.in(ark_out[55:52]),.sel(sel),.out(kd2));
    kd_sbox k3 (.in(ark_out[51:48]),.sel(sel),.out(kd3));
    kd_sbox k4 (.in(ark_out[47:44]),.sel(sel),.out(kd4));
    kd_sbox k5 (.in(ark_out[43:40]),.sel(sel),.out(kd5));
    kd_sbox k6 (.in(ark_out[39:36]),.sel(sel),.out(kd6));
    kd_sbox k7 (.in(ark_out[35:32]),.sel(sel),.out(kd7));
    kd_sbox k8 (.in(ark_out[31:28]),.sel(sel),.out(kd8));
    kd_sbox k9 (.in(ark_out[27:24]),.sel(sel),.out(kd9));
    kd_sbox k10(.in(ark_out[23:20]),.sel(sel),.out(kd10));
    kd_sbox k11(.in(ark_out[19:16]),.sel(sel),.out(kd11));
    kd_sbox k12(.in(ark_out[15:12]),.sel(sel),.out(kd12));
    kd_sbox k13(.in(ark_out[11:8]), .sel(sel),.out(kd13));
    kd_sbox k14(.in(ark_out[7:4]),  .sel(sel),.out(kd14));
    kd_sbox k15(.in(ark_out[3:0]),  .sel(sel),.out(kd15));

    wire [63:0] sbox_out;
    assign sbox_out = {kd0,kd1,kd2,kd3,kd4,kd5,kd6,kd7,
                       kd8,kd9,kd10,kd11,kd12,kd13,kd14,kd15};

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
                        $display("  [KD]   Round %0d : %h  (S-box sel=%0d)",
                            round_cnt, pbox_out, sel);
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