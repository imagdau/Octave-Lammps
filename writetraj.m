function writetraj(fname,traj,tIDs=[],flg='w')

  if isempty(tIDs),
    tIDs = 1:size(traj.coords,3);
  endif

  fid = fopen(fname,flg);
  for ti = 1:numel(tIDs),
  
    i = tIDs(ti);
    fprintf(fid,'ITEM: TIMESTEP\n');
    fprintf(fid,'%d\n',i);
    fprintf(fid,'ITEM: NUMBER OF ATOMS\n');
    fprintf(fid,'%d\n',size(traj.coords,1));
    
    boxdim = latvec2boxdim(traj.latvec(:,:,i));
    bndbox = boxdim2bndbox(boxdim);
    fprintf(fid,'ITEM: BOX BOUNDS xy xz yz pp pp pp\n');
    fprintf(fid,'%e %e %e\n',[bndbox(1),bndbox(2),bndbox(7)]);
    fprintf(fid,'%e %e %e\n',[bndbox(3),bndbox(4),bndbox(8)]);
    fprintf(fid,'%e %e %e\n',[bndbox(5),bndbox(6),bndbox(9)]);
    
    fprintf(fid,'ITEM: ATOMS id element type xu yu zu\n');
    for j = 1:size(traj.coords,1),
      fprintf(fid,'%d %s %d %.4f %.4f %.4f\n',traj.id(j),traj.element{j},traj.type(j),traj.coords(j,:,i));
    endfor
    
  endfor
  
  fclose(fid);
  
endfunction
