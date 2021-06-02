function [dists,vols] = distPBC(traj,idx)

  [Na,buf,Nt] = size(traj.coords);
  if numel(idx)==1,
    idx = repmat(idx,1,Nt);
  endif;
  
  dists = zeros(Na,Nt);
  vols = zeros(Nt,1);
  internal = abs2int(traj);
  
  for i=1:Nt,
    vecs = internal(:,:,i)-internal(idx(i),:,i);
    pbc = floor(vecs+0.5);
    vecs -= pbc; %enforce PBC
    dists(:,i) = sqrt(sum((vecs*(traj.latvec(:,:,i)')).^2,2));
    vols(i) = det(traj.latvec(:,:,i));
  endfor
  
endfunction
