macro "uM IF Figures Part1" {
	t = getTitle;

// find the position of the '.tif' in the filename
suffix = indexOf(t, '.tif');

// from the file name, grab the substring of everything thats before the dot
substr = substring(t, 0, suffix);
print(substr);

run("Make Substack...", "channels=1");
selectWindow(t);
run("Make Substack...", "channels=2");
selectWindow(t);
run("Make Substack...", "channels=3");
selectWindow(t);
run("Make Substack...", "channels=4");

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

// juggle the channels!
run("Merge Channels...", "c1=b c2=g c3=r c4=m create");
selectWindow("Composite");
rename(""+substr+"Merge");
saveAs("Tiff");}