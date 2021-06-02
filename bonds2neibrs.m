function nbs = bonds2neibrs(bonds,natoms)
  
  nbs = cell(natoms,1);
  for i = 1:natoms,
    nbs{i} = sort([bonds(bonds(:,1)==i,2);bonds(bonds(:,2)==i,1)]');
  endfor

endfunction