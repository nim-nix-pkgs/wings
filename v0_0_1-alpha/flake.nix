{
  description = ''A simple cross language struct and enum file generator.'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-wings-v0_0_1-alpha.flake = false;
  inputs.src-wings-v0_0_1-alpha.ref   = "refs/tags/v0.0.1-alpha";
  inputs.src-wings-v0_0_1-alpha.owner = "binhonglee";
  inputs.src-wings-v0_0_1-alpha.repo  = "wings";
  inputs.src-wings-v0_0_1-alpha.type  = "github";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-wings-v0_0_1-alpha"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-wings-v0_0_1-alpha";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}