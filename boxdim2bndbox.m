function bndbox = boxdim2bndbox(boxdim)

  xlo = boxdim(1);
  xhi = boxdim(2);
  ylo = boxdim(3);
  yhi = boxdim(4);
  zlo = boxdim(5);
  zhi = boxdim(6);
  xy  = boxdim(7);
  xz  = boxdim(8);
  yz  = boxdim(9);

  xlo_bnd = xlo+min([0.0,xy,xz,xy+xz]);
  xhi_bnd = xhi+max([0.0,xy,xz,xy+xz]);
  ylo_bnd = ylo+min([0.0,yz]);
  yhi_bnd = yhi+max([0.0,yz]);
  zlo_bnd = zlo;
  zhi_bnd = zhi;
  
  bndbox = [xlo_bnd,xhi_bnd,ylo_bnd,yhi_bnd,zlo_bnd,zhi_bnd,xy,xz,yz];
  
endfunction
