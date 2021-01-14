function atoms = mass2atom(masses)

  [mass,name,abr,num] = textread("atomtable.dat","%f%s%s%d");
  for i=1:numel(masses),
    idx = find(abs(mass-masses(i))<0.01);
    atoms(i) = abr(idx);
  endfor

endfunction
