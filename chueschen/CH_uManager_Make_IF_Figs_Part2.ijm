
macro "uM IF Figures Part2" {
// this is part 2 of a simple example FIJI/ImageJ macro starts with a MicroManager .tif zStack 
//and quickly outputs and saves consistently scaled, pseudo-colored, and z-projected figure panels.

// First, run part 1, so you have a merged and scaled zStack (of multiple channels) open.
// In this example, you will manually look at that zStack and choose what z slices you want
// included in the Z project.
	
run("Z Project...");
t=getTitle;
print(t);

// now, make the combinations of channels that you want to output.  In my case, I wanted the 
// combinations below.  I'm also converting to the image type I want, and adding things
// like "tubGFP" to the end of the image names before I save them.
run("Make Substack...", "channels=1,3");
rename(""+t+"DNAtub");
run("RGB Color");
saveAs("Tiff");

selectWindow(t);
run("Make Substack...", "channels=2,3");
rename(""+t+"tubGFP");
run("RGB Color");
saveAs("Tiff");

selectWindow(t);
run("Make Substack...", "channels=2");
rename(""+t+"GFP");
run("8-bit");
saveAs("Tiff");

selectWindow(t);
run("Make Substack...", "channels=4");
rename(""+t+"NuMA");
run("8-bit");
saveAs("Tiff");

selectWindow(t);
run("RGB Color");
saveAs("Tiff");}

}