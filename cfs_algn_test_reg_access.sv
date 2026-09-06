
`ifndef CFS_ALGN_TEST_REG_ACCESS_SV
  `define CFS_ALGN_TEST_REG_ACCESS_SV
`include "cfs_apb_item_drv.sv"


  class cfs_algn_test_reg_access extends cfs_algn_test_base;

    `uvm_component_utils(cfs_algn_test_reg_access)
    
    function new(string name = "", uvm_component parent);
      super.new(name, parent);
    endfunction
    
    virtual task run_phase(uvm_phase phase);
      phase.raise_objection(this, "TEST_DONE");
      
      #(100ns);
      
      begin // simple sequence call
        cfs_apb_sequence_simple seq_simple = cfs_apb_sequence_simple::type_id::create("simple_seq");
        
        void'(seq_simple.randomize() with {
        		item.addr == 'h222 ; 
        });
        seq_simple.start(env.apb_agent.sequencer) ;          
      end
      
      begin // read and write sequence
        cfs_apb_sequence_rw seq_rw = cfs_apb_sequence_rw::type_id::create("seq_rw") ; 
        
        void'(seq_rw.randomize() with{
          addr == 'h20 ; 
        }) ; 
        seq_rw.start(env.apb_agent.sequencer) ; 
      end
      
      begin
        cfs_apb_sequence_random seq_rand = cfs_apb_sequence_random::type_id::create("seq_rand") ; 
        
        void'(seq_rand.randomize() with{
          num_items == 3 ; 
        }) ;
        
        seq_rand.start(env.apb_agent.sequencer) ;
      end
      
      
      for(int i = 0 ; i<10 ; i++) begin 
        cfs_apb_item_drv item = cfs_apb_item_drv::type_id::create("item") ; 
        
        void'(std::randomize(item)) ; 
        
        `uvm_info("DEBUG" , $sformatf("[%0d] item: %0s" , i , 			       						item.convert2string() ) , UVM_LOW) 
      end
      
      `uvm_info("DEBUG", "this is the end of the test", UVM_LOW)
      
      phase.drop_objection(this, "TEST_DONE"); 
    endtask
    
  endclass

`endif