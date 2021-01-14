function writeEXTxyz(fname,traj,iter=[]);

  if isempty(iter),
    iter = 1:traj.nsteps;
  endif

  fid = fopen(fname,"w");
  tic;
  for i = iter,
  
    fprintf(fid,"%d\n",traj.natoms);
    fprintf(fid,"Lattice=\"%.5f %.5f %.5f %.5f %.5f %.5f %.5f %.5f %.5f\"",traj.latvec(:,:,i));
    fprintf(fid," Properties=species:S:1:pos:R:3",traj.natoms);
    fprintf(fid," Time=%.1f",i);
    fprintf(fid,"\n");

    ###%%% slow implementation
    ###for j = 1:traj.natoms,
    ###  fprintf(fid,"%s %.5f %.5f %.5f\n",traj.element{j},traj.coords(j,:,i));
    ###endfor

    ###%%% interesing, but prints entire matrix on one line
    ###data = char(strcat(traj.element',{" "},num2str(traj.coords(:,:,i),"%.5f %.5f %.5f\n")));
    ###fprintf(fid,"%s\n",data');

    %%% works and it is efficient
    fprintf(fid,"%s %.5f %.5f %.5f\n",[traj.element;num2cell(traj.coords(:,:,i)')]{:});
    
  endfor
  toc;
  fclose(fid);
  
endfunction
