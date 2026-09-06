
`include "cfs_algn_test_pkg.sv"

module testbench();
  
  import uvm_pkg::*;
  import cfs_algn_test_pkg::*;
  
  //CLock signal
  reg clk;
  
  //Reset signal - active low
  reg reset_n;
  //
  
  //Instantiate the APB Interface here
  cfs_apb_if apb_if(.pclk(clk)) ; 
  //
  
  //Clock generator
  initial begin
    clk = 0;
    
    forever begin
      //Generate an 100MHz clock
      clk = #5ns ~clk;
    end
  end
  //
  
  //Initial reset generator
  initial begin
    reset_n = 1;
    
    #6ns;
    
    reset_n = 0;
    
    #30ns;
    reset_n = 1;
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    
    //Start UVM test and phases
    //Will use the UVM_CONFIG_DB functional class
    uvm_config_db#(virtual cfs_apb_if)::set(null , "uvm_test_top.env.apb_agent" , "vif" , apb_if) ; //vif = virtual if
    //
    
    run_test("");
  end
  
  //Instantiate the DUT
  cfs_aligner dut(
    .clk(    clk),
    .reset_n(apb_if.preset_n),
    
    .paddr(apb_if.paddr) , 
    .pwrite(apb_if.pwrite) , 
    .psel(apb_if.psel) , 
    .penable(apb_if.penable) , 
    .pwdata(apb_if.pwdata) , 
    .pready(apb_if.pready) , 
    .prdata(apb_if.prdata) , 
    .pslverr(apb_if.pslverr) 
    
  );// Driving the APB agent here in our DUT
  
  
endmodule
