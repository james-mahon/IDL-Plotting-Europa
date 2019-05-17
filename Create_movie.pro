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
  for i = 1,num_frame do begin
    Read_scalar_3d, dir, 'c.np_3d_8', i, density_3d
    center_proc = ceil(num_proc/2)

    density_2d = density_3d[*,*,center_proc]
    c_density = contour(density_2d, /fill,RGB_TABLE=ct, /buffer)
    cb_density = colorbar(target=c_density, orientation=1, title = 'density')
    if(i eq 1) then begin 
      c_density.save, 'density.gif'
    endif else begin
      c_density.save, 'density.gif', /APPEND
    endelse
    
  endfor
  print, "done"
  
  
end