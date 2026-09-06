`ifndef CFS_APB_ITEM_DRV_SV 
`define CFS_APB_ITEM_DRV_SV
`include "cfs_apb_item_base.sv"
`include "cfs_apb_types.sv"

class cfs_apb_item_drv extends cfs_apb_item_base ; /* apb item base inherits from the cfs_apb_item_base  */ 
  
  
  rand int unsigned pre_drive_delay ; 
  rand int unsigned post_drive_delay ; //constraints to not let the values 
  										// go unreasonably high
  
  constraint pre_drive_delay_default{
    soft pre_drive_delay <= 5 ; 
  }
  
   constraint post_drive_delay_default{
    soft post_drive_delay <= 5 ; 
  }
  
  
  
  `uvm_object_utils(cfs_apb_item_drv) //mandatory uvm macros registers our item base to uvm factory
  //will enable typeif::create() "factory creation" and object overriding 
  
  function  new(string name = "") ; //constructor of our class and will take up a name
    super.new(name) ; //Calls the constructor of the parent class (typically uvm_object). Doesnt require a parent like in the uvm component
  endfunction
  
  virtual function string convert2string();
    
    string result = super.convert2string() ;
    
    if(dir==CFS_APB_WRITE) begin 
      result = $sformatf("%0s , data: %0x" , result , data) ; 
    end
    
    result = $sformatf("%0s , pre_drive_delay: %0d , post_drive_delay: %0d" , result , pre_drive_delay , post_drive_delay) ; 
    
    
    return result ;
  endfunction 
  
  
endclass

`endif
