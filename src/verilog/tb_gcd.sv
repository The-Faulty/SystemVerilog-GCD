module tb_gcd;

    parameter WIDTH = 8;
    //=============== Generate the clock =================
    localparam CLK_PERIOD = 20; //Set clock period: 20 ns
    //localparam OFFSET = 0.125 * CLK_PERIOD; //not needed for pre-synthesis simulation
    localparam DUTY_CYCLE = 0.5;
    //define clock
    logic clk_i;
    
    initial begin
	forever //run the clock forever
	begin		
		#(CLK_PERIOD*DUTY_CYCLE) clk_i = 1'b1; //wait 10 ns then set clock high
		#(CLK_PERIOD*DUTY_CYCLE) clk_i = 1'b0; //wait 10 ns then set clock low
	end
	end

    //======== Define wires going into GCD module ========
    logic             reset_i;   // global
    logic             valid_o;         // valid
    logic [WIDTH-1:0] a_i, b_i;       // operands
    logic [WIDTH-1:0] gcd_o;          // gcd output
    logic             valid_i;        // start

    //========= Instantiate a gcd module ==============
    gcd #(WIDTH) gcd0 (.*);


    /*logic test_cases[WIDTH-1:0][] = {
        '{48, 18},
        '{17, 23},
        '{100, 75},
        '{0, 5},
        '{0, 0},
        '{255, 255},
        '{128, 64},
        '{7, 13}
    };*/

    reg flag = 1'b0;

    initial begin
        //These two lines just allow visibility of signals in the simulation
        $vcdpluson; //Starts recording, in the VPD file, the transition times and values for the nets and registers
        $vcdplusmemon; //Records value changes and times for memories and multidimensional arrays

        $display("\n--------------Beginning Simulation!--------------\n");
        @(posedge clk_i);
        initialize_signals();
        @(posedge clk_i);

        for (int i = 0; i < 255; i++) begin
            if (flag == 1'b1)
                break;
            for (int j = 0; j < 255; j++) begin
                test_gcd(i, j, flag);
                if (flag == 1'b1)
                    break;
                #100;
            end
        end
        if (flag == 1'b0)
            $display("All test cases successfully completed");
        $display("\n-------------Finished Simulation!----------------\n");
        $finish;
    end

    //========= Record Outputs ===========
    /*initial begin
    forever begin //run this block forever, starting at the beginning of the simulation
        @(posedge clk_i) begin
        if (valid_o == 1'b1) begin //if valid_o is high, record the value of the GCD.
            $display("Result:\t%d\n", gcd_o);
            @(negedge valid_o); //wait till it goes low to keep looking for new results
        end
        end
    end
    end*/

    //Task to set the initial state of the signals. Task is called up above
    task initialize_signals();
    begin
        $display("--------------Initializing Signals---------------\n");
        reset_i  = 1'b1;
        valid_i = 1'b0;
        a_i    = '0;
        b_i    = '0;
    end
    endtask

    function int getGCD(int a, b);
        if (a == 0) 
            return b; 
        if (b == 0) 
            return a; 
        if (a == b) 
            return a;
        if (a > b) 
            return getGCD(a - b, b); 
        return getGCD(a, b - a); ;
    endfunction

    //Example task which tests the GCD module for one test case
    task gcd_60_84();
    begin
        $display("GCD of 60 and 84");
        reset_i<=1'b0; //enable the GCD module
        @(posedge clk_i);
        a_i<=60; //pulse inputs and pulse valid bit
        b_i<=84;
        valid_i<=1'b1;
        @(posedge clk_i);
        valid_i<=1'b0; 
        a_i<=0;
        b_i<=0;
        @(posedge clk_i); //this task ends as soon as the inputs have been pulsed. Doesn't wait for results.
    end
    endtask

    task test_gcd(input logic[WIDTH-1:0] a, b, output reg flag);
    begin
        reset_i<=1'b0;      //enable the GCD module
        @(posedge clk_i);
        a_i<=a;             //pulse inputs and pulse valid bit
        b_i<=b;
        valid_i<=1'b1;
        @(posedge clk_i);
        valid_i<=1'b0; 
        a_i<=0;
        b_i<=0;
        @(posedge valid_o);
        @(posedge clk_i);
        if (gcd_o != getGCD(a, b)) begin
            $display("Verification failed on inputs %d and %d with output %d", a, b, gcd_o);
            flag <= 1'b1;
        end
        else
            flag <= 1'b0;
    end
    endtask
endmodule 
