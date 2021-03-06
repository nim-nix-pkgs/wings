{
  description = ''A simple cross language struct and enum file generator.'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-wings-v0_0_7-alpha.flake = false;
  inputs.src-wings-v0_0_7-alpha.ref   = "refs/tags/v0.0.7-alpha";
  inputs.src-wings-v0_0_7-alpha.owner = "binhonglee";
  inputs.src-wings-v0_0_7-alpha.repo  = "wings";
  inputs.src-wings-v0_0_7-alpha.type  = "github";
  
  inputs."stones".owner = "nim-nix-pkgs";
  inputs."stones".ref   = "master";
  inputs."stones".repo  = "stones";
  inputs."stones".dir   = "devel";
  inputs."stones".type  = "github";
  inputs."stones".inputs.nixpkgs.follows = "nixpkgs";
  inputs."stones".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-wings-v0_0_7-alpha"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-wings-v0_0_7-alpha";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}