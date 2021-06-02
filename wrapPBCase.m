function traj = wrapPBCase(traj,idx=[])

  if isempty(idx),
    CM = mean(traj.coords,1);
  else,
    CM = traj.coords(idx,:,:);
  endif
  traj.coords -= CM;
  traj.internal = abs2int(traj);
  pbc = floor(traj.internal);
  traj.internal -= pbc;
  traj.coords = int2abs(traj);

endfunction
