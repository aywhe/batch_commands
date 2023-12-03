# batch_commands
## touch files in subfolders by executed file then save them in the same directory structure

Example, convert all flv files in folder a to mp4 files, then save them in folder b, use command as bellow.  
`batch_commands d:\a *.flv d:\b mp4 ffmpeg -i _@fromfile -c copy _@tofile`  
Or you can use `for` command only like this:  
`for /r d:\a %i in (*.flv) do (ffmpeg -i %i -c copy %~ni.mp4)`  
But I don't know yet how to copy them to folder b in old subfolder structure.