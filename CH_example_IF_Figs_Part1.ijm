macro "IF Figures Part1" {
	t = getTitle;

// find the position of the underscore in the filename
underscore = indexOf(t, '_');

// from the file name, grab the substring of everything thats before the dot
substr = substring(t, 0, underscore);
print(substr);

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

// juggle the channels!
run("Merge Channels...", "c1=y c2=g c3=b c4=r create");
rename(""+substr+"Merge");
saveAs("Tiff");}
