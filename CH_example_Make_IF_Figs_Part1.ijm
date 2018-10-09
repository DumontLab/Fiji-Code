macro "IF Figures Part1" {
// this is part 1 of a simple example FIJI/ImageJ macro starts with separate MetaMorph zStacks (one for each channel)
//and quickly outputs and saves consistently scaled, pseudo-colored, and z-projected figure panels.

// First, open your stack of interest in FIJI.  Then run this.
	t = getTitle;

// find the position of the underscore in the filename
underscore = indexOf(t, '_');

// from the file name, grab the substring of everything thats before the dot
substr = substring(t, 0, underscore);
print(substr);

// now, set the min and max (to what you've chosen for this experiment/figure) and pseudo-color channels
selectWindow(""+substr+"_w1Conf 405 20-.TIF");
run("Yellow");
rename("y");
run("Brightness/Contrast...");
setMinAndMax(50, 1500);
selectWindow(""+substr+"_w2Conf 488 20-.TIF");
run("Green");
rename("g");
run("Brightness/Contrast...");
setMinAndMax(250, 2500);
selectWindow(""+substr+"_w3Conf 561 20-.TIF");
run("Blue");
rename("b");
run("Brightness/Contrast...");
setMinAndMax(80, 1600);
selectWindow(""+substr+"_w4Conf 647 20-.TIF");
run("Red");
rename("r");
run("Brightness/Contrast...");
setMinAndMax(800, 5000);

// merge the channels and choose a directory in which to save your merged stack
run("Merge Channels...", "c1=y c2=g c3=b c4=r create");
rename(""+substr+"Merge");
saveAs("Tiff");}
