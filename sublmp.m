function datout = sublmp(datin,molec,zeroCharge=true)

# # #   ###test: Atoms,Bonds,Angles,Dihedrals,Impropers not listed in order and are not contigous
# # #   rand("seed",10);
# # #   datin.Masses = datin.Masses(randperm(datin.atom_types),:);
# # #   datin.PairCoeffs = datin.PairCoeffs(randperm(datin.atom_types),:);
# # #   datin.BondCoeffs = datin.BondCoeffs(randperm(datin.bond_types),:);
# # #   datin.AngleCoeffs = datin.AngleCoeffs(randperm(datin.angle_types),:);
# # #   datin.DihedralCoeffs = datin.DihedralCoeffs(randperm(datin.dihedral_types),:);
# # #   datin.ImproperCoeffs = datin.ImproperCoeffs(randperm(datin.improper_types),:);
# # #   datin.Atoms = datin.Atoms(randperm(datin.atoms),:);
# # #   datin.Bonds = datin.Bonds(randperm(datin.bonds),:);
# # #   datin.Angles = datin.Angles(randperm(datin.angles),:);
# # #   datin.Dihedrals = datin.Dihedrals(randperm(datin.dihedrals),:);
# # #   datin.Impropers = datin.Impropers(randperm(datin.impropers),:);
# # #   datin.Masses(:,1) = datin.Masses(:,1).*2;
# # #   datin.PairCoeffs(:,1) = datin.PairCoeffs(:,1).*2;
# # #   datin.BondCoeffs(:,1) = datin.BondCoeffs(:,1).*2;
# # #   datin.AngleCoeffs(:,1) = datin.AngleCoeffs(:,1).*2;
# # #   datin.DihedralCoeffs(:,1) = datin.DihedralCoeffs(:,1).*2;
# # #   datin.ImproperCoeffs(:,1) = datin.ImproperCoeffs(:,1).*2;
# # #   datin.Atoms(:,[1,3]) = datin.Atoms(:,[1,3]).*2;
# # #   datin.Bonds(:,[1,2,3,4]) = datin.Bonds(:,[1,2,3,4]).*2;
# # #   datin.Angles(:,[1,2,3,4,5]) = datin.Angles(:,[1,2,3,4,5]).*2;
# # #   datin.Dihedrals(:,[1,2,3,4,5,6]) = datin.Dihedrals(:,[1,2,3,4,5,6]).*2;
# # #   datin.Impropers(:,[1,2,3,4,5,6]) = datin.Impropers(:,[1,2,3,4,5,6]).*2;
# # #   molec = molec.*2;

  %Box
  datout.xlo = datin.xlo;
  datout.xhi = datin.xhi;
  datout.ylo = datin.ylo;
  datout.yhi = datin.yhi;
  datout.zlo = datin.zlo;
  datout.zhi = datin.zhi;
  datout.xy = datin.xy;
  datout.xz = datin.xz;
  datout.yz = datin.yz;
  
  %Atoms
  atom_mask = sum(datin.Atoms(:,1)==molec,2)==1;
  atom_dict = [datin.Atoms(atom_mask,1),(1:sum(atom_mask))'];
  buf = unique(datin.Atoms(atom_mask,3));
  atom_type_dict = [buf,(1:numel(buf))'];
  mass_mask = sum(datin.Masses(:,1)==atom_type_dict(:,1)',2)==1;
  pair_mask = sum(datin.PairCoeffs(:,1)==atom_type_dict(:,1)',2)==1;
  charge = datin.Atoms(atom_mask,4);

  datout.Masses = datin.Masses(mass_mask,:);
  datout.Masses(:,1) = mapidx(atom_type_dict,datin.Masses(mass_mask,1));
  datout.Masses = sortrows(datout.Masses,1);

  datout.PairCoeffs = datin.PairCoeffs(pair_mask,:);
  datout.PairCoeffs(:,1) = mapidx(atom_type_dict,datin.PairCoeffs(pair_mask,1));
  datout.PairCoeffs = sortrows(datout.PairCoeffs,1);
  
  datout.Atoms = datin.Atoms(atom_mask,:);
  datout.Atoms(:,1) = mapidx(atom_dict,datin.Atoms(atom_mask,1));
  datout.Atoms(:,3) = mapidx(atom_type_dict,datin.Atoms(atom_mask,3));
  if zeroCharge,
#     datout.Atoms(:,4) -= sum(charge).*abs(charge)./sum(abs(charge));
    datout.Atoms(:,4) -= mean(charge);
  endif
  
  datout.atoms = sum(atom_mask);
  datout.atom_types = sum(mass_mask);
  
  %Bonds
  bond_mask = sum(datin.Bonds(:,3)==molec|datin.Bonds(:,4)==molec,2)==2;
  bond_dict = [datin.Bonds(bond_mask,1),(1:sum(bond_mask))'];
  buf = unique(datin.Bonds(bond_mask,2));
  bond_type_dict = [buf,(1:numel(buf))'];
  bond_type_mask = sum(datin.BondCoeffs(:,1)==bond_type_dict(:,1)',2)==1;
  
  datout.BondCoeffs = datin.BondCoeffs(bond_type_mask,:);
  datout.BondCoeffs(:,1) = mapidx(bond_type_dict,datin.BondCoeffs(bond_type_mask,1));
  datout.BondCoeffs = sortrows(datout.BondCoeffs,1);  
  
  datout.Bonds = datin.Bonds(bond_mask,:);
  datout.Bonds(:,1) = mapidx(bond_dict,datin.Bonds(bond_mask,1));
  datout.Bonds(:,2) = mapidx(bond_type_dict,datin.Bonds(bond_mask,2));
  datout.Bonds(:,3) = mapidx(atom_dict,datin.Bonds(bond_mask,3));
  datout.Bonds(:,4) = mapidx(atom_dict,datin.Bonds(bond_mask,4));
  
  datout.bonds = sum(bond_mask);
  datout.bond_types = sum(bond_type_mask);
  
  %Angles
  angle_mask = sum(datin.Angles(:,3)==molec|datin.Angles(:,4)==molec|datin.Angles(:,5)==molec,2)==3;
  angle_dict = [datin.Angles(angle_mask,1),(1:sum(angle_mask))'];
  buf = unique(datin.Angles(angle_mask,2));
  angle_type_dict = [buf,(1:numel(buf))'];
  angle_type_mask = sum(datin.AngleCoeffs(:,1)==angle_type_dict(:,1)',2)==1;
  
  datout.AngleCoeffs = datin.AngleCoeffs(angle_type_mask,:);
  datout.AngleCoeffs(:,1) = mapidx(angle_type_dict,datin.AngleCoeffs(angle_type_mask,1));
  datout.AngleCoeffs = sortrows(datout.AngleCoeffs,1);
  
  datout.Angles = datin.Angles(angle_mask,:);
  datout.Angles(:,1) = mapidx(angle_dict,datin.Angles(angle_mask,1));
  datout.Angles(:,2) = mapidx(angle_type_dict,datin.Angles(angle_mask,2));
  datout.Angles(:,3) = mapidx(atom_dict,datin.Angles(angle_mask,3));
  datout.Angles(:,4) = mapidx(atom_dict,datin.Angles(angle_mask,4));
  datout.Angles(:,5) = mapidx(atom_dict,datin.Angles(angle_mask,5));
  
  datout.angles = sum(angle_mask);
  datout.angle_types = sum(angle_type_mask);

  %Dihedrals
  if isfield(datin,"DihedralCoeffs"),
    dihedral_mask = sum(datin.Dihedrals(:,3)==molec|datin.Dihedrals(:,4)==molec|datin.Dihedrals(:,5)==molec|datin.Dihedrals(:,6)==molec,2)==4;
    dihedral_dict = [datin.Dihedrals(dihedral_mask,1),(1:sum(dihedral_mask))'];
    buf = unique(datin.Dihedrals(dihedral_mask,2));
    dihedral_type_dict = [buf,(1:numel(buf))'];
    dihedral_type_mask = sum(datin.DihedralCoeffs(:,1)==dihedral_type_dict(:,1)',2)==1;
    
    datout.DihedralCoeffs = datin.DihedralCoeffs(dihedral_type_mask,:);
    datout.DihedralCoeffs(:,1) = mapidx(dihedral_type_dict,datin.DihedralCoeffs(dihedral_type_mask,1));
    datout.DihedralCoeffs = sortrows(datout.DihedralCoeffs,1);
    
    datout.Dihedrals = datin.Dihedrals(dihedral_mask,:);
    datout.Dihedrals(:,1) = mapidx(dihedral_dict,datin.Dihedrals(dihedral_mask,1));
    datout.Dihedrals(:,2) = mapidx(dihedral_type_dict,datin.Dihedrals(dihedral_mask,2));
    datout.Dihedrals(:,3) = mapidx(atom_dict,datin.Dihedrals(dihedral_mask,3));
    datout.Dihedrals(:,4) = mapidx(atom_dict,datin.Dihedrals(dihedral_mask,4));
    datout.Dihedrals(:,5) = mapidx(atom_dict,datin.Dihedrals(dihedral_mask,5));
    datout.Dihedrals(:,6) = mapidx(atom_dict,datin.Dihedrals(dihedral_mask,6));
    
    datout.dihedrals = sum(dihedral_mask);
    datout.dihedral_types = sum(dihedral_type_mask);
    
    if (datout.dihedrals==0),
      datout = rmfield(datout,'Dihedrals');
    endif
    if (datout.dihedral_types==0),
      datout = rmfield(datout,'DihedralCoeffs');
    endif    
  endif
  
  %Impropers
  if isfield(datin,"ImproperCoeffs"),
    improper_mask = sum(datin.Impropers(:,3)==molec|datin.Impropers(:,4)==molec|datin.Impropers(:,5)==molec|datin.Impropers(:,6)==molec,2)==4;
    improper_dict = [datin.Impropers(improper_mask,1),(1:sum(improper_mask))'];
    buf = unique(datin.Impropers(improper_mask,2));
    improper_type_dict = [buf,(1:numel(buf))'];
    improper_type_mask = sum(datin.ImproperCoeffs(:,1)==improper_type_dict(:,1)',2)==1;
   
    datout.ImproperCoeffs = datin.ImproperCoeffs(improper_type_mask,:);
    datout.ImproperCoeffs(:,1) = mapidx(improper_type_dict,datin.ImproperCoeffs(improper_type_mask,1));
    datout.ImproperCoeffs = sortrows(datout.ImproperCoeffs,1);
    
    datout.Impropers = datin.Impropers(improper_mask,:);
    datout.Impropers(:,1) = mapidx(improper_dict,datin.Impropers(improper_mask,1));
    datout.Impropers(:,2) = mapidx(improper_type_dict,datin.Impropers(improper_mask,2));
    datout.Impropers(:,3) = mapidx(atom_dict,datin.Impropers(improper_mask,3));
    datout.Impropers(:,4) = mapidx(atom_dict,datin.Impropers(improper_mask,4));
    datout.Impropers(:,5) = mapidx(atom_dict,datin.Impropers(improper_mask,5));
    datout.Impropers(:,6) = mapidx(atom_dict,datin.Impropers(improper_mask,6));
    
    datout.impropers = sum(improper_mask);
    datout.improper_types = sum(improper_type_mask);
    if (datout.impropers==0),
      datout = rmfield(datout,'Impropers');
    endif
    if (datout.improper_types==0),
      datout = rmfield(datout,'ImproperCoeffs');
    endif
  endif
  
endfunction
