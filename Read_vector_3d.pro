pro Read_vector_3d,dir,file,numframe,data_3d

  common parameters

  ;Open file-----------------------------------------
  close,1
  fullpath = dir+file+'.dat'
  openr,1,fullpath,/f77_unformatted
  ;--------------------------------------------------

  ;create array--------------------------------------
  frame = 0l
  data_3d = fltarr(nx,ny,nz,3,/nozero)
  framecount = 1
  ;--------------------------------------------------

  ;Populate array------------------------------------
  while (framecount le numframe) do begin
    frame = 0l
    readu,1,frame
    readu,1,data_3d
    framecount = framecount + 1
  endwhile
  ;--------------------------------------------------

  print,'image # ', frame
  close,1

  return

end