module pc_adder(
input [31:0] frompc,
output [31:0] topc
);
assign topc =frompc+4;

endmodule
