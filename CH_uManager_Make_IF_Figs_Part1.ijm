macro "uM IF Figures Part1" {
// this is part 1 of a simple example FIJI/ImageJ macro starts with a MicroManager .tif zStack 
//and quickly outputs and saves consistently scaled, pseudo-colored, and z-projected figure panels.

// First, open your .tif stack of interest in FIJI.  Then run this.

t = getTitle;

// find the position of the '.tif' in the filename
suffix = indexOf(t, '.tif');

// from the file name, grab the substring of everything thats before the dot
substr = substring(t, 0, suffix);
print(substr);

// split the stack into substacks, one for each channel
run("Make Substack...", "channels=1");
selectWindow(t);
run("Make Substack...", "channels=2");
selectWindow(t);
run("Make Substack...", "channels=3");
selectWindow(t);
run("Make Substack...", "channels=4");

// now, set the min and max (to what you've chosen for this experiment/figure) and pseudo-color channels
selectWindow(""+substr+"-1.tif");
run("Blue");
rename("b");
run("Brightness/Contrast...");
setMinAndMax(50, 4000);
selectWindow(""+substr+"-2.tif");
run("Green");
rename("g");
run("Brightness/Contrast...");
setMinAndMax(350, 6000);
selectWindow(""+substr+"-3.tif");
run("Red");
rename("r");
run("Brightness/Contrast...");
setMinAndMax(80, 4000);
selectWindow(""+substr+"-4.tif");
run("Magenta");
rename("m");
run("Brightness/Contrast...");
setMinAndMax(0, 30000);

// merge the channels and choose a directory in which to save your merged stack
run("Merge Channels...", "c1=b c2=g c3=r c4=m create");
selectWindow("Composite");
rename(""+substr+"Merge");
saveAs("Tiff");}