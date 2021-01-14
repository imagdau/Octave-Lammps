function writexyz(fname,atoms,coords)

  fid = fopen(fname,"w");
  N = size(coords,1);
  fprintf(fid,"%d\nxyz\n",N);
  for i=1:N,
    fprintf(fid,"%3s%12.7f%12.7f%12.7f\n",atoms{i},coords(i,:));
  endfor
  fclose(fid);

endfunction
