`ifndef CFS_APB_SEQUENCE_SIMPLE_SV 
`define CFS_APB_SEQUENCE_SIMPLE_SV 
`include "cfs_apb_item_drv.sv" 

class cfs_apb_sequence_simple extends cfs_apb_sequence_base ; 
  
  rand cfs_apb_item_drv item ; 
  
  `uvm_object_utils(cfs_apb_sequence_simple) 
  function new (string name = ""); 
    super.new(name) ; 
    
    item = cfs_apb_item_drv::type_id::create("item") ;
  endfunction
  
  virtual task body() ; 
    start_item(item) ; //can also use `uvm_do(item) or `uvm_send(item)
    finish_item(item) ;  
  endtask
  
endclass

`endif