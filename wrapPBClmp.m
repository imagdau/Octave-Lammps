%wraps the coordinates around the origin
%WARNING: images remain the same
%tested for non-orthogonal cells

function datout = wrapPBClmp(datin)

  datout = datin;
  mat = [datin.xhi-datin.xlo, 0.0, 0.0;
        datin.xy, datin.yhi-datin.ylo, 0.0;
        datin.xz, datin.yz, datin.zhi-datin.zlo];
  internal = datout.Atoms(:,5:7)*inv(mat);
  pbc = floor(internal+0.5);
  datout.Atoms(:,5:7) -= pbc*mat;

endfunction
