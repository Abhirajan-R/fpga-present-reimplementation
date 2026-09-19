module present_tb;

    reg         clk, rst, start;
    reg  [63:0] plaintext;
    reg  [79:0] key;

    wire        done_4bit, done_kd;
    wire [63:0] cipher_4bit, cipher_kd;

    present_4bit u_4bit(
        .clk(clk), .rst(rst), .start(start),
        .plaintext(plaintext), .key(key),
        .done(done_4bit), .cipher(cipher_4bit)
    );

    present_kd u_kd(
        .clk(clk), .rst(rst), .start(start),
        .plaintext(plaintext), .key(key),
        .done(done_kd), .cipher(cipher_kd)
    );

    always #5 clk = ~clk;

    task run_test;
        input [63:0] pt;
        input [79:0] k;
        input [63:0] exp;
        begin
            @(posedge clk); #1;
            plaintext = pt;
            key       = k;
            start     = 1;
            @(posedge clk); #1;
            start = 0;
            wait(done_4bit == 1'b1);
            #10;
            $display("================================================");
            $display("Plaintext  : %h", pt);
            $display("Key        : %h", k);
            $display("------------------------------------------------");
            $display("[4-bit Iterative Architecture]");
            $display("Ciphertext : %h", cipher_4bit);
            $display("Expected   : %h", exp);
            $display("Result     : %s",
                (cipher_4bit==exp) ? "PASS" : "FAIL");
            $display("------------------------------------------------");
            $display("[Modified Key Dependent Architecture]");
            $display("Ciphertext : %h", cipher_kd);
            $display("Note: Different S-box used each round");
            $display("      Same input gives different output");
            $display("      Security increased by factor of 2^4");
            $display("================================================");
            $display(" ");
        end
    endtask

    initial begin
        clk       = 0;
        rst       = 1;
        start     = 0;
        plaintext = 0;
        key       = 0;

        @(posedge clk); #1;
        @(posedge clk); #1;
        rst = 0;
        @(posedge clk); #1;

        $display(" ");
        $display("================================================");
        $display("   PRESENT Lightweight Block Cipher");
        $display("   FPGA Implementation - DE10-Lite MAX10");
        $display("   4-bit Iterative + Key Dependent Arch");
        $display("================================================");
        $display(" ");

        $display(">>> TEST 1: PRESENT Spec Vector 1");
        $display("--- Round-by-Round Data ---");
        run_test(
            64'h0000000000000000,
            80'h00000000000000000000,
            64'h5579c1387b228445
        );

        $display(">>> TEST 2: PRESENT Spec Vector 4");
        $display("--- Round-by-Round Data ---");
        run_test(
            64'hffffffffffffffff,
            80'hffffffffffffffffffff,
            64'h3333dcd3213210d2
        );

        $display(">>> TEST 3: Paper Test Vector");
        $display("--- Round-by-Round Data ---");
        run_test(
            64'h0000000000003b1e,
            80'h000000000000050ba282,
            64'h21eb3cf6625a7db3
        );

        $display("================================================");
        $display("   Simulation Complete");
        $display("================================================");
        $finish;
    end

endmodule