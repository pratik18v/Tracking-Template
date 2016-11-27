# Tracking-Template

The code is the implementation of basic Lucas-Kanade template tracking method for strictly translation motion.

**Files included: ** <br />
1. hw4.m : Demo code to run the implemented algorithm. Required data and generated output is available in the repo as CarSequence.zip and output.zip. <br />
2. trackTemplate.m : The main function that takes as input string containing path to the frames in which template has to be 
tracked and the template image. The function creates a new directory 'output' in which it saves all the frames with bounding
boxes drawn around the tracked template. It also saves a cordinates.txt file which has the coordinates of the corners of the
bounding box for each frame.

## **Results**

**Template Image** <br />
<img src="https://github.com/pratik18v/Tracking-Template/blob/master/car_template.jpg">

**Some frames with tracked template** <br />
<img src="https://github.com/pratik18v/Tracking-Template/blob/master/frame00304.jpg">
<img src="https://github.com/pratik18v/Tracking-Template/blob/master/frame00320.jpg">
<img src="https://github.com/pratik18v/Tracking-Template/blob/master/frame00350.jpg">
<img src="https://github.com/pratik18v/Tracking-Template/blob/master/frame00400.jpg">
