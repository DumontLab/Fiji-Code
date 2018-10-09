Christina's macros

"CH_example_Make_IF_Figs" is a simple, two-part example FIJI macro that starts with separate MetaMorph zStacks (one for each channel) and outputs and saves consistently scaled, pseudo-colored, and z-projected figure panels.  Building on something like this can save you a lot of time if you're making lots of figures for a talk, poster, or paper, and you've chosen how you want to set your image min/max, color, image type, etc -- and now you just want to do that exact same thing for lots of images.
1) Open your zStacks of interest
2) Run part 1, which will produce a multichannel, scaled zStack and prompt you to save it
3) Look at this zStack and choose the z-slices you want to use for your z-projection
4) Run part 2, which will prompt you to input those z-slices, and then create whatever combinations of images you want, with the file type you want, named whatever you want, and let you choose where to save these.

"CH_uManager_Make_IF_Figs" does the same thing, but starting with MicroManager multi-channel .tif stacks (like .ome files).