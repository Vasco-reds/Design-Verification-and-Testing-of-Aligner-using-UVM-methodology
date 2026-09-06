`ifndef CFS_APB_AGENT_SV
`define CFS_APB_AGENT_SV
 
`include "cfs_apb_sequencer.sv" 
`include "cfs_apb_driver.sv" 

class cfs_apb_agent extends uvm_agent ;
  
  cfs_apb_agent_config agent_config;
  cfs_apb_sequencer sequencer ;          //Handlers
  cfs_apb_driver driver ; 
  cfs_apb_monitor monitor ; //monitor handler
  
  `uvm_component_utils(cfs_apb_agent)  
  
  function new(string name = "" , uvm_component parent);
    super.new(name , parent) ; 
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase) ;
    agent_config = cfs_apb_agent_config::type_id::create("agent_config" , this) ; 
    monitor      = cfs_apb_monitor::type_id::create("monitor" , this) ; 
    
    if(agent_config.get_active_passive() == UVM_ACTIVE) begin 
      sequencer = cfs_apb_sequencer::type_id::create("sequencer" , this);
      driver = cfs_apb_driver::type_id::create("driver" , this);
    end 
    
    
  endfunction // Will give a fatal uvm error
  //This will be the error : "[ALGORITHM_ISSUE] The APB virtual interface is not configured at "Start of the simulation" phase" 
  //To fix it we will require a connect_phase 
  
  virtual function void connect_phase(uvm_phase phase) ;
    cfs_apb_vif vif ; 
    
    super.connect_phase(phase) ; 
    
    
    if(uvm_config_db#(cfs_apb_vif)::get(this, "" , "vif" , vif )==0) begin 
      //get ==0 if the get is unsucessful because get returns a bit output
      `uvm_fatal("APB_NO_VIF" ," Could not get the database from the APB virtual interface") ; 
      
    end
    
    else begin 
      agent_config.set_vif(vif) ;  
    end
    
    monitor.agent_config = agent_config ; 
    
    if(agent_config.get_active_passive() == UVM_ACTIVE) begin
      driver.agent_config = agent_config ; 
      driver.seq_item_port.connect(sequencer.seq_item_export) ; 
    end
    
  endfunction
  
endclass
  

`endif
