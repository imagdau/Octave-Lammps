function absolute = int2abs(traj)

  absolute = zeros(size(traj.internal));
  for i=1:size(traj.internal,3),
    absolute(:,:,i) = traj.internal(:,:,i)*(traj.latvec(:,:,i)');
  endfor

endfunction