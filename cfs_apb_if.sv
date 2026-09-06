`ifndef CFS_APB_IF_SV 
`define CFS_APB_IF_SV 

`ifndef CFS_APB_MAX_ADDR_WIDTH
`define CFS_APB_MAX_ADDR_WIDTH 32
`endif

`ifndef CFS_APB_MAX_DATA_WIDTH
`define CFS_APB_MAX_DATA_WIDTH 32
`endif

interface cfs_apb_if(input pclk) ;
  
  logic preset_n ; 
  logic [`CFS_APB_MAX_ADDR_WIDTH -1:0] paddr ; 
  logic penable ; 
  logic pwrite ; 
  logic psel ; 
  logic [`CFS_APB_MAX_DATA_WIDTH-1:0] pwdata ; 
  logic pslverr ; 
  logic pready ; 
  logic [`CFS_APB_MAX_DATA_WIDTH-1:0] prdata ; 
  bit has_checks ;
  
  initial begin
    has_checks = 1 ; 
  end
  
  sequence setup_phase_s;
    (psel == 1) && (($past(psel) == 0 ) || (($past(psel) == 1) && ($past(pready) == 1))) ; 
  endsequence
  
  sequence access_phase_s ; 
    (psel == 1) && (penable == 1) ; 
  endsequence
  
  property penable_at_setup_phase_p ; 
    @(posedge pclk) disable iff(!preset_n || !has_checks)
    setup_phase_s |-> penable == 0 ;
  endproperty
  
  PENABLE_AT_SETUP_PHASE_A : assert property(penable_at_setup_phase_p) else
    $error("PENABLE at \"Setup Phase\" is not equal to 0") ;
  
endinterface

`endif