#assumes same aIDs at all times or eqvPos input
function straj = subtraj(traj, tIDs=[], aIDs=[], eqvPos=[])

  if isempty(tIDs),
    tIDs = 1:size(traj.coords,3);
  endif
  if isempty(aIDs),
    aIDs = sort(traj.id);
  endif
  if rows(aIDs)==1 | columns(aIDs)==1,
    eqvPos = aIDs(:);
    straj.coords = traj.coords(aIDs,:,tIDs);
  else,
    if rows(aIDs)!=numel(eqvPos),
      error('Atom IDs requires size (eqvPos x ...)');
    endif
    if columns(aIDs)!=numel(tIDs),
      error('Atom IDs requires size (... x tIDs)');
    endif
    straj.coords = zeros([numel(eqvPos),3,numel(tIDs)]);
    for i = 1:numel(tIDs),
      straj.coords(:,:,i) = traj.coords(aIDs(:,i),:,tIDs(i));
    endfor
  endif
  straj.natoms = numel(eqvPos);
  straj.id = traj.id(1:numel(eqvPos));
  straj.element = traj.element(eqvPos);
  straj.type = traj.type(eqvPos);
  straj.q = traj.q(eqvPos);
  straj.mass = traj.mass(eqvPos);
  straj.latvec = traj.latvec(:,:,tIDs);
  
endfunction