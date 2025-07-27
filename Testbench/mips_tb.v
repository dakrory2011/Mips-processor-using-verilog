module mips_tb ();
    
    reg clk, reset; // Declare clk and rst as reg types for simulation purposes
    mips uut(
    .clk(clk),
    .reset(reset)
    
    );
  localparam Timer=10;
       always
       begin
       clk=1'b0;
       #(Timer/2)
       clk =1'b1;
       #(Timer/2);
       end
       initial 
       begin
       reset=1'b1;
       #10 
       reset=1'b0;
       end
    initial begin
        #500; // Run the simulation for 1000 time units
        $stop; // End the simulation
    end
    endmodule