/////////////////////////////////////////////////////////////////////////
//                                                                     //
//   Modulename :  hazard_ctrl.v                                       //
//                                                                     //
//  Description :  This module creates the Regfile used by the ID and  // 
//                 WB Stages of the Pipeline.                          //
//                                                                     //
/////////////////////////////////////////////////////////////////////////

module hazard_ctrl(
    input         clock,                // system clock
	input         reset,                // system reset 
	input IF_ID_PACKET if_packet,
    input [4:0] id_ex_inst_dest,        
    input [4:0] ex_mem_inst_dest,
    input [4:0] mem_wb_inst_dest,
    input [1:0] in_type,                //  R_TYPE = 2'b00,  2 Src Regs All  can be .r 
                                        //  I_TYPE = 2'b01,  1 Src Reg  All can be .i
                                        //  S_TYPE = 2'b10,  2 Src Regs All can be .s 
                                        //  U_TYPE = 2'b11,  0 Src Regs Doesn't even matter            
    input       is_load_inst,           //  Indicates to the poor souls in the back this is a load, Thus might stall
);

    logic [5:0] reg_ex;                 //  Destination register of the inst currently in EX
    logic [5:0] reg_mem;                //  Destination register of the inst currently in MEM
    logic [5:0] reg_wb;                 //  Destination register of the inst currently in WB 
                                        //  ^ currently no use but maybe it comes up in branch?    

    //Because WAR and WAW impossible in this simple processor only need to concern with structural and branch
    //Hazards. So as of now since I have not dealt with branches yet the current things to take care of are
    //Forward output of Mux in Wb stage into next Stage Mux
    //Forward EX/MEM output into ALU input
    //SW hazard wait for load to finish
    always_comb begin
        case(in_type) 
            R_TYPE : begin
                /* Ex opA mux Effects, All items are seperate if statements because mutually exclusive      */
                /* so evaluate in parallel no in sequence i.e. not via cascade (| for r0 i.e. don't care)   */
                
                (|if_packet.inst.r.rs1) begin 
                    //Reg A is computed in the instruction that proceeds this in the pipeline
                    if( if_packet.inst.r.rs1 == id_ex_inst_dest ) begin
                        
                    end
                    //Reg A is computed in the instruction 2 prior to this one this in the pipeline
                    if( if_packet.inst.r.rs1 == ex_mem_inst_dest ) begin
                        
                    end
   
                end

                /* Same as above but for Ex opB */
                (|if_packet.inst.r.rs1) begin 
                    //Reg B is computed in the instruction that proceeds this in the pipeline
                    if( if_packet.inst.r.rs1 == id_ex_inst_dest ) begin
                        
                    end
                    //Reg A is computed in the instruction 2  this in the pipeline



                end
            end //  R_Type 
           
            I_TYPE : begin

                // Loading Inst, Spin that disc, put up the loading screen and hit the scene
                // If this causes a 

            end



            S_TYPE : 

            U_TYPE :

        endcase

    end


    always_ff @(posedge clock) begin
        // Just set it all at the R0 Because Idk its a reset who cares it won't matter
        if(reset) begin
            reg_ex      <= 6'b0;
            reg_mem     <= 6'b0;
            reg_wb      <= 6'b0;
        end
        else begin
            //Cascade down, i.e. next cycle reg_mem is last cycles reg_ex and reg_wb is 2 cycles ago reg_ex
            reg_ex      <= //incoming
            reg_mem     <= reg_ex;
            reg_wb      <= reg_mem;
        end

    end



endmodule // hazard_ctrl