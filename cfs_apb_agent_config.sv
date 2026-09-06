`ifndef CFS_APB_AGENT_CONFIG_SV
`define CFS_APB_AGENT_CONFIG_SV

class cfs_apb_agent_config extends uvm_component ;
  
  //Localising the virtual interface variable to be used in this class only
  //To access globally use the uvm_config_db functions (get , set) 
  
  local cfs_apb_vif vif ; 
  
  local uvm_active_passive_enum active_passive ; //want to find if our agent is active. uvm_active_passive_enum is declared in our uvm library
  
  local bit has_checks ; //Switch to enable the checks
  
  `uvm_component_utils(cfs_apb_agent_config) 
  
  
  function new(string name = "", uvm_component parent);
    super.new(name,parent) ;
    active_passive = UVM_ACTIVE ; 
    has_checks = 1 ; 
  endfunction
  
  //Declaration of the Getter 
  virtual function cfs_apb_vif get_vif(); 
    return vif ; 
  endfunction
  ///////
  
  //Getter for uvm_active_passive_enum
  virtual function uvm_active_passive_enum get_active_passive() ; 
    return active_passive ; 
  endfunction
  
 //
  
 //Setter for uvm_active_passive_enum 
  virtual function void set_active_passive(uvm_active_passive_enum value) ;
    active_passive = value ; 
  endfunction
  
  //getter for active_checks 
  virtual function bit get_has_checks() ; 
    return has_checks ; 
  endfunction
  
  //Setter for has_checks
  virtual function void set_has_checks(bit value) ; 
    has_checks = value ;
    
    if(vif != null) begin
      vif.has_checks = has_checks ; 
    end
  endfunction
  
  
  //Declare setters
  virtual function void set_vif(cfs_apb_vif value);
    
    if(vif==null) begin
      vif = value ;
      set_has_checks(get_has_checks()) ; 
    end
    
    else begin 
      `uvm_fatal("ALGORITHM_ISSUE" , "Tried setting the APB virtual interface more than once")  
    end
    
  endfunction
  ///////
  
  virtual function void start_of_simulation_phase(uvm_phase phase);
    super.start_of_simulation_phase(phase) ; 
    
    if(get_vif()==null) begin 
      `uvm_fatal("ALGORITHM_ISSUE" , "The APB virtual interface is not configured at \"Start of the simulation\" phase" ) 
    end
    
    else begin
      `uvm_info("APB_CONFIG" , "The APB virtual interface is configured at \"Start of the simulation\" phase", UVM_LOW)  
    end
  endfunction
  
  
  virtual task run_phase(uvm_phase phase) ; 
    forever begin 
      @(vif.has_checks) ; 
      if(vif.has_checks != get_has_checks()) begin
        `uvm_error("ALGORITHM_ISSUE" , $sformatf("Can not change \'has_checks\" from APB interface directly - use %0s.set_has_checks()" , get_full_name()))
      end
    end
  endtask
  
endclass

`endif