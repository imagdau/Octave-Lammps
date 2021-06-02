#combines along time, assumes same number of atoms, same atom types and order
function straj = combtraj(traj1, traj2)

  if isfield(traj1, 'internal'),
    if !isfield(traj2, 'internal'),
      traj1 = rmfield(traj1, 'internal');
    endif;
  else,
    if isfield(traj2, 'internal'),
      traj2 = rmfield(traj2, 'internal');
    endif
  endif
  straj = traj1;
  
  straj.coords = cat(3,straj.coords,traj2.coords);
  straj.latvec = cat(3,straj.latvec,traj2.latvec);
  if isfield(straj, 'internal'),
    straj.internal = cat(3,straj.internal,traj2.internal);
  endif

endfunction