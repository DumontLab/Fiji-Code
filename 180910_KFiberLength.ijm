/*
 * K-fiber length and intensity measuring for one cell
 * by M. Richter 9/2018
 * 
 * 1. Select segmented line tool and set width (rec: 15).
 * 2. Click on start of k-fiber at kinetochore, plot points along it until you reach the end of the fiber or the center of the spindle pole.
 * 3. Click "ok" on dialog box to confirm your line is drawn.
 * 4. Specify filename and directory.
 * 		Recommended filename: dateimaged_cellNo_channel_zstack?_extension, where extension is k-fiber number and "a" or "b" to denote which sister
 * 		example: 160119_004_488_z_1a
 * 5. Click "ok" on dialog box to save csv file of line profile intensities.
 * 6. Repeat for rest of k-fibers.
 * 7. When finished, hit 'Esc'.
 * 8. Profit.
 */

while (true) {

waitForUser("Is your line drawn?");

//the dialog

Dialog.create("Saving options")
Dialog.addString("extension", "1a");
Dialog.addString("directory", "/Users/manuela/Desktop/data/p50_spindles/analysis/WT/line_profiles/");
Dialog.addString("file name", "160119_004-1_488_z_");

Dialog.show();

ext=Dialog.getString();
dir=Dialog.getString();
filename=Dialog.getString();


//the line profile saver

run("Clear Results");
	profile = getProfile();
	for (i=0; i<profile.length; i++)
	setResult("Value", i, profile[i]);
updateResults;

saveAs("Results", dir+filename+ext+".csv");

}