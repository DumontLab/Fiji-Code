//run("Bio-Formats Importer");
//run("Remove Overlay"); 
//run("Revert");

inputDir = "/Users/manuela/Desktop/processed/PRC1-PS/";
outputDir = "/Users/manuela/Desktop/processed/PRC1-PS/";

list = getFileList(inputDir);
setBatchMode(true);
for (i=0; i<list.length; i++) {
 //showProgress(i+1, list.length);
 //open(processDirectory+list[i]);
 	run("Bio-Formats Importer");

	getDimensions(width, height, channels, slices, frames);
	title = getTitle();
	pixelToMicronRatio = 0.110;
	
	//C4
	ext = "PRC1";
	run("Set Scale...", "distance=1 known="+pixelToMicronRatio+" unit=micron");
	run("Scale Bar...", "width=5 height=30 thickness=5 font=30 color=White background=None location=[Lower Right] horizontal bold overlay");
	saveAs("Tiff", outputDir+ext+"/"+title+"_"+ext+".tif");
	run("Z Project...", "projection=[Max Intensity]");
	saveAs("Tiff", outputDir+"MAX_"+ext+"/"+"MAX_"+title+"_"+ext+".tif");
	close();
	close();
	
	//C3
	ext = "p50";
	run("Set Scale...", "distance=1 known="+pixelToMicronRatio+" unit=micron");
	run("Scale Bar...", "width=5 height=30 thickness=5 font=30 color=White background=None location=[Lower Right] horizontal bold overlay");
	saveAs("Tiff", outputDir+ext+"/"+title+"_"+ext+".tif");
	run("Z Project...", "projection=[Max Intensity]");
	saveAs("Tiff", outputDir+"MAX_"+ext+"/"+"MAX_"+title+"_"+ext+".tif");
	close();
	close();
	
	//C2
	ext = "tub";
	run("Set Scale...", "distance=1 known="+pixelToMicronRatio+" unit=micron");
	run("Scale Bar...", "width=5 height=30 thickness=5 font=30 color=White background=None location=[Lower Right] horizontal bold overlay");
	saveAs("Tiff", outputDir+ext+"/"+title+"_"+ext+".tif");
	run("Z Project...", "projection=[Max Intensity]");
	saveAs("Tiff", outputDir+"MAX_"+ext+"/"+"MAX_"+title+"_"+ext+".tif");
	close();
	close();
	
	//C1
	ext = "DNA";
	run("Set Scale...", "distance=1 known="+pixelToMicronRatio+" unit=micron");
	run("Scale Bar...", "width=5 height=30 thickness=5 font=30 color=White background=None location=[Lower Right] horizontal bold overlay");
	saveAs("Tiff", outputDir+ext+"/"+title+"_"+ext+".tif");
	run("Z Project...", "projection=[Max Intensity]");
	saveAs("Tiff", outputDir+"MAX_"+ext+"/"+"MAX_"+title+"_"+ext+".tif");
	close();
	close();
	
	//C0
	close();
}