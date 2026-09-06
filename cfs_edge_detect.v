
`ifndef CFS_EDGE_DETECT_V
  `define CFS_EDGE_DETECT_V
  
  module cfs_edge_detect #(parameter bit EDGE = 1)(
    input clk,
    input reset_n,
    input data,
    
    output reg detected
  );
    
    reg dly1_data;
    
    always@(posedge clk or negedge reset_n) begin
      if(reset_n == 0) begin
        dly1_data <= !EDGE;
      end
      else begin
        dly1_data <= data;
      end
    end
    
    assign detected = ((data == EDGE) & (dly1_data == !EDGE));
    
  endmodule

`endif