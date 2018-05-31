//===========================================
// Function : SRAM_WRAP.h 
//===========================================
#include "systemc.h"

#define ADDR_SIZE		18	// 2^18 = 256k 
#define WORD_SIZE		8	// 8 bits

//#define _DEBUG_

SC_MODULE (SRAM_WRAP){
	// Signals to SRAM
	// ..
	// ..
	// Needs Revision by Chandrahas
	sc_out <bool> bCE; // input control signal to the memory
	sc_out <bool> bWE; // input control signal to the memory
	sc_out_rv <18>  Addr; // input memory address to the memory
	sc_out_rv <8>  InData; // input data to the memory 
	sc_in_rv <8>  OutData; // output data from the memory
	
	// Signals to System Bus
	// ..
	// ..
	// Needs Revision by Chandrahas
	sc_inout_rv <32> AddressBus;
	sc_inout_rv <1>  ControlBus;
	sc_inout_rv <8>  DataBus; 
	
	// Signals to Arbiter
	// ..
	// ..
	// Needs Revision by Chandrahas
	sc_in <bool> Bgnt;
	sc_out <bool> Breq;
	
	// to TEST-BENCH
	sc_in < bool >			bReset;
	sc_in < bool >			clk;

	// Internal signal
	sc_uint < 1 > 			IntEnable;
	sc_uint < 4 >			AddrDecoded;

	// ----- Code Starts Here ----- 
	void Function_SRAM_WRAP();
	void Bus_Control();

	// ----- Constructor for the SC_MODULE -----
	// sensitivity list
	SC_CTOR(SRAM_WRAP) {
		SC_METHOD(Function_SRAM_WRAP);
		sensitive << clk.pos() << bReset.neg();

		SC_METHOD(Bus_Control);
		sensitive << clk.pos() << AddressBus << OutData << ControlBus ;
	}
};

