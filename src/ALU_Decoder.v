
module ALU_Decoder(ALUOp,funct3,funct7,op,ALUControl);

    input [1:0]ALUOp;
    input [2:0]funct3;
    input [6:0]funct7,op;
    output [2:0]ALUControl;

    // Method 1 
    // assign ALUControl = (ALUOp == 2'b00) ? 3'b000 :
    //                     (ALUOp == 2'b01) ? 3'b001 :
    //                     (ALUOp == 2'b10) ? ((funct3 == 3'b000) ? ((({op[5],funct7[5]} == 2'b00) | ({op[5],funct7[5]} == 2'b01) | ({op[5],funct7[5]} == 2'b10)) ? 3'b000 : 3'b001) : 
    //                                         (funct3 == 3'b010) ? 3'b101 : 
    //                                         (funct3 == 3'b110) ? 3'b011 : 
    //                                         (funct3 == 3'b111) ? 3'b010 : 3'b000) :
    //                                        3'b000;

    // Method 2
    assign ALUControl = (ALUOp == 2'b00) ? 3'b000 :
                        (ALUOp == 2'b01) ? 3'b001 :
                        ((ALUOp == 2'b10) & (funct3 == 3'b000) & ({op[5],funct7[5]} == 2'b11)) ? 3'b001 : 
                        ((ALUOp == 2'b10) & (funct3 == 3'b000) & ({op[5],funct7[5]} != 2'b11)) ? 3'b000 : 
                        ((ALUOp == 2'b10) & (funct3 == 3'b010)) ? 3'b101 : 
                        ((ALUOp == 2'b10) & (funct3 == 3'b110)) ? 3'b011 : 
                        ((ALUOp == 2'b10) & (funct3 == 3'b111)) ? 3'b010 : 
                                                                  3'b000 ;
endmodule
