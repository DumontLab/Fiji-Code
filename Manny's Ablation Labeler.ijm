// Manny's Ablations Labeler
// Similar to Manny's Image Labeler with added ablation features
// Allows you to input XY coordinates for up to 3 spots of ablation and draws an "X" onto your movie
// tip: use the PointAndShoot Log exported from µManager to get XY coordinates
// Requires an open movie and setting your directory 

//run("Bio-Formats Importer");
//run("Remove Overlay"); 
//run("Revert");

//SET DIRECTORY
saveDirectory = "/Users/manuela/Desktop/processed/";
getDimensions(width, height, channels, slices, frames);

Dialog.create("Manny's Ablations Labeler");
Dialog.addString("Image title",replace(getTitle(),".tif",""),80);
Dialog.addString("Saving directory", saveDirectory,80);
Dialog.addNumber("pixelToMicronRatio", 0.110);
Dialog.addCheckbox("Time series?", true);
Dialog.addChoice("Format", newArray("0", "00:00","00:00:00"),"00:00");
Dialog.addString("Time text", "min:sec");
Dialog.addNumber("Time interval", 7);
Dialog.addNumber("What frame is time 0 (aka ablation)?", 10);
Dialog.addNumber("Coordinates of ablation: X1", 722);
Dialog.addNumber("Coordinates of ablation: Y1", 817);
Dialog.addNumber("Coordinates of ablation: X2", 725);
Dialog.addNumber("Coordinates of ablation: Y2", 823);
Dialog.addNumber("Coordinates of ablation: X3", 727);
Dialog.addNumber("Coordinates of ablation: Y3", 825);
Dialog.addCheckbox("Z series?", false);
Dialog.addNumber("Z-project which channel? This image has "+channels+" channels.", 3);
Dialog.addNumber("Starting at what z slice?", 1);
Dialog.addNumber("Ending at what z slice?", 47);
Dialog.addChoice("What type of projection?", newArray("Average Intensity","Max Intensity","Min Intensity","Sum Slices","Standard Deviation","Median"), "Max Intensity");
Dialog.show();
imageTitle= Dialog.getString();
saveDirectory= Dialog.getString();
pixelToMicronRatio= Dialog.getNumber();
timeseries = Dialog.getCheckbox();
timeformat = Dialog.getChoice();
timetext = Dialog.getString();
timeinterval= Dialog.getNumber();
t0 = Dialog.getNumber();
x1 = Dialog.getNumber();
y1 = Dialog.getNumber();
x2 = Dialog.getNumber();
y2 = Dialog.getNumber();
x3 = Dialog.getNumber();
y3 = Dialog.getNumber();
zseries = Dialog.getCheckbox();
zchannel = Dialog.getNumber();
zstart = Dialog.getNumber();
zend = Dialog.getNumber();
ztype = Dialog.getChoice();

//pixelToMicronRatio = 0.105 //Scope 1 100X
//pixelToMicronRatio = 0.110 //Scope 2 60X
//pixelToTime = 60 //sec per frame in kymograph

//Time series
if (timeseries == true)
	run("Label...","format="+timeformat+" starting="+(1-t0)*timeinterval+" interval="+timeinterval+" x=10 y=20 font=30 text=["+timetext+"] use");

//Scale bar
run("Set Scale...", "distance=1 known="+pixelToMicronRatio+" pixel=1 unit=microns global");
run("Scale Bar...", "width=5 height=10 thickness=5 font=30 color=White background=None location=[Lower Right] horizontal bold overlay");

//Adds Xs for ablation
Overlay.drawString("X", x1, y1, 0.0);
Overlay.drawString("X", x2, y2, 0.0);
Overlay.drawString("X", x3, y3, 0.0);
run("To ROI Manager");
roiManager("Show All without labels");

roiManager("Select", 152);
Roi.setPosition(0,0,t0);
roiManager("Select", 153);
Roi.setPosition(0,0,t0);
roiManager("Select", 154);
Roi.setPosition(0,0,t0);

//Saving
saveAs("Tiff",saveDirectory+imageTitle+".tif");

//Z project
if (zseries == true){
	run("Z Project...", "start="+zstart+" stop="+zend+" projection=["+ztype+"]");
	saveAs("Tiff",saveDirectory+"MAX_"+imageTitle+".tif");
	Stack.setChannel(zchannel);
	saveAs("JPEG",saveDirectory+"MAX_"+imageTitle+"-C"+zchannel+".jpeg");
} else if (timeseries == false) {
	saveAs("JPEG",saveDirectory+imageTitle+"-C"+zchannel+".jpeg");
}
//Saving 2
if (timeseries == true)
	run("AVI... ", "compression=JPEG frame=7");

