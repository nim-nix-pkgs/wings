{
  description = ''A simple cross language struct and enum file generator.'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-wings-v0_0_2-alpha.flake = false;
  inputs.src-wings-v0_0_2-alpha.owner = "binhonglee";
  inputs.src-wings-v0_0_2-alpha.ref   = "v0_0_2-alpha";
  inputs.src-wings-v0_0_2-alpha.repo  = "wings";
  inputs.src-wings-v0_0_2-alpha.type  = "github";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-wings-v0_0_2-alpha"];
  in lib.mkRefOutput {
    inherit self nixpkgs ;
    src  = deps."src-wings-v0_0_2-alpha";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  };
}