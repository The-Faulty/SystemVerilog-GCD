/******************************************************************************
 Module Name : gcd
 Description :
	 Greatest Common Divisor
	 ! gcd( 6, 2) = 2
	 ! gcd( 9,12) = 3
	 ! gcd(18,12) = 6

Commented code is the remains of my first attempt where it checks each possible
	divisor instead of using the Euclidean algorithm
*******************************************************************************/

typedef enum logic[1:0] {
    findGCD,
    finished
} state;

module gcd 
    #(
        parameter WIDTH = 8
    )
    (
	    input  logic            clk_i, reset_i,   // global
	    input  logic            valid_i,        // valid in
	    input  logic [WIDTH-1:0]a_i, b_i,       // operands
	    output logic [WIDTH-1:0]gcd_o,          // gcd output
	    output logic            valid_o         // valid out
    );
    
	logic [WIDTH-1:0] a, b;	//, c, original_a, original_b;
	state current_state;

	always @ (posedge clk_i)
	begin
		if (reset_i == 1'b1) begin
			valid_o <= 1'b0;
			gcd_o <= 0;
			a <= 0;
			b <= 0;
			//c <= 0;
			current_state <= finished;
		end
		else begin
			if (valid_i == 1'b1) begin
				valid_o <= 1'b0;
				gcd_o <= 0;
				a <= a_i;
				//original_a <= a_i;
				b <= b_i;
				//original_b <= b_i;
				//c <= (a_i > b_i) ? b_i : a_i;
				current_state <= findGCD;
			end
			else begin
				if (current_state == findGCD) begin
					if (a == 0) begin
						gcd_o <= b;
						valid_o <= 1'b1;
						current_state = finished;
					end
					else if (b == 0 | a == b) begin
						gcd_o <= a;
						valid_o <= 1'b1;
						current_state = finished;
					end
					else if (a > b) 
						a <= a - b;
					else
						b <= b - a;
				end
				/*case(current_state)
					checkA: begin
						if (c <= 1) begin
							valid_o <= 1'b1;
							gcd_o <= c;
							current_state <= finished;
						end
						else if (a == 0)
							current_state <= checkB;
						else if (a < a - c) begin
							a <= original_a;
							c <= c - 1;
						end
						else			// a > 0 and will not be negative
							a <= a - c;
					end
					checkB: begin
						if (b == 0) begin
							gcd_o <= c;
							valid_o <= 1'b1;
							current_state <= finished;
						end
						else if (b < b - c) begin
							a <= original_a;
							b <= original_b;
							c <= c - 1;
							current_state <= checkA;
						end
						else 		// b > 0 and will not be negative
							b <= b - c;
					end	
				endcase*/
			end
		end
	end
endmodule
