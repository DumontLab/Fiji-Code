//Designed to pull metadata from image stacks that can be read from bioformats (ome.tiff, stk, nd) and make a timestamp overlay
run("Bio-Formats Macro Extensions");
//Starts bioformats extension that can pull metadata from an image
//////// Dialog box
Dialog.create("Timestamp Properties");
//initializes dialog box
Dialog.addChoice("Time format:", newArray("hr:min:sec", "min:sec", "sec"));
Dialog.addChoice("Destination stack:", newArray("Original", "Z-projection","RGB", "Z-Projection + RGB"));
Dialog.addNumber("t = 0 timepoint", 1);
Dialog.addNumber("Offset (seconds)", 0);
//adds options for the format of timestamp, the type of image you want the timestamps to fit on, and the point set to be t = 0
Dialog.show();
time_format = Dialog.getChoice;
destination = Dialog.getChoice;;
t_0 = Dialog.getNumber();
offset = Dialog.getNumber();
//Gets choices
//////Get raw time values
id = getInfo("image.directory") + getInfo("image.filename");
//Gets filename of open movie
Ext.setId(id);
//run bioformats on open image
Ext.getImageCount(imageCount);
//get the number of total images
deltaT = newArray(imageCount);
for (no = 0; no < imageCount; no++) {
 Ext.getPlaneTimingDeltaT(deltaT[no], no);
 }
// Get time values for each image (all dimensions)
Ext.getSizeZ(z);
Ext.getSizeC(c);
Ext.getSizeT(t);
//Gets image dimensions (c, z, t)
planes_per_time = z * c;
//gets total number of planes for each timepoint
first_times = newArray(t);
first_planes = newArray(t);
//initializes arrays which will contain the image number (out of total) 
//for the first frame in a timepoint (first plane, first color) and the time for that plane
temp = 0
for (i = 0; i < t; i++)
{
  first_planes[i] = temp;
  //gets plane number
  first_times[i] = deltaT[temp];
  //gets time for that plane
  temp = temp + planes_per_time;
  // jumps to next timepoint, skipping all z planes and frames 
}
t_0value = first_times[t_0-1]
//gets the time for the designated t=0 frome (adjusts to account for indexing at 0)
for (i = 0; i < t; i++)
{
  first_times[i] = first_times[i] - t_0value + offset;
  //adjusts all times in first_time array based on the designated t=0 frame and the desired offset
}
time_string = newArray(t)
//initializes array with the time strings
if (time_format == "sec"){
  for (i = 0; i < t; i++){
  time_string[i] = toString(first_times[i]);
  //Makes a seconds-based timestamp
  }
} else if (time_format == "hr:min:sec"){
  
  for (i = 0; i < t; i++)
  
  
  
  {
  time = first_times[i];
  if (time < 0){
  sign = "-";
  }
  else {
    sign = " ";
    
  }
//Determines whether time is positive or negative and adds the appropriate sign (or not)
abstime = abs(time);
hrs_num = floor(abstime/3600);
//Gets the number of hours (rounded down) from the number of seconds
hrs = toString(hrs_num);
if (hrs_num < 10) {
  hrs = "0"+hrs;
}
//Makes the hours into a string, adds a 0 to it if it's a single digit
rem_min = abstime%3600;
//Gets the number of leftover seconds over the rounded-down hours
min_num = floor(rem_min/60);
//Gets the rounded down number of minutes.
min = toString(min_num);
if (min_num < 10) {
  min = "0"+min;
}
//Makes the minutes into a string, adds a 0 to it if it's a single digit
rem_sec = rem_min%60;
//Gets the number of leftover seconds over the rounded-down hours and minutes
sec_num = round(rem_sec);
//rounds the milliseconds out
sec = toString(sec_num);
if (sec_num < 10) {
  sec = "0" + sec;
}
//Makes the seconds into a string, adds a 0 to it if it's a single digit
temp_string = sign + hrs + ":" + min + ":" + sec;
//Concatenates strings
time_string[i] = temp_string;
}
} else if (time_format == "min:sec"){
    
    
    for (i = 0; i < t; i++)
  {
    time = first_times[i];
    
if (time < 0){
  sign = "-";
  }
  else {
    sign = " ";
  }
//Gets the sign of the time
abstime = abs(time);
min_num = floor(abstime/60);
//gets the rounded down number of minutes
min = toString(min_num);
if (min_num < 10) {
  min = "0"+min;
}
//Makes the number of minutes into a string and adds a 0 if single digit
rem_sec = abstime%60;
//gets the remaining number of seconds
sec_num = round(rem_sec);
sec = toString(sec_num);
if (sec_num < 10) {
  sec = "0" + sec;
}
//Makes the number of seconds into a string and adds a 0 if single digit
temp_string = sign + min + ":" + sec;
time_string[i] = temp_string;
//Concatenates strings
  }
  
}
if (destination == "Z-projection")
{
  run("Z Project...");
}
//makes a z-projection if you want the stacks on that
if (destination == "Z-projection + RGB")
{
  run("Z Project...");
  run("RGB Color", "frames keep");
}
if (destination == "RGB")
{
  run("RGB Color", "slices frames keep");
}
timepoint = 0;
for (i = 0; i < t; i++){
setSlice(i+1);
  s = time_string[i];
  run("Set Label...", "label=&s");
}
//sets the labels on each frame in the destination stake. The overlay can be properly ported onto any stack of the same dimensionality
  
