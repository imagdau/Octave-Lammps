function traj = newreadtrajbin(fname_dcd,fname_atoms)

  tic;
  system(["sed '1,/ITEM: ATOMS/d' ",fname_atoms," > buf.atoms"]);
  [err,out] = system(["grep 'ITEM: ATOMS' ",fname_atoms]);
  [coords,latvec]  = myreaddcd(fname_dcd);
  atoms = load("buf.atoms");
  atinfo = strsplit(strtrim(out))(3:end);
  system("rm -f buf.atoms");
 
  traj.nsteps = size(coords,1);
  traj.natoms = size(coords,2)/3;
  for i=1:size(atinfo,2),
    traj.(atinfo{1,i}) = atoms(:,i);
  endfor
  if isfield(traj,'mass'),
    traj.element = mass2atom(traj.mass);
  endif
  traj.coords = permute(reshape(coords',3,traj.natoms,[]),[2,1,3]);
  traj.latvec = reshape(latvec',3,3,[]);
  tm = toc;
  printf('Read time: %.2f(s) | Trajectory size: %.2f(MB)\n',tm,sizeof(traj)./1e+6);
  
endfunction
