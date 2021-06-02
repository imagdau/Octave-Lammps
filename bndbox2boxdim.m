function boxdim = bndbox2boxdim(bndbox)

  xlo_bnd = bndbox(1);
  xhi_bnd = bndbox(2);
  ylo_bnd = bndbox(3);
  yhi_bnd = bndbox(4);
  zlo_bnd = bndbox(5);
  zhi_bnd = bndbox(6);
  xy      = bndbox(7);
  xz      = bndbox(8);
  yz      = bndbox(9);

  xlo = xlo_bnd-min([0.0,xy,xz,xy+xz]);
  xhi = xhi_bnd-max([0.0,xy,xz,xy+xz]);
  ylo = ylo_bnd-min([0.0,yz]);
  yhi = yhi_bnd-max([0.0,yz]);
  zlo = zlo_bnd;
  zhi = zhi_bnd;
  
  boxdim = [xlo,xhi,ylo,yhi,zlo,zhi,xy,xz,yz];

endfunction
