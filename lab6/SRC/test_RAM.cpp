#include "systemc.h"
#include "RAM.cpp"
#include <scv.h>

class Pkt_constraint : virtual public scv_constraint_base
{
	public:
	scv_smart_ptr<sc_uint<ADDR_WIDTH> > sAddr;
	scv_smart_ptr<sc_uint<DATA_WIDTH> > sInData;
	scv_smart_ptr<sc_uint<DATA_WIDTH> > sOutData;

	SCV_CONSTRAINT_CTOR(Pkt_constraint) {
		// define constraints
		// ...
		// ...
		// ...
		// Following Constraints defined by Chandrahas 
		// Constrain on Address Randomization
		SCV_CONSTRAINT(sAddr()<10); 
		// Constrain on InData Randomization
		SCV_CONSTRAINT(sInData() > 80);
	}
};

int sc_main (int argc, char* argv[]) {

	// Declare Input/Output Signals
  	sc_signal < sc_uint<ADDR_WIDTH> > 	tAddr ;
  	sc_signal < bool > 			tbWE;
  	sc_signal < bool > 			tbCE;
  	sc_signal < sc_uint<DATA_WIDTH> > 	tInData;
  	sc_signal < sc_uint<DATA_WIDTH> > 	tOutData;
  	
	int i = 0;
	
	// Connect the DUT(Design Under Test)
	RAM RAM_01("SIMULATION_RAM");
		RAM_01.InData(tInData);
        	RAM_01.Addr(tAddr);
		RAM_01.bCE(tbCE);
		RAM_01.bWE(tbWE);
		RAM_01.OutData(tOutData);

	// Open VCD(Value Change Dump) file
	sc_trace_file *wf = sc_create_vcd_trace_file("VCD_RAM");

	// Dump the desired signals
	sc_trace(wf, tInData, "strInData");
        sc_trace(wf, tAddr, "strAddr");
	sc_trace(wf, tbCE, "strbCE");
	sc_trace(wf, tbWE, "strbWE");
	sc_trace(wf, tOutData, "strOutData");

	// Initialize all variables
	tbCE.write(1);
	tbWE.write(1);
	sc_start(5);

	Pkt_constraint cPkt("Pkt_Test");	

        // Verification I
        cout << "------------------- Beginning of Verification I" << endl;
        for(i=0; i<5; i++){
          // Set writing mode
	  // ...
	  tbWE.write(0); // To keep the RAM in Writing Mode
          // Generate values of tInData & tAddr using "cPkt"
	  // ...
	  cPkt.next(); // Randomize as per the Constraints in cPkt
	  tAddr.write(cPkt.sAddr->read()); // Pass the Generated Address to the DUT
	  tInData.write(cPkt.sInData->read()); // Pass the Generated InData to the DUT
	  tbCE.write(0); // Enbable the Chip
	  sc_start(10); // Run the Simulation for 10 ns
	  tbCE.write(1); // Enough Simulating, its time to shut up the chip!! 	           
          // Set reading mode
	  // ...
	  tbWE.write(1); // To keep the RAM in Read Mode
	  tAddr.write(cPkt.sAddr->read()); // Pass the Generated Address to the DUT
	  tbCE.write(0); // Enbable the Chip
	  sc_start(10); // Run the Simulation for 10 ns 	  
          // Data read from tOutData to sOutData
	  // ...
	  cPkt.sOutData->write(tOutData.read()); // Data from tOutData to sOutData
	  tbCE.write(1); // Enough Simulating, its time to shut up the chip!!
          // Print statistics
	  // ...
	  cPkt.sAddr->print(std::cout);
	  cPkt.sInData->print(std::cout);
	  cPkt.sOutData->print(std::cout);
        }
        cout << "------------------- End of Verification I" << endl << endl;
        // Verification II
        // Following 3 lines of Code Added by Chandrahas
        typedef pair <sc_uint<8>,sc_uint<8> > data_range;
	scv_bag <data_range> sInData_dist; // For Distributing the value of the tInData
	sInData_dist.add(data_range(80,99),5); // To Generate InData from 80 to 99 with 5%
	sInData_dist.add(data_range(100,120),95);// To Generate InData from 100 to 120 with 95%
        cout << "------------------- Beginning of Verification II" << endl;
        for(i=0; i<5; i++){
          // Set writing mode
	  // ...
          tbWE.write(0); // To keep the RAM in Writing Mode
          // Set range distribution
	  // ...
          cPkt.sInData->set_mode(sInData_dist);
	  // Generate values of tInData  using "cPkt"
	  // ...
          cPkt.sInData->next();
          tAddr.write(cPkt.sAddr->read()); // Pass the Generated Address to the DUT
	  tInData.write(cPkt.sInData->read()); // Pass the Generated InData to the DUT
 	  tbCE.write(0); // Enbable the Chip
	  sc_start(10); // Run the Simulation for 10 ns
	  tbCE.write(1); // Enough Simulating, its time to shut up the chip!! 	           
          // Set reading mode
	  // ...
	  tbWE.write(1); // To keep the RAM in Read Mode
	  tAddr.write(cPkt.sAddr->read()); // Pass the Generated Address to the DUT
	  tbCE.write(0); // Enbable the Chip
	  sc_start(10); // Run the Simulation for 10 ns  	  
          // Data read from tOutData to sOutData
	  // ...
	  cPkt.sOutData->write(tOutData.read()); // Data from tOutData to sOutData
	  tbCE.write(1); // Enough Simulating, its time to shut up the chip!!
          // Print statistics
	  // ...
	  cPkt.sAddr->print(std::cout);
	  cPkt.sInData->print(std::cout);
	  cPkt.sOutData->print(std::cout);
        }
        cout << "------------------- End of Verification II" << endl;
        
	// Close trace file
	sc_close_vcd_trace_file(wf);
	
	return 0;	// Terminate simulation
}
