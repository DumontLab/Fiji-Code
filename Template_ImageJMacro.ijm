/*
 * Title: ImageJ Macro Template
 * Name: Your Name
 * Date: 10/2018
 * 
 * Short description of what the code does:
 * Adds a scale bar to the open image and saves it as a tif.
 * Then measures profile intensity along a line and saves it as a csv.
 * 
 */


//Get title and directory of open image
imageTitle = getTitle();
imageDirectory = getDirectory("image");


/////Example Manipulating an Image

//Add a scale bar
pixelToMicronRatio = 0.0657
run("Set Scale...", "distance=1 known="+pixelToMicronRatio+" pixel=1 unit=microns global");
run("Scale Bar...", "width=5 height=8 font=30 color=White background=None location=[Lower Right] bold overlay label");



/////Example Saving An Image

//Example dialog box to save an image
Dialog.create("Saving options")
Dialog.addString("directory", "/Users/manuela/Desktop/");
Dialog.addString("file name", "1801009_example001");
Dialog.show();

dir=Dialog.getString();
filename=Dialog.getString();

//Save the image
saveAs("Tiff", dir+filename+"_scalebar.tif");



/////Example Measurement

//Measure line profile intensity
waitForUser("Draw a line to measure its line profile.")

run("Clear Results"); //clears any previous data in Results window
profile = getProfile();
	for (i=0; i<profile.length; i++)
	setResult("Value", i, profile[i]);
updateResults;
run("Plot Profile");

//Save line profile results
saveAs("Results", dir+filename+"_lineprof.csv");