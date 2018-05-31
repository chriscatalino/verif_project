#include "UART_XMTR_WRAP.h"
#include "UART_XMTR.h"
// #include "SRAM.cpp" // Commented by Chandrahas for compatibility with the Lab1 !!
#include "RAM.cpp"
#include "SRAM_WRAP.h"
#include "Arbiter.h"
#include "test.h"

int sc_main (int argc, char* argv[]) {

	// Input/Output Signal ---------------------------------

	// Wrapper(Decoder) - Arbiter
	sc_signal < bool >		BREQ2, BREQ1, BREQ0;
	sc_signal < bool >	      BGNT2, BGNT1, BGNT0;

	// Wrapper(Decoder) of SRAM - SRAM
	sc_signal_rv < WORD_SIZE >	DataToSRAM;
	sc_signal_rv < WORD_SIZE >	DataFromSRAM;
	sc_signal_rv < WORD_SIZE >	DataToUART;
	sc_signal_rv < ADDR_SIZE >	AddrToSRAM;
	sc_signal < bool > 		bCE, bWE;
	
	// Wrapper(Decoder) of UART - UART
	sc_signal < bool >		Load_XMT_datareg;
	sc_signal < bool > 		Byte_ready;
	sc_signal < bool >		T_byte;

	// UART - Test-Bench
	sc_signal < bool >		Serial_out;

	// Test-Bench - Wrapper
	sc_signal_rv < 1 >		ControlBus;
	sc_signal_rv < 8 >	      DataBus;
	sc_signal_rv < 32 >	      AddressBus;

	sc_signal < bool > 		rst_b;
	sc_clock clk("clk", 1, SC_NS);
	
	// Report Handler
	sc_report_handler::set_actions(SC_ID_VECTOR_CONTAINS_LOGIC_VALUE_, SC_DO_NOTHING);
	sc_report_handler::set_actions(SC_ID_LOGIC_Z_TO_BOOL_, SC_DO_NOTHING);

	// Connect your UART_XMTR module
	// ...
	// ...
	// Needs Review by Chandrahas, Check Data Bus is connected or not
	UART_XMTR UART_XMTR_01("UART_XMTR Simulation");
	UART_XMTR_01.Load_XMT_datareg(Load_XMT_datareg);
	UART_XMTR_01.Byte_ready(Byte_ready);
	UART_XMTR_01.T_byte(T_byte);
	UART_XMTR_01.rst_b(rst_b);
	UART_XMTR_01.clk(clk);
	UART_XMTR_01.Serial_out(Serial_out);
	UART_XMTR_01.Data_Bus(DataToUART);
	
	// Connect your UART_XMTR_WRAP module
	// ...
	// ...
	// Needs Review by Chandrahas
	UART_XMTR_WRAP UART_XMTR_WRAP_01("UART_XMTR_WRAP Simulation");
	UART_XMTR_WRAP_01.Load_XMT_datareg(Load_XMT_datareg);
	UART_XMTR_WRAP_01.Byte_ready(Byte_ready);
	UART_XMTR_WRAP_01.T_byte(T_byte);
	UART_XMTR_WRAP_01.AddressBus(AddressBus);
	UART_XMTR_WRAP_01.ControlBus(ControlBus);
	UART_XMTR_WRAP_01.DataBus(DataBus);
	UART_XMTR_WRAP_01.Breq(BREQ2);
	UART_XMTR_WRAP_01.Bgnt(BGNT2);
	UART_XMTR_WRAP_01.bReset(rst_b);
	UART_XMTR_WRAP_01.clk(clk);
	UART_XMTR_WRAP_01.Data_Bus(DataToUART);
	
	// Connect your SRAM module
	// ...
	// ...
	// Needs Review by Chandrahas
	RAM SRAM_01("SRAM Simulation");
	SRAM_01.bCE(bCE);
	SRAM_01.bWE(bWE);
	SRAM_01.OutData(DataFromSRAM);
	SRAM_01.InData(DataToSRAM);
	SRAM_01.Addr(AddrToSRAM);
	
	// Connect your SRAM_WRAP module
	// ...
	// ...
	// Needs Review by Chandrahas
	SRAM_WRAP SRAM_WRAP_01("SRAM Simulation");
	SRAM_WRAP_01.bCE(bCE);
	SRAM_WRAP_01.bWE(bWE);
	SRAM_WRAP_01.OutData(DataFromSRAM);
	SRAM_WRAP_01.InData(DataToSRAM);
	SRAM_WRAP_01.Addr(AddrToSRAM);
	SRAM_WRAP_01.AddressBus(AddressBus);
	SRAM_WRAP_01.ControlBus(ControlBus);
	SRAM_WRAP_01.DataBus(DataBus);
	SRAM_WRAP_01.Bgnt(BGNT1);
	SRAM_WRAP_01.Breq(BREQ1);
	SRAM_WRAP_01.clk(clk);
	SRAM_WRAP_01.bReset(rst_b);
	
	// Connect your Arbiter module
	// ...
	// ...
	// Needs Review by Chandrahas
	Arbiter Arbiter_01("Arbiter Simulation");
	Arbiter_01.BREQ2(BREQ2);	
	Arbiter_01.BREQ1(BREQ1);
	Arbiter_01.BREQ0(BREQ0);
	Arbiter_01.BGNT2(BGNT2);
	Arbiter_01.BGNT1(BGNT1);
	Arbiter_01.BGNT0(BGNT0);
	
	// Connect your Test-Bench module
	// ...
	// ...
	// Needs Review by Chandrahas
	test test_01("Test Module Instantiation");
	test_01.clk(clk);
	test_01.bReset(rst_b);
	test_01.Serial_out(Serial_out);
	test_01.Breq(BREQ0);
	test_01.Bgnt(BGNT0);
	test_01.DataBus(DataBus);
	test_01.ControlBus(ControlBus);
	test_01.AddressBus(AddressBus);
	
	// Open VCD file
	sc_trace_file *wf = sc_create_vcd_trace_file("wave");

	// Dump the desired signals
	sc_trace(wf, rst_b, "rst_b");
	sc_trace(wf, clk, "clk");
	
	sc_trace(wf, Load_XMT_datareg, "Load_XMT_datareg");
	sc_trace(wf, Byte_ready, "Byte_ready");
	sc_trace(wf, T_byte, "T_byte");
	sc_trace(wf, DataToUART, "DataToUART");
	sc_trace(wf, Serial_out, "Serial_out");

	sc_trace(wf, DataToSRAM, "DataToSRAM");
	sc_trace(wf, DataFromSRAM, "DataFromSRAM");
	sc_trace(wf, AddrToSRAM, "AddrToSRAM");
	sc_trace(wf, bCE, "bCE");
	sc_trace(wf, bWE, "bWE");

	sc_trace(wf, BREQ0, "BREQ0");
	sc_trace(wf, BREQ1, "BREQ1");
	sc_trace(wf, BREQ2, "BREQ2");
	sc_trace(wf, BGNT0, "BGNT0");
	sc_trace(wf, BGNT1, "BGNT1");
	sc_trace(wf, BGNT2, "BGNT2");
	
	sc_trace(wf, DataBus, "DataBus");
	sc_trace(wf, AddressBus, "AddressBus");
	sc_trace(wf, ControlBus, "ControlBus");

	// Time to simulate
	// Simulate until it meets sc_stop() if sc_start(-1) or sc_start()
	//sc_start(1000, SC_NS);	// Simulate for 1000ns
	sc_start();

	// Close the dump file
	sc_close_vcd_trace_file(wf);
	
	return 0;	// Terminate simulation
}
