function datout = reducelmp(datin, flags=[true,true,true,true,true])

  datout = datin;

  #reduce atom types
  if flags(1),
    [aux,buf,order] = unique([datin.Masses(:,2),datin.PairCoeffs(:,2:end)],"rows");
    datout.Atoms(:,3) = order(datin.Atoms(:,3));
    datout.atom_types = size(aux,1);
    datout.Masses = [(1:datout.atom_types)',aux(:,1)];
    datout.PairCoeffs = [(1:datout.atom_types)',aux(:,2:end)];
  endif

  #reduce bond types
  if flags(2),
    [aux,buf,order] = unique(datin.BondCoeffs(:,2:end),"rows");
    datout.Bonds(:,2) = order(datin.Bonds(:,2));
    datout.bond_types = size(aux,1);
    datout.BondCoeffs = [(1:datout.bond_types)',aux];
  endif

  #reduce angle types
  if flags(3),
    [aux,buf,order] = unique(datin.AngleCoeffs(:,2:end),"rows");
    datout.Angles(:,2) = order(datin.Angles(:,2));
    datout.angle_types = size(aux,1);
    datout.AngleCoeffs = [(1:datout.angle_types)',aux];
  endif
  
  #reduce dihedral types
  if flags(4),
    if isfield(datin,"DihedralCoeffs"),
      [aux,buf,order] = unique(datin.DihedralCoeffs(:,2:end),"rows");
      datout.Dihedrals(:,2) = order(datin.Dihedrals(:,2));
      datout.dihedral_types = size(aux,1);
      datout.DihedralCoeffs = [(1:datout.dihedral_types)',aux];
    endif
  endif
  
  #reduce improper types
  if flags(5),
    if isfield(datin,"ImproperCoeffs"),
      [aux,buf,order] = unique(datin.ImproperCoeffs(:,2:end),"rows");
      datout.Impropers(:,2) = order(datin.Impropers(:,2));
      datout.improper_types = size(aux,1);
      datout.ImproperCoeffs = [(1:datout.improper_types)',aux];
    endif
  endif
  
endfunction