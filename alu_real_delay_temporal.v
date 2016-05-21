`timescale 1ns/1ns
module parallel_adder(A, B, cin, S, cout) ;     //I used a parallel adder for my additions
        output S, cout;
        input A, B, cin;
        wire w1, w2, w3, w4, w5, w6, w7;
        not #1 (w5, cin);
        not #1 (w7, w2);
        nand #3 (w1, A, B);
        or #2 (w2, A, B);
        nor #1 (cout, w7, w3);
        and #2 (w3, w1, w5);
        and #2 (w4, w1, w2);
        xor #3 (S, w4, cin);
endmodule


module bit_alu(A, B, cin, op, less, out, cout, set) ;
        output  out, cout, set;
        input [2:0] op;
        input A, B, cin, less;
        wire andwire1, orwire1, addsubwire1, andwire2, orwire2, addsubwire2, opwire1, opwire2, setwire, subopnotwire, notinputwire, addopwire, subopwire, newBwire;

        and #2 (andwire1, A, B);   //this is the and intruction

        or #2 (orwire1, A, B);     //this is the or instruction

        not #1 (subopnotwire, op[2]);      //this is the multiplexer for choosing addition or subtraction
        not #1 (notinputwire, B);
        and #2 (addopwire, B, subopnotwire);
        and #2 (subopwire, notinputwire, op[2]);
        or #2 (newBwire, addopwire, subopwire);

        parallel_adder p (A, newBwire, cin, addsubwire1, cout); //this uses the parallel adder for the add instruction

        and #2 (set, 1, addsubwire1);      //this is just assigning the result of the add/sub operation to the set output, it could only be 1 during the 32. For the SLT

        not #1 (opwire1, op[0]);           //the following lines are a 4 to 1 multiplexer to decide what result to take according to the op code
        not #1 (opwire2, op[1]);
        and #2 (andwire2, andwire1, opwire1, opwire2);
        and #2 (orwire2, orwire1, op[0], opwire2);
        and #2 (addsubwire2, addsubwire1, op[1], opwire1);
        and #2 (setwire, less, op[1], op[0]);
        or #2 (out, andwire2, orwire2, addsubwire2, setwire);
endmodule

`timescale 1ns/1ns
module alu(A, B, op, out, overflow, zero);
        input [31:0] A, B;
        input [2:0] op;
        output [31:0] out;
        output overflow, zero;
        wire [31:0] in_out_wire, extra_set_wire;
        wire first_less_wire;

        //The following 32 lines is the ALU running through all 32 bits of the input numbers
        bit_alu a1 (A[0], B[0], op[2], op, first_less_wire, out[0], in_out_wire[0], extra_set_wire[0]);
        bit_alu a2 (A[1], B[1], in_out_wire[0], op, 0, out[1], in_out_wire[1], extra_set_wire[1]);
        bit_alu a3 (A[2], B[2], in_out_wire[1], op, 0, out[2], in_out_wire[2], extra_set_wire[2]);
        bit_alu a4 (A[3], B[3], in_out_wire[2], op, 0, out[3], in_out_wire[3], extra_set_wire[3]);
        bit_alu a5 (A[4], B[4], in_out_wire[3], op, 0, out[4], in_out_wire[4], extra_set_wire[4]);
        bit_alu a6 (A[5], B[5], in_out_wire[4], op, 0, out[5], in_out_wire[5], extra_set_wire[5]);
        bit_alu a7 (A[6], B[6], in_out_wire[5], op, 0, out[6], in_out_wire[6], extra_set_wire[6]);
        bit_alu a8 (A[7], B[7], in_out_wire[6], op, 0, out[7], in_out_wire[7], extra_set_wire[7]);
        bit_alu a9 (A[8], B[8], in_out_wire[7], op, 0, out[8], in_out_wire[8], extra_set_wire[8]);
        bit_alu a10 (A[9], B[9], in_out_wire[8], op, 0, out[9], in_out_wire[9], extra_set_wire[9]);
        bit_alu a11 (A[10], B[10], in_out_wire[9], op, 0, out[10], in_out_wire[10], extra_set_wire[10]);
        bit_alu a12 (A[11], B[11], in_out_wire[10], op, 0, out[11], in_out_wire[11], extra_set_wire[11]);
        bit_alu a13 (A[12], B[12], in_out_wire[11], op, 0, out[12], in_out_wire[12], extra_set_wire[12]);
        bit_alu a14 (A[13], B[13], in_out_wire[12], op, 0, out[13], in_out_wire[13], extra_set_wire[13]);
        bit_alu a15 (A[14], B[14], in_out_wire[13], op, 0, out[14], in_out_wire[14], extra_set_wire[14]);
        bit_alu a16 (A[15], B[15], in_out_wire[14], op, 0, out[15], in_out_wire[15], extra_set_wire[15]);
        bit_alu a17 (A[16], B[16], in_out_wire[15], op, 0, out[16], in_out_wire[16], extra_set_wire[16]);
        bit_alu a18 (A[17], B[17], in_out_wire[16], op, 0, out[17], in_out_wire[17], extra_set_wire[17]);
        bit_alu a19 (A[18], B[18], in_out_wire[17], op, 0, out[18], in_out_wire[18], extra_set_wire[18]);
        bit_alu a20 (A[19], B[19], in_out_wire[18], op, 0, out[19], in_out_wire[19], extra_set_wire[19]);
        bit_alu a21 (A[20], B[20], in_out_wire[19], op, 0, out[20], in_out_wire[20], extra_set_wire[20]);
        bit_alu a22 (A[21], B[21], in_out_wire[20], op, 0, out[21], in_out_wire[21], extra_set_wire[21]);
        bit_alu a23 (A[22], B[22], in_out_wire[21], op, 0, out[22], in_out_wire[22], extra_set_wire[22]);
        bit_alu a24 (A[23], B[23], in_out_wire[22], op, 0, out[23], in_out_wire[23], extra_set_wire[23]);
        bit_alu a25 (A[24], B[24], in_out_wire[23], op, 0, out[24], in_out_wire[24], extra_set_wire[24]);
        bit_alu a26 (A[25], B[25], in_out_wire[24], op, 0, out[25], in_out_wire[25], extra_set_wire[25]);
        bit_alu a27 (A[26], B[26], in_out_wire[25], op, 0, out[26], in_out_wire[26], extra_set_wire[26]);
        bit_alu a28 (A[27], B[27], in_out_wire[26], op, 0, out[27], in_out_wire[27], extra_set_wire[27]);
        bit_alu a29 (A[28], B[28], in_out_wire[27], op, 0, out[28], in_out_wire[28], extra_set_wire[28]);
        bit_alu a30 (A[29], B[29], in_out_wire[28], op, 0, out[29], in_out_wire[29], extra_set_wire[29]);
        bit_alu a31 (A[30], B[30], in_out_wire[29], op, 0, out[30], in_out_wire[30], extra_set_wire[30]);
        bit_alu a32 (A[31], B[31], in_out_wire[30], op, 0, out[31], in_out_wire[31], first_less_wire);

        xor #3 (overflow, in_out_wire[30], in_out_wire[31]); //this finds if there is an overflow

        nor #3 (zero, out[0], out[1], out[2],out[3],out[4],out[5],out[6],out[7],out[8],out[9],out[10],out[11],out[12],out[13],out[14],out[15],out[16],out[17],out[18],out[19],out[20],out[21],out[22],out[23],out[24],out[25],out[26],out[27],out[28],out[29],out[30],out[31]); //this finds the zero output
endmodule


module testbench();
        wire [31:0] A, B, out;
        wire [2:0] op;
	wire overflow, zero;
        testALU test (A, B, op, out, overflow, zero);
        alu alu_demo (A, B, op, out, overflow, zero);
endmodule

`timescale 1ns/1ns
module testALU(A, B, op, out, overflow, zero);
        input [31:0] out;
        input overflow, zero;
	output [31:0] A, B;
        output [2:0] op;
        reg [31:0] A,B;
        reg [2:0] op;

        initial
        begin

                $monitor($time,,"A=%b, B=%b, op=%b, out=%b, overflow=%b, zero=%b",A, B, op, out, overflow, zero);
		$display($time,,"A=%b, B=%b, op=%b, out=%b, overflow=%b, zero=%b",A, B, op, out, overflow, zero);
		$display($time,, "First temporal delay simulation. Take note of how the correct answer for the first input, an AND operation, does not display correctly until the second set of inputs are applied. Zero and overflow likewise are delayed, with overflow of the first inouts not appearing until 15 ns have passed since it takes longer for the addition needed to find the overflow.");
	       #1 A=32'b11000000000000000000000000000001; B=32'b11001110010111111111100111110011; op=000;
               #1
	       #1
               #1
	       #1
    	       #1 A=32'b11110000000000000000000000000001; B=32'b00000000000000000000000000000001; op=001;	
	        #100
		$display($time,,"__________________________________________________________________________________________________________________________________________");
		$display($time,, "The second temporal delay data set. Note how the ADD instruction takes much more time to run properly, and how the answer does not display at any point in the display. The answer should be 0, but the inputs are switched before the ADD can be completed. Resulting in the ALU starting to replace the 0s in the answer with 1s before it can finish the addition instruction.");
	       #100 A=32'b00000000000000000000000000000001; B=32'b11111111111111111111111111111111; op=010;
               #1
               #1
	       #1
	       #1
	       #1
	       #1
       	       #1
	       #1
               #1 A=32'b11110000000000000000000000011111; B=32'b01100000000000000000000000011001; op=001;
               #100
		$display($time,,"__________________________________________________________________________________________________________________________________________");
                $display($time,,"The third set of temporal delay input data. This time both A and B are the same, but the expected answer of the first instruction, a SLT is a 1 since -1 is less than 1. However, this is never displayed properly since the ADD instruction is started only five ns after the SLT. This makes the answer to the SLT never clearly display. The overall time to run both instructions is close to 150 ns, one of the longest delays seen thus far, and due to the ALU working on the first input while suddenly recieving new inputs, it never manages to display the correct result of either operation correctly"); 
		#1 A=32'b11111111111111111111111111111111; B=32'b00000000000000000000000000000001; op=111;
		#1
		#1
		#1
		#1
		#1
		#1
		#1
		#1
		#1 A=32'b11111111111111111111111111111111; B=32'b00000000000000000000000000000001; op=010;
		#100
                $display($time,,"__________________________________________________________________________________________________________________________________________");
                $display($time,,"For the forth temporal delay input the same A and B are used for both instructions again. However, SLT uses subtraction, so it is essentially repeatng the same instruction, but instead of -14, the SLT should output a 1. Which it never succeeds in doing since SLT is not given enough time");
                #1 A=32'b00000000000000000000000000000000; B=32'b00000000000000000000000000001110; op=111;
                #1
                #1
                #1
                #1
                #1
                #1
                #1
                #1
                #1 A=32'b00000000000000000000000000000000; B=32'b00000000000000000000000000001110; op=110;
		#100
		$display($time,,"__________________________________________________________________________________________________________________________________________");
                $display($time,,"The fifth and final temporal delay data set is an OR and then an AND using the same A and B. The asnwers should be all 1s for the first input and all 0s for the second input. However, the first input relies on having more time to complete the instruction, which it doesn't have. So the correct answer for the OR is never displayed");
                #1 A=32'b11111111111111110000000000000000; B=32'b00000000000000001111111111111111; op=001;
		#1
		#1
                #1 A=32'b11111111111111110000000000000000; B=32'b00000000000000001111111111111111; op=000;
                #100
		 $display($time,,"A=%b, B=%b, op=%b, out=%b, overflow=%b, zero=%b",A, B, op, out, overflow, zero);	 
        end
endmodule

