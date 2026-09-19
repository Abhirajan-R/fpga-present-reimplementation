module key_transform(
    input  [79:0] key_in,
    input  [4:0]  round,
    output reg [79:0] key_out
);
    wire [79:0] rotated;
    wire [3:0]  sbox_out;

    assign rotated = {key_in[18:0], key_in[79:19]};

    sbox u_sbox(.in(rotated[79:76]), .out(sbox_out));

    always @(*) begin
        key_out        = rotated;
        key_out[79:76] = sbox_out;
        key_out[19:15] = rotated[19:15] ^ round;
    end
endmodule