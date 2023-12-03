# batch_commands
## touch files in subfolders by executed file then save them in the same directory structure

example, convert all flv files in folder a to mp4 files, then save them in folder b, use command as bellow.  
`batch_commands d:\a *.flv d:\b mp4 ffmpeg -i _@fromfile -c copy _@tofile`
