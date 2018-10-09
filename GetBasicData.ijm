run("Bio-Formats Macro Extensions");

id = getInfo("image.directory") + getInfo("image.filename");
Ext.setId(id);
Ext.getImageCount(imageCount);
deltaT = newArray(imageCount);
for (no = 0; no < imageCount; no++) {
  Ext.getPlaneTimingDeltaT(deltaT[no], no);
  }

Ext.getSizeZ(z);
Ext.getSizeC(c);
Ext.getSizeT(t);
Ext.getPixelsPhysicalSizeZ(sizeZ)


planes_per_time = z * c;

first_times = newArray(t);
first_planes = newArray(t);

if (t>1)
{

	temp = 0;

	for (i = 0; i < t; i++)
	{
		first_planes[i] = temp;
		first_times[i] = deltaT[temp];
		temp = temp + planes_per_time; 
	}
	time_diff = newArray(t-1);
	for (i = 0; i < t-1; i++)
	{
		diff = first_times[i+1] - first_times[i];
		time_diff[i] = diff;
	}
	Array.getStatistics(time_diff, min, max, timestep, stdDev);
}

print("Number of timepoints = " + t);
if (t > 1 )
{
	print("Average time between timepoints = " + timestep + " seconds");
}
print("Number of Colors = " + c);
print("Number of Z positions = " + z);
print("Z plane spacing = " + sizeZ + " microns");


