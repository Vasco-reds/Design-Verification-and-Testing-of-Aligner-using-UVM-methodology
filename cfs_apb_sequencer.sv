`ifndef CFS_APB_SEQUENCER_SV
`define CFS_APB_SEQUENCER_SV 

class cfs_apb_sequencer extends uvm_sequencer#(.REQ(cfs_apb_item_drv)) ; 
  
  //Mandatory constructor + macros for our component 
  `uvm_component_utils(cfs_apb_sequencer)
  
  function new(string name = "" , uvm_component parent) ; 
    super.new(name,parent) ; 
  endfunction
  
endclass

`endif
