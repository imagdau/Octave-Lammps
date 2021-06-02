function latvec = lenang2latvec(lenang)

  length_a = lenang(1);
  length_b = lenang(2);
  length_c = lenang(3);
  angle_alpha = lenang(4);
  angle_beta  = lenang(5);
  angle_gamma = lenang(6);
  if numel(lenang)==6,
    cos_alpha = cos(angle_alpha*pi/180.0);
    cos_beta  = cos(angle_beta *pi/180.0);
    cos_gamma = cos(angle_gamma*pi/180.0);
  else
    if numel(lenang)==9,
      cos_alpha = lenang(7);
      cos_beta  = lenang(8);
      cos_gamma = lenang(9);
    else
      error('lenang must have either size 6 or 9');
    endif
  endif
  ax = length_a;
  ay = 0.0;
  az = 0.0;
  bx = length_b*cos_gamma;
  by = sqrt(length_b^2-bx^2);
  bz = 0.0;
  cx = length_c*cos_beta;
  cy = (length_b*length_c*cos_alpha-bx*cx)/by;
  cz = sqrt(length_c^2-cx^2-cy^2);
  latvec = [ax,bx,cx;ay,by,cy;az,bz,cz];
  
endfunction
