# ECEN468
This repo contains the lab files for the ECEN468 course offered during Spring 2018. If you are a TAMU student enrolled in future
offerings of this course.Please DO NOT copy the code for your Lab Exercises, you  will be violating [Aggie Code of Honor](https://aggiehonor.tamu.edu/Rules-and-Procedures/Rules/Honor-System-Rules) if you do so. In case of any queries, please drop a mail to [chandrahas996@gmail.com](mailto:chandrahas996@gmail.com) or [chandrahas996@tamu.edu](mailto:chandrahas996@tamu.edu).

### About the Code
The final aim of this lab is to implement Edge Detection System with a .bmp image as input, the system has following components
 - SRAM Memory
 - Simple Bus Interface with Bus Arbiter
 - Image Processing System
  - Image Smoothing Element for decreasing the sharpness of the image.
  - FFT Computing Element
  - X,Y Gradient Computing Element
  - Hysteresis Computing Element for eliminating redundant features
  - Edge Detector Computing Element for detecting prominent edges
  
  ### High Level Idea:
  The input bitmap image gets read by Handler,the intensity values get stored in SRAM memory. For every operation the the image intensities are read from the memory and kept on the bus, The Bus Connects the memory to the Image Processing System, where the image processing operations are performed on the image intensitites and the results are kept on the bus and are written back the memory. In this we perform all the image processing operations with image intensities, after all the operations are performed, we have the result image intensities in the memory. A Handler takes those intensities and encodes them into .bmp image which is placed in the same directory. For controlling what operation is performed in Image processing system, an input is given from the testbench. The above design in implemented in both System C and Verilog. 
. 
