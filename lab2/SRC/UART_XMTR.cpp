//===========================================
// Function : UART Transmitter
//===========================================
#include "UART_XMTR.h"

  // ----- Code Starts Here ----- 

  void UART_XMTR::Send_bit() 
  {
  	switch(IntState)
	{
		case STATE_IDLE:
			// check if Load_XMT_datareg is asserted or not
			if(Load_XMT_datareg.read()==1) 
			{
				XMT_datareg = Data_Bus.read(); // Copy off the data from Data Bus to XMT_datareg
				cout << "@ " << sc_time_stamp() << " INFO: The Data read from the Data Bus is " << Data_Bus.read() << "\n";
			}
			NextIntState = STATE_IDLE; //  Make the state machine to go to idle state, until  Byte_ready is asserted
			// check if the byte_ready is asserted or not
			if(Byte_ready.read()==1)
			{
				XMT_shftreg = (XMT_datareg.range(7,0), '1'); // transfer the data from datareg to shift reg along with the start bit
				cout << "@ " << sc_time_stamp() << " INFO: The Data from the Data Register has been loaded to shift register" << endl;
				NextIntState = STATE_WAITING; // send the state machine to waiting state
			}
		break;
		
		case STATE_WAITING:
			// check if T_Byte is asserted or not
			if(T_byte.read()==1)
			{
				bit_count = 0; // keep the bit count to zero before we start sending out the bits
				NextIntState = STATE_SENDING; // send the state machine to STATE_SENDING					
			}
			else
			{
				NextIntState = STATE_WAITING; // keep waiting in STATE_WAITING until T_Byte is asserted				
			}
		break;
		
		case STATE_SENDING:
			// check if the count is less than 9
			if(bit_count < 9)
			{
				if(bit_count==0)
				{
					XMT_shftreg[0] = 0; // update the start bit
				}
				else
				{
					XMT_shftreg =('1',XMT_shftreg.range(8,1)); // update the shift register
				}
				bit_count++;
				cout << "@ " << sc_time_stamp() << " INFO:" << "Bit Count has changed to " << bit_count << "\n";
				cout << "@ " << sc_time_stamp() << " INFO:" << "The Bit to be serially sent is " << XMT_shftreg.range(0,0) << "\n";
								
				NextIntState = STATE_SENDING; // stay in sending stage and shift all the bits off the shift register!
			}
			else
			{
				XMT_shftreg = 0x1ff; // update the XMT_Shftreg to keep sending 1's
				NextIntState = STATE_IDLE; // send the state machine back to idle state
			} 
            	break;
        	default:
        	{
        		XMT_shftreg = 0x1ff; // update the XMT_Shftreg to keep sending 1's
			NextIntState = STATE_IDLE; // send the state machine back to idle state 
        	}
	}	
	Serial_out.write(XMT_shftreg[0]);
  }

  void UART_XMTR::Initialize() 
  {
  	if(!rst_b.read())
  	{
		IntState = STATE_IDLE;	
		XMT_shftreg = 0x1ff;
		bit_count = 0;
	}
	
	else 
	{
		IntState = NextIntState;
	}
  }
