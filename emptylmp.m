function data = emptylmp()

  data.atoms     = 0;
  data.bonds     = 0;
  data.angles    = 0;
  data.dihedrals = 0;
  data.impropers = 0;
  
  data.atom_types     = 0;
  data.bond_types     = 0;
  data.angle_types    = 0;
  data.dihedral_types = 0;
  data.improper_types = 0;
  
  data.Masses         = [];
  data.PairCoeffs     = [];
  data.BondCoeffs     = [];
  data.AngleCoeffs    = [];
  data.DihedralCoeffs = [];
  data.ImproperCoeffs = [];
    
  data.Atoms     = [];
  data.Bonds     = [];
  data.Angles    = [];
  data.Dihedrals = [];
  data.Impropers = [];

  data.xlo = 0;
  data.ylo = 0;
  data.zlo = 0;

  data.xhi = 0;
  data.yhi = 0;
  data.zhi = 0;

endfunction
