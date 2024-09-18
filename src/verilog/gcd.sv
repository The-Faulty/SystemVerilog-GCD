/******************************************************************************
 Module Name : gcd
 Description :
	 Greatest Common Divisor
	 ! gcd( 6, 2) = 2
	 ! gcd( 9,12) = 3
	 ! gcd(18,12) = 6

*******************************************************************************/

typedef enum logic[1:0] {
    IDLE,
	START,
	AGREATER,
	BGREATER
} state;

module gcd 
    #(
        parameter WIDTH = 8
    )
    (
	    input  logic            clk_i, reset_i,   	// global
	    input  logic            valid_i,        	// valid in
	    input  logic [WIDTH-1:0]a_i, b_i,       	// operands
	    output logic [WIDTH-1:0]gcd_o,          	// gcd output
	    output logic            valid_o         	// valid out
    );
    
	logic [WIDTH-1:0] a, b;
	state current_state, next_state;

	always_ff @ (posedge clk_i)
	begin
		if (reset_i == 1'b1)
			current_state <= IDLE;
		else
			current_state <= next_state;
	end
	

	always_comb begin
		next_state = current_state;	

		case (current_state)
			IDLE:
				if (valid_i)
					next_state = START;
			START, AGREATER, BGREATER:
				if (a == 0 | b == 0 | a == b)
					next_state = IDLE;
				else if (a > b)
					next_state = AGREATER;
				else
					next_state = BGREATER;
		endcase
	end

	always_ff @ (posedge clk_i)
	begin
		if (reset_i == 1'b1) begin
			valid_o <= 1'b0;
			gcd_o <= 0;
			a <= 0;
			b <= 0;
		end
		else begin
			case (next_state)
				IDLE: begin
					if (current_state == START) begin
						gcd_o <= (a > b) ? a : b;
						valid_o <= 1'b1;
					end
					else if (current_state == AGREATER | current_state == BGREATER) begin
						gcd_o <= a;			// If previous state was AGREATER or BGREATER, then a should equal b
						valid_o <= 1'b1;
					end
				end
				START: begin
					valid_o <= 1'b0;
					gcd_o <= 0;
					a <= a_i;
					b <= b_i;
				end
				AGREATER:
					a <= a - b;
				BGREATER:
					b <= b - a;
			endcase
		end
	end
endmodule
