module kd_sbox(
    input  [3:0] in,
    input  [3:0] sel,
    output reg [3:0] out
);
    always @(*) begin
        case (sel)
            4'd0:  case(in) 4'h0:out=4'd3;  4'h1:out=4'd8;  4'h2:out=4'd15; 4'h3:out=4'd1;
                             4'h4:out=4'd10; 4'h5:out=4'd6;  4'h6:out=4'd5;  4'h7:out=4'd11;
                             4'h8:out=4'd14; 4'h9:out=4'd13; 4'hA:out=4'd4;  4'hB:out=4'd2;
                             4'hC:out=4'd7;  4'hD:out=4'd0;  4'hE:out=4'd9;  default:out=4'd12; endcase
            4'd1:  case(in) 4'h0:out=4'd15; 4'h1:out=4'd12; 4'h2:out=4'd2;  4'h3:out=4'd7;
                             4'h4:out=4'd9;  4'h5:out=4'd0;  4'h6:out=4'd5;  4'h7:out=4'd10;
                             4'h8:out=4'd1;  4'h9:out=4'd11; 4'hA:out=4'd14; 4'hB:out=4'd8;
                             4'hC:out=4'd6;  4'hD:out=4'd13; 4'hE:out=4'd3;  default:out=4'd4;  endcase
            4'd2:  case(in) 4'h0:out=4'd8;  4'h1:out=4'd6;  4'h2:out=4'd7;  4'h3:out=4'd9;
                             4'h4:out=4'd3;  4'h5:out=4'd12; 4'h6:out=4'd10; 4'h7:out=4'd15;
                             4'h8:out=4'd13; 4'h9:out=4'd1;  4'hA:out=4'd14; 4'hB:out=4'd4;
                             4'hC:out=4'd0;  4'hD:out=4'd11; 4'hE:out=4'd5;  default:out=4'd2;  endcase
            4'd3:  case(in) 4'h0:out=4'd0;  4'h1:out=4'd15; 4'h2:out=4'd11; 4'h3:out=4'd8;
                             4'h4:out=4'd12; 4'h5:out=4'd9;  4'h6:out=4'd6;  4'h7:out=4'd3;
                             4'h8:out=4'd13; 4'h9:out=4'd1;  4'hA:out=4'd2;  4'hB:out=4'd4;
                             4'hC:out=4'd10; 4'hD:out=4'd7;  4'hE:out=4'd5;  default:out=4'd14; endcase
            4'd4:  case(in) 4'h0:out=4'd1;  4'h1:out=4'd15; 4'h2:out=4'd8;  4'h3:out=4'd3;
                             4'h4:out=4'd12; 4'h5:out=4'd0;  4'h6:out=4'd11; 4'h7:out=4'd6;
                             4'h8:out=4'd2;  4'h9:out=4'd5;  4'hA:out=4'd4;  4'hB:out=4'd10;
                             4'hC:out=4'd9;  4'hD:out=4'd14; 4'hE:out=4'd7;  default:out=4'd13; endcase
            4'd5:  case(in) 4'h0:out=4'd15; 4'h1:out=4'd5;  4'h2:out=4'd2;  4'h3:out=4'd11;
                             4'h4:out=4'd4;  4'h5:out=4'd10; 4'h6:out=4'd9;  4'h7:out=4'd12;
                             4'h8:out=4'd0;  4'h9:out=4'd3;  4'hA:out=4'd14; 4'hB:out=4'd8;
                             4'hC:out=4'd13; 4'hD:out=4'd6;  4'hE:out=4'd7;  default:out=4'd1;  endcase
            4'd6:  case(in) 4'h0:out=4'd7;  4'h1:out=4'd2;  4'h2:out=4'd12; 4'h3:out=4'd5;
                             4'h4:out=4'd8;  4'h5:out=4'd4;  4'h6:out=4'd6;  4'h7:out=4'd11;
                             4'h8:out=4'd14; 4'h9:out=4'd9;  4'hA:out=4'd1;  4'hB:out=4'd15;
                             4'hC:out=4'd13; 4'hD:out=4'd3;  4'hE:out=4'd10; default:out=4'd0;  endcase
            4'd7:  case(in) 4'h0:out=4'd1;  4'h1:out=4'd13; 4'h2:out=4'd15; 4'h3:out=4'd0;
                             4'h4:out=4'd14; 4'h5:out=4'd8;  4'h6:out=4'd2;  4'h7:out=4'd11;
                             4'h8:out=4'd7;  4'h9:out=4'd4;  4'hA:out=4'd12; 4'hB:out=4'd10;
                             4'hC:out=4'd9;  4'hD:out=4'd3;  4'hE:out=4'd5;  default:out=4'd6;  endcase
            4'd8:  case(in) 4'h0:out=4'd0;  4'h1:out=4'd3;  4'h2:out=4'd5;  4'h3:out=4'd8;
                             4'h4:out=4'd6;  4'h5:out=4'd9;  4'h6:out=4'd12; 4'h7:out=4'd7;
                             4'h8:out=4'd13; 4'h9:out=4'd10; 4'hA:out=4'd14; 4'hB:out=4'd4;
                             4'hC:out=4'd1;  4'hD:out=4'd15; 4'hE:out=4'd11; default:out=4'd2;  endcase
            4'd9:  case(in) 4'h0:out=4'd0;  4'h1:out=4'd3;  4'h2:out=4'd5;  4'h3:out=4'd8;
                             4'h4:out=4'd6;  4'h5:out=4'd12; 4'h6:out=4'd11; 4'h7:out=4'd7;
                             4'h8:out=4'd9;  4'h9:out=4'd14; 4'hA:out=4'd10; 4'hB:out=4'd13;
                             4'hC:out=4'd15; 4'hD:out=4'd2;  4'hE:out=4'd1;  default:out=4'd4;  endcase
            4'd10: case(in) 4'h0:out=4'd0;  4'h1:out=4'd3;  4'h2:out=4'd5;  4'h3:out=4'd8;
                             4'h4:out=4'd6;  4'h5:out=4'd10; 4'h6:out=4'd15; 4'h7:out=4'd4;
                             4'h8:out=4'd14; 4'h9:out=4'd13; 4'hA:out=4'd9;  4'hB:out=4'd2;
                             4'hC:out=4'd1;  4'hD:out=4'd7;  4'hE:out=4'd12; default:out=4'd11; endcase
            4'd11: case(in) 4'h0:out=4'd0;  4'h1:out=4'd3;  4'h2:out=4'd5;  4'h3:out=4'd8;
                             4'h4:out=4'd6;  4'h5:out=4'd12; 4'h6:out=4'd11; 4'h7:out=4'd7;
                             4'h8:out=4'd10; 4'h9:out=4'd4;  4'hA:out=4'd9;  4'hB:out=4'd14;
                             4'hC:out=4'd15; 4'hD:out=4'd1;  4'hE:out=4'd2;  default:out=4'd13; endcase
            4'd12: case(in) 4'h0:out=4'd7;  4'h1:out=4'd12; 4'h2:out=4'd14; 4'h3:out=4'd9;
                             4'h4:out=4'd2;  4'h5:out=4'd1;  4'h6:out=4'd5;  4'h7:out=4'd15;
                             4'h8:out=4'd11; 4'h9:out=4'd6;  4'hA:out=4'd13; 4'hB:out=4'd0;
                             4'hC:out=4'd4;  4'hD:out=4'd8;  4'hE:out=4'd3;  default:out=4'd10; endcase
            4'd13: case(in) 4'h0:out=4'd4;  4'h1:out=4'd10; 4'h2:out=4'd1;  4'h3:out=4'd6;
                             4'h4:out=4'd8;  4'h5:out=4'd15; 4'h6:out=4'd7;  4'h7:out=4'd12;
                             4'h8:out=4'd3;  4'h9:out=4'd0;  4'hA:out=4'd14; 4'hB:out=4'd13;
                             4'hC:out=4'd5;  4'hD:out=4'd9;  4'hE:out=4'd11; default:out=4'd2;  endcase
            4'd14: case(in) 4'h0:out=4'd2;  4'h1:out=4'd15; 4'h2:out=4'd12; 4'h3:out=4'd1;
                             4'h4:out=4'd5;  4'h5:out=4'd6;  4'h6:out=4'd10; 4'h7:out=4'd13;
                             4'h8:out=4'd14; 4'h9:out=4'd8;  4'hA:out=4'd3;  4'hB:out=4'd4;
                             4'hC:out=4'd0;  4'hD:out=4'd11; 4'hE:out=4'd9;  default:out=4'd7;  endcase
            default: case(in) 4'h0:out=4'd15; 4'h1:out=4'd4;  4'h2:out=4'd5;  4'h3:out=4'd8;
                               4'h4:out=4'd9;  4'h5:out=4'd7;  4'h6:out=4'd2;  4'h7:out=4'd1;
                               4'h8:out=4'd10; 4'h9:out=4'd3;  4'hA:out=4'd0;  4'hB:out=4'd14;
                               4'hC:out=4'd6;  4'hD:out=4'd12; 4'hE:out=4'd13; default:out=4'd11; endcase
        endcase
    end
endmodule