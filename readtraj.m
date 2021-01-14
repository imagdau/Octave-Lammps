function datacol = readtraj(fname)
  
  fid = fopen(fname,'r');
  datacol = [];
  tID = 1;
  
  while !feof(fid),
    
    disp(tID);
    fflush(stdout);
    tID++;
    
    line = strtrim(fgetl(fid));
    if !strcmp(line,"ITEM: TIMESTEP"),
      error(["expected ITEM: TIMESTEP, found ", line]);
    endif
    data.tstep = str2num(strtrim(fgetl(fid)));

    line = strtrim(fgetl(fid));
    if !strcmp(line,"ITEM: NUMBER OF ATOMS"),
      error(["expected ITEM: NUMBER OF ATOMS, found ", line]);
    endif
    data.natoms = str2num(strtrim(fgetl(fid)));

    line = strtrim(fgetl(fid));
    if !strcmp(line,"ITEM: BOX BOUNDS xy xz yz pp pp pp"),
      error(["expected ITEM: BOX BOUNDS xy xz yz pp pp pp, found ", line]);
    endif
    boxdef = cellfun("str2num",fgetcnk(fid,3));
    data.mat(1,:) = [boxdef(1,2)-max([0.0,boxdef(1,3),boxdef(2,3),boxdef(1,3)+boxdef(2,3)])-boxdef(1,1)+min([0.0,boxdef(1,3),boxdef(2,3),boxdef(1,3)+boxdef(2,3)]),0,0];
    data.mat(2,:) = [boxdef(1,3),boxdef(2,2)-max([0.0,boxdef(3,3)])-boxdef(2,1)+min([0.0,boxdef(3,3)]),0];
    data.mat(3,:) = [boxdef(2,3),boxdef(3,3),boxdef(3,2)-boxdef(3,1)];
    
    line = strtrim(fgetl(fid));
    if strcmp(line,"ITEM: ATOMS id element type xu yu zu"),
      atoms = fgetcnk(fid,data.natoms);
      data.atoms.label = cellfun("str2num",atoms(:,1));
      data.atoms.element = atoms(:,2);
      data.atoms.type = cellfun("str2num",atoms(:,3));
      data.atoms.coords = cellfun("str2num",atoms(:,4:6));
    endif
    if strcmp(line,"ITEM: ATOMS x y z"),
      atoms = fgetcnk(fid,data.natoms);
      data.atoms.coords = cellfun("str2num",atoms(:,1:3));
    endif

    datacol = [datacol,data];
  endwhile
  
  fclose(fid);

endfunction