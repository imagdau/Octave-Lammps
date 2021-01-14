function boxdim = latvec2boxdim(latvec)

  boxdim(1) = -latvec(1,1)/2.0;
  boxdim(2) = +latvec(1,1)/2.0;
  boxdim(3) = -latvec(2,2)/2.0;
  boxdim(4) = +latvec(2,2)/2.0;
  boxdim(5) = -latvec(3,3)/2.0;
  boxdim(6) = +latvec(3,3)/2.0;
  boxdim(7) = +latvec(1,2);
  boxdim(8) = +latvec(1,3);
  boxdim(9) = +latvec(2,3);
  
endfunction
