// Manny's Image Labeler
// Opens a dialog interface to name your image, add scale bar, add time stamps, and do a z-projection.
// Saves images as .tif and .jpeg, and movies as .tif and .avi
// Requires an open image and a directory where to save files.
// Run this code for every channel in your hyperstack you wish to save.

//run("Bio-Formats Importer");
run("Remove Overlay"); 
//run("Revert");

//SET DIRECTORY
saveDirectory = "/Users/manuela/Desktop/desk_processed/";
getDimensions(width, height, channels, slices, frames);

Dialog.create("Manny's Image Labeler");
Dialog.addString("Image title",replace(getTitle(),".tif",""),80);
Dialog.addString("Saving directory", saveDirectory,80);
Dialog.addNumber("pixelToMicronRatio", 0.0657); //0.110 scope 1 100x //0.0657 scope 2 100x
Dialog.addCheckbox("Time series?", true);
Dialog.addChoice("Format", newArray("0", "00:00","00:00:00"),"00:00");
Dialog.addString("Time text", "min:sec");
Dialog.addNumber("Time interval", 5);
Dialog.addNumber("What frame is time 0?", 0);
Dialog.addCheckbox("Z series?", false);
Dialog.addNumber("Z-project which channel? This image has "+channels+" channels.", 1);
Dialog.addNumber("Starting at what z slice?", 1);
Dialog.addNumber("Ending at what z slice?", slices);
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
zseries = Dialog.getCheckbox();
zchannel = Dialog.getNumber();
zstart = Dialog.getNumber();
zend = Dialog.getNumber();
ztype = Dialog.getChoice();

//pixelToMicronRatio = 0.105 //Scope 1 100X
//pixelToMicronRatio = 0.175 //Scope 1 60X
//pixelToMicronRatio = 0.110 //Scope 2 60X
//pixelToTime = 60.0657 //Scope 2 100X
//pixelToTime = 60 //sec per frame in kymograph

//Time series
if (timeseries == true)
	run("Label...","format="+timeformat+" starting="+(1-t0)*timeinterval+" interval="+timeinterval+" x=10 y=20 font=30 text=["+timetext+"] use");

//Scale bar
run("Set Scale...", "distance=1 known="+pixelToMicronRatio+" pixel=1 unit=microns global");
run("Scale Bar...", "width=5 height=10 thickness=5 font=30 color=White background=None location=[Lower Right] horizontal bold overlay");

//Saving (image)
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
//Saving (movie)
if (timeseries == true)
	run("AVI... ", "compression=JPEG frame=7");
