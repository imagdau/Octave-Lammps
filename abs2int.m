function internal = abs2int(traj)

  internal = zeros(size(traj.coords));
  for i=1:size(traj.coords,3),
    internal(:,:,i) = traj.coords(:,:,i)*inv(traj.latvec(:,:,i)');
  endfor

endfunction