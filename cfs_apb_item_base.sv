`ifndef CFS_APB_ITEM_BASE_SV 
`define CFS_APB_ITEM_BASE_SV 

class cfs_apb_item_base extends uvm_sequence_item ; /* apb item base inherits from the uvm sequencer class */ 
  
  rand cfs_apb_dir dir ; 
  rand cfs_apb_addr addr ; 
  rand cfs_apb_data data ; //randomised fields
  
  `uvm_object_utils(cfs_apb_item_base) //mandatory uvm macros registers our item base to uvm factory
  //will enable typeif::create() "factory creation" and object overriding 
  
  function  new(string name = "") ; //constructor of our class and will take up a name
    super.new(name) ; //Calls the constructor of the parent class (typically uvm_object). Doesnt require a parent like in the uvm component
  endfunction
  
   virtual function string convert2string();
    
    string result = $sformatf("dir: %0s , addr: %0x" , dir.name() , addr) ;
    

    return result ;
  endfunction
  
endclass

`endif