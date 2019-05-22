pro Create_movie
  COMMON parameters,$
  nx,ny,nz,dx,dy,delz,$
  nt,dt,nout,$
  Ni_max,$
  m_pu,$
  alpha,beta,$
  b0_init,$
  nf_init,$
  vsw,vth,$
  RIo,$
  dir_root,filenom
  ;----------------------------------------
  dir_root='/Users/jama3001/Data/' ;Base folder (User specific)
  filenom= '2019-Thu-May-16/pluto-1/'  ;Date and run number (Dynamic)
  Read_para
  dir = dir_root + filenom+'data/grid/'
  read,'How many processors?',num_proc
  read,'How many frames?',num_frame
  Read_coord,x,y,z,dz_grid,dz_cell
  ct = colortable(72)
  center_proc = ceil(num_proc/2.0)
  
  ;MAGNETIC FIELD
  for i = 1,num_frame do begin
    Read_vector_3d, dir, 'c.b1_3d_8', i, mag_3d
    mag_2d = mag_3d[*,*,ceil(nz/2.0), 2] ;bz
    c_mag = contour(mag_2d, /fill, RGB_TABLE=ct, /buffer)
    cb_mag = colorbar(target=c_mag, orientation=1, title='bz')
    if(i eq 1) then begin
      c_mag.save, 'bField.gif'
    endif else if(i lt num_frame) then begin
      c_mag.save, 'bField.gif', /APPEND
    endif else begin
      c_mag.save, 'bField.gif', /APPEND, /CLOSE
    endelse
  endfor
  
  ;VELOCITY
  for i = 1,num_frame do begin
    Read_vector_3d, dir, 'c.up_3d_8', i, vlc_3d
    vlc_2d = vlc_3d[*,*,ceil(nz/2.0), 0] ;vx
    c_vlc = contour(vlc_2d, /fill, RGB_TABLE=ct, /buffer)
    cb_vlc = colorbar(target=c_vlc, orientation=1, title='velocity')
    if(i eq 1) then begin
      c_vlc.save, 'velocity.gif'
    endif else if(i lt num_frame) then begin
      c_vlc.save, 'velocity.gif', /APPEND
    endif else begin
      c_vlc.save, 'velocity.gif', /APPEND, /CLOSE
    endelse
  endfor
  
  ;DENSITY
  for i = 1,num_frame do begin
    Read_scalar_3d, dir, 'c.np_3d_8', i, density_3d

    density_2d = density_3d[*,*,ceil(nz/2.0)]
    c_density = contour(density_2d, /fill,RGB_TABLE=ct, /buffer)
    cb_density = colorbar(target=c_density, orientation=1, title = 'density')
    if(i eq 1) then begin 
      c_density.save, 'density.gif'
    endif else if(i lt num_frame) then begin
      c_density.save, 'density.gif', /APPEND
    endif else begin
      c_density.save, 'density.gif', /APPEND, /CLOSE
    endelse
    
  endfor
  
  ;TEMPERATURE
  for i = 1,num_frame do begin
    Read_scalar_3d, dir, 'c.temp_p_3d_8', i, temp_3d

    temp_2d = temp_3d[*,*,ceil(nz/2.0)]
    c_temp = contour(temp_2d, /fill, RGB_TABLE=ct, /buffer)
    cb_temp = colorbar(target=c_temp, orientation=1, title='temp')
    if(i eq 1) then begin
      c_temp.save, 'temp.gif'
    endif else if(i lt num_frame) then begin
      c_temp.save, 'temp.gif', /APPEND
    endif else begin
      c_temp.save, 'temp.gif', /APPEND, /CLOSE
    endelse

  endfor
  
  
  print, "done"
  
  
end