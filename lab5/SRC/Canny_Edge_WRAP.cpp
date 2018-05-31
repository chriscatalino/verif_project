//===========================================
// Function : Canny_Edge_WRAP.cpp
//===========================================
#include "Canny_Edge_WRAP.h"

void Canny_Edge_WRAP::Bus_Control() {
    	uint bControl = ControlBus.read().to_uint();
	uint data = OutDataFromCanny.read().to_uint();

	if(IntEnable){
		ControlBus.write(0);
	}
	else {
		ControlBus.write("Z");
	}
	#if defined (_DEBUG_)
      cout << "@" << sc_time_stamp() << " >> ControlBus: " << bControl << endl;
	#endif
  }

  void  Canny_Edge_WRAP::Function_Canny_Edge_WRAP() {
    	AddrDecoded = AddressBus.read().to_uint() >> 28;
	
	// Signal Parcing
	bool		Canny_bWE = AddressBus.read()[1].to_bool();
	bool		Canny_bCE = AddressBus.read()[0].to_bool();

	// You can add something if you need.
	// ...
	// ...
	
	if(!bReset.read()){
		IntEnable = 0;
		Breq.write(0);
	}
	else if(IntEnable){
		if(AddrDecoded == 0x4) {// Address Decoding Matching
			// Insert your code here
			// for AddrRegRow, AddrRegCol, bWE, bCE, OPMode, bOPEnable, dReadReg, dWriteReg
			// ...
			// ...
			// Code Added by Chandrahas starts here, needs review 
			AddrRegRow.write(AddressBus.read().range(7,5).to_uint());
			AddrRegCol.write(AddressBus.read().range(4,2).to_uint());
			bWE.write(AddressBus.read().range(1,1).to_uint());
			bCE.write(AddressBus.read().range(0,0).to_uint());
			OPMode.write(AddressBus.read().range(26,24).to_uint());
			bOPEnable.write(AddressBus.read().range(27,27).to_uint());
			dReadReg.write(AddressBus.read().range(19,16).to_uint());
			dWriteReg.write(AddressBus.read().range(23,20).to_uint());
			// Code added by Chandrahas ends here
			if(!Canny_bCE && !Canny_bWE){
				InDataToCanny.write(DataBus.read());
				DataBus.write("ZZZZZZZZ");
			}
			else if(!Canny_bCE && Canny_bWE){
				DataBus.write(OutDataFromCanny.read());
			}
			else {
				DataBus.write("ZZZZZZZZ");
			}
		}
		else {
			IntEnable = 0;
			Breq.write(0);
			DataBus.write("ZZZZZZZZ");
		}
	}
	else {	// !IntEnable
		if(Bgnt) {
			IntEnable = 1;
			Breq.write(0);
		}
		else if(AddrDecoded == 0x4){
			IntEnable = 0;
			Breq.write(1);
		}
		else {
			IntEnable = 0;
			Breq.write(0);
		}
	}
        
	#if defined (_DEBUG_)
      cout << "@" << sc_time_stamp() << " >> IntEnable: " << IntEnable << endl;
	#endif
 }
