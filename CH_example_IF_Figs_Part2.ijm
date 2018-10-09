
macro "IF Figures Part2" {
run("Z Project...");
t=getTitle;
print(t);
saveAs("Tiff");

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
