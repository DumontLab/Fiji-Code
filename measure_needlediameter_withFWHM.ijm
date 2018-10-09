maniplength = "long"
date = "20180622_cell020"
path = "/Users/poojasuresh/Documents/iPQB/dumontdata_analysis/" + maniplength + "term_manip/" + date + "/"

run("Set Measurements...", "centroid fit shape feret's display redirect=None decimal=3");

run("Duplicate...", "title=duplicate");

run("Duplicate...", "title=threshold");
selectWindow("threshold");

setThreshold(358, 65535);

run("Analyze Particles...", "  show=Outlines display exclude clear add");

X=getResult("X", 0);
Y=getResult("Y", 0);

LineLength=40;

dx=LineLength/2;
dy=LineLength/2;


selectWindow("duplicate");
//horizontal
makeLine(X-dx,Y,X+dx,Y);
run("Add Selection...");
//runMacro("/Users/poojasuresh/Documents/fiji_macros_homemade/saveintensityprofile.ijm");
//saveAs("Results", path + "profile_needle_1.csv");
//run("Find Peaks", "min._peak_amplitude=100 min._peak_distance=0 min._value=500 max._value=[] exclude list");
//saveAs("Results", path + "profile_needle_1.csv");
runMacro("/Applications/Fiji.app/macros/FWHM_Line.ijm");

selectWindow("duplicate");
//vertical
makeLine(X,Y-dy,X,Y+dy);
run("Add Selection...");
//runMacro("/Users/poojasuresh/Documents/fiji_macros_homemade/saveintensityprofile.ijm");
//saveAs("Results", path + "profile_needle_2.csv");
//run("Find Peaks", "min._peak_amplitude=100 min._peak_distance=0 min._value=500 max._value=[] exclude list");
//saveAs("Results", path + "profile_needle_2.csv");
runMacro("/Applications/Fiji.app/macros/FWHM_Line.ijm");

selectWindow("duplicate");
//diagonal 1
makeLine(X+dx,Y-dy,X-dx,Y+dy);
run("Add Selection...");
//runMacro("/Users/poojasuresh/Documents/fiji_macros_homemade/saveintensityprofile.ijm");
//saveAs("Results", path + "profile_needle_3.csv");
//run("Find Peaks", "min._peak_amplitude=100 min._peak_distance=0 min._value=500 max._value=[] exclude list");
//saveAs("Results", path + "profile_needle_3.csv");
runMacro("/Applications/Fiji.app/macros/FWHM_Line.ijm");

selectWindow("duplicate");
//diagonal 2
makeLine(X-dx,Y-dy,X+dx,Y+dy);
run("Add Selection...");
//runMacro("/Users/poojasuresh/Documents/fiji_macros_homemade/saveintensityprofile.ijm");
//saveAs("Results", path + "profile_needle_4.csv");
//run("Find Peaks", "min._peak_amplitude=100 min._peak_distance=0 min._value=500 max._value=[] exclude list");
//saveAs("Results", path + "profile_needle_4.csv");
runMacro("/Applications/Fiji.app/macros/FWHM_Line.ijm");

saveAs("Text", path + "FWHM.csv");
