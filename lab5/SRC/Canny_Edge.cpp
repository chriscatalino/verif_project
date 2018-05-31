//===========================================
// Function : Canny Edge Detector
//===========================================
#include "Canny_Edge.h"

  // ----- Code Starts Here ----- 

void Canny_Edge::Write_Data() {
	if (!bCE.read() && !bWE.read()) {
		if(dWriteReg.read() == WRITE_REGX)
			regX[AddrRegRow.read()][AddrRegCol.read()] = InData.read();
		// Insert Your Code here //
		// ...
		// ...
		// ...
		// Code Added by Chandrahas, needs review
		else if(dWriteReg.read() == WRITE_REGY)
			regY[AddrRegRow.read()][AddrRegCol.read()] = InData.read();
			
		else if(dWriteReg.read() == WRITE_REGZ)
			regZ[AddrRegRow.read()][AddrRegCol.read()] = InData.read();
		// Code Added by Chandrahas ends here
		 
		// For debug	
		#if defined (_DEBUG_)
		cout << "@" << sc_time_stamp() << ":: Write: " << InData.read() << endl;
		#endif
	}
}

void Canny_Edge::Read_Data() {
	if (!bCE.read() && bWE.read()) {
		unsigned int dData;
		if(dReadReg.read() ==  REG_GAUSSIAN) 		dData = Out_gf;
		// Insert Your Code here //
		// ...
		// ...
		// ...
		// Code Added by Chandrahas, needs review
		else if(dReadReg.read() == REG_GRADIENT)	dData = Out_gradient;
		else if(dReadReg.read() == REG_DIRECTION)	dData = Out_direction;
		else if(dReadReg.read() == REG_NMS)		dData = regX[AddrRegRow.read()][AddrRegCol.read()];  
		else if(dReadReg.read() == REG_HYSTERESIS)	dData = Out_bThres;
		// Code Added by Chandrahas, ends here 
		OutData.write(dData);
		
		// For debug	
		#if defined (_DEBUG_)
		cout << "@" << sc_time_stamp() << ":: Read[" << AddrRegRow.read() << "]";
		cout << "[" << AddrRegCol.read() << "]: " << dData << endl;
		#endif
	}
}

void Canny_Edge::Initialize() {
	if(!rst_b.read()){
		// Initialize 5x5 matrix
		short tRow, tCol;
		for(tRow=0; tRow<5; tRow++){
			for(tCol=0; tCol<5; tCol++){
				regX[tRow][tCol] = 0;
			}
		}
		// Initialize Gaussian matrix
		gf[0][0]=2;	gf[0][1]=4;	gf[0][2]=5;	gf[0][3]=4;	gf[0][4]=2;
		gf[1][0]=4;	gf[1][1]=9;	gf[1][2]=12;	gf[1][3]=9;	gf[1][4]=4;
		gf[2][0]=5;	gf[2][1]=12;	gf[2][2]=15;	gf[2][3]=12;	gf[2][4]=5;
		gf[3][0]=4;	gf[3][1]=9;	gf[3][2]=12;	gf[3][3]=9;	gf[3][4]=4;
		gf[4][0]=2;	gf[4][1]=4;	gf[4][2]=5;	gf[4][3]=4;	gf[4][4]=2;

		// Sobel dx
		Sobeldx[0][0]=-1;	Sobeldx[0][1]=0;	Sobeldx[0][2]=1;	
		Sobeldx[1][0]=-2;	Sobeldx[1][1]=0;	Sobeldx[1][2]=2;
		Sobeldx[2][0]=-1;	Sobeldx[2][1]=0;	Sobeldx[2][2]=1;
		// Sobel dy
		Sobeldy[0][0]=1;	Sobeldy[0][1]=2;	Sobeldy[0][2]=1;	
		Sobeldy[1][0]=0;	Sobeldy[1][1]=0;	Sobeldy[1][2]=0;
		Sobeldy[2][0]=-1;	Sobeldy[2][1]=-2;	Sobeldy[2][2]=-1;
	}
}

void Canny_Edge::Apply_Operation(){
	if(!bOPEnable.read()){
		if (OPMode.read() == MODE_GAUSSIAN){
			int c,d;	
			float sum = 0;
			// CONVOLUTION
			for(c=-2; c<=2; c++){
				for(d=-2; d<=2; d++){
					sum = sum + (float) regX[c+2][d+2] * gf[c+2][d+2];
				}
       		}
			Out_gf = char(sum/159);
	    	}
		else if(OPMode.read() == MODE_SOBEL){
			int c,d;
			short Gx=0;		// X direction Component
			short Gy=0;		// Y direction Component
	
			// 1. input : Sobeldx, Sobeldy, regX(Gaussian Filtered Image)
			// 2. Output : Out_gradient(0~255), Out_direction(0, 45, 90, 135)
			// Insert Your Code here //
			// ...
			// ...
			// ...
			// Code added by Chandrahas, Needs furthur review
			// Perform Convolution with Gx and Gy
			// Loop to all the 3 values of the kernel
			for(c=-1;c<= 1;c++)
			{
				for(d=-1;d<=1;d++)
				{
					// Computer the Gx and Gy values per pixel 
					Gx = Gx + (short)(regX[c+1][d+1])*(short)(Sobeldx[c+1][d+1]);
					Gy = Gy + (short)(regX[c+1][d+1])*(short)(Sobeldy[c+1][d+1]);
				}
			}
			// Give a value to the output gradient and direction based on Gx and Gy values 
			// Computer with alpha = 2 
			
			if(((short)(abs(Gx)+abs(Gy))/2) >= 255.0)
				Out_gradient = 255;
			else if(((short)(abs(Gx)+abs(Gy))/2) <= 0.0)
				Out_gradient = 0;
			else 
				Out_gradient = (((abs(Gx)+abs(Gy)))/2);
				
			// step 1 in Arc tan Approximation
			if(Gy < 0)
			{
				// Update the values of Gx and Gy
				Gx = (-1)*Gx;
				Gy = (-1)*Gy;
			}
			// Step2 in Arc tan Approximation, if Gx is greater than equal to zero 
			if(Gx >= 0)
			{
				// assign the value to the Output_direction based on conditions satisified
				if(Gy <= 0.4*Gx)
				{
					Out_direction = 0;
				}
				
				else if((Gy > 0.4*Gx) && (Gy <= 2.4*Gx))
				{
					Out_direction = 45;
				}
				
				else if(Gy > 2.4*Gx)
				{
					Out_direction = 90;
				}
			}
			// if Gx is less than zero
			else
			{
				// assign the value to the Output_direction based on conditions satisified
				if(Gy <= -0.4*Gx)
				{
					Out_direction = 0;
				}
				
				else if((Gy > -0.4*Gx) && (Gy <= -2.4*Gx))
				{
					Out_direction = 135;
				}
				
				else if(Gy > -2.4*Gx)
				{
					Out_direction = 90;
				}	
			}
		}
		else if(OPMode.read() == MODE_NMS){
			// 1. input : regX(Gradient Image), regY(Direction Image)
			// 2. Output : regX(Gradient Image)
			// Insert Your Code here //
			// ...
			// ...
			// ...
			// Code Added by Chandrahas, Needs review
			if(regY[1][1] == 0)
			{
				// M_A = regX[1][0]
				// M_B = regX[1][2]
				if((regX[1][1] >= regX[1][0]) && (regX[1][1] >= regX[1][2]))
				{
					// Make M_A, M_C zeros !!
					regX[1][0] = 0;
					regX[1][2] = 0;
				}
				
				else if((regX[1][0] > regX[1][1]) || (regX[1][2] > regX[1][1]))
				{
					// Make M_C zero ! 
					regX[1][1] = 0;
				}			
			}
			
			else if(regY[1][1] == 45)
			{
				// M_A = regX[0][2]
				// M_B = regX[2][0]
				if((regX[1][1] >= regX[0][2]) && (regX[1][1] >= regX[2][0]))
				{
					// Make M_A, M_C zeros !!
					regX[0][2] = 0;
					regX[2][0] = 0;
				}
				
				else if((regX[0][2] > regX[1][1]) || (regX[2][0] > regX[1][1]))
				{
					// Make M_C zero ! 
					regX[1][1] = 0;
				}
			}
			
			else if(regY[1][1] == 90)
			{
				// M_A = regX[0][1]
				// M_B = regX[2][1]
				if((regX[1][1] >= regX[0][1]) && (regX[1][1] >= regX[2][1]))
				{
					// Make M_A, M_C zeros !!
					regX[0][1] = 0;
					regX[2][1] = 0;
				}
				
				else if((regX[0][1] > regX[1][1]) || (regX[2][1] > regX[1][1]))
				{
					// Make M_C zero ! 
					regX[1][1] = 0;
				}
			}
			
			else if(regY[1][1] == 135)
			{
				// M_A = regX[0][0]
				// M_B = regX[2][2]
				if((regX[1][1] >= regX[0][0]) && (regX[1][1] >= regX[2][2]))
				{
					// Make M_A, M_C zeros !!
					regX[0][0] = 0;
					regX[2][2] = 0;
				}
				
				else if((regX[0][0] > regX[1][1]) || (regX[2][2] > regX[1][1]))
				{
					// Make M_C zero ! 
					regX[1][1] = 0;
				}
			}
			// Code Added by Chandrahas ends here 

		}
		else if(OPMode.read() == MODE_HYSTERESIS){
			// You should use these two threshold values.
			unsigned short dThresHigh = 20;
			unsigned short dThresLow = 5;

			// 1. input : regX(Gradient Image), regY(Direction Image), regZ(On/Off Image)
			//            regZ[][]==1: On / regZ[][]==0: Off
			// 2. Output : Out_bThres (0(Off) or 1(On))
			// Insert Your Code here //
			// ...
			// ...
			// ...
			// Code Added by Chandrahas, Needs review
			int c,d; // row and column variable for looping purposes
			if(regX[1][1] >= dThresHigh)
			{
				// The Pixel is Strong Pixel, So the Output_bThres is 1 
				Out_bThres = 1;
			}
			
			else if(regX[1][1] <= dThresLow)
			{
				// The Pixel is a Weak Pixel, So the Output_bThres is 0
				Out_bThres = 0;
			}
			else
			{
				// The Pixel is a candidate pixel
				// Check the neighbouring pixels based on edge direction(Differential direction)
				if(regY[1][1] == 0)
				{
					// neighbours in 0 angle direction --> regX[0][1], regX[2][1]
					if((regZ[0][1]==1) || (regZ[2][1]==1))
					{
						// Connected to a strong pixel, so the output is strong pixel
						Out_bThres = 1;
					}
					else if((regX[0][1] >= dThresHigh) || (regX[2][1] >= dThresHigh))
					{
						Out_bThres = 1;	
					}
					else
					{
						// The pixel should be considered as a weak pixel
						Out_bThres = 0;
					} 
				}
				
				else if(regY[1][1] == 45)
				{
					// neighbours in 45 angle direction --> regX[0][0], regX[2][2]
					if((regZ[0][0]==1) || (regZ[2][2]==1))
					{
						// Connected to a strong pixel, so the output is strong pixel
						Out_bThres = 1;
					}
					else if((regX[0][0] >= dThresHigh) || (regX[2][2] >= dThresHigh))
					{
						Out_bThres = 1;	
					}
					else
					{
						// The pixel should be considered as a weak pixel
						Out_bThres = 0;
					} 
					 
				}
				
				else if(regY[1][1] == 90)
				{
					// neighbours in 90 angle direction --> regX[1][0], regX[1][2]
					if((regZ[1][0]==1) || (regZ[1][2]==1))
					{
						// Connected to a strong pixel, so the output is strong pixel
						Out_bThres = 1;
					}
					
					else if((regX[1][0] >= dThresHigh) || (regX[1][2] >= dThresHigh))
					{
						Out_bThres = 1;	
					}
					
					else
					{
						// The pixel should be considered as a weak pixel
						Out_bThres = 0;
					}  
				}
				
				else if(regY[1][1] == 135)
				{
					// neighbours in 135 angle direction --> regX[2][0], regX[0][2]
					if((regZ[2][0]==1) || (regZ[0][2]==1))
					{
						// Connected to a strong pixel, so the output is strong pixel
						Out_bThres = 1;
					}
					
					else if((regX[2][0] >= dThresHigh) || (regX[0][2] >= dThresHigh))
					{
						Out_bThres = 1;	
					}
					
					else
					{
						// The pixel should be considered as a weak pixel
						Out_bThres = 0;
					} 
				}
			}
			// Code Added by Chandrahas ends here 

		}
	}
}
