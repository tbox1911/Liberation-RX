// Initialize ACE

R3F_LOG_CFG_can_tow = [];
R3F_LOG_CFG_can_be_towed = [];
R3F_LOG_CFG_can_lift = [];
R3F_LOG_CFG_can_be_lifted = [];
R3F_LOG_CFG_can_transport_cargo = [];
R3F_LOG_CFG_can_be_transported_cargo = [];
R3F_LOG_CFG_can_be_moved_by_player = [];

call compileFinal preprocessFileLineNUmbers format ["R3F_LOG\addons_config\Liberation.sqf"];
call compileFinal preprocessFileLineNUmbers format ["mod_template\%1\classnames_r3f.sqf", GRLIB_mod_west];
call compileFinal preprocessFileLineNUmbers format ["mod_template\%1\classnames_r3f.sqf", GRLIB_mod_east];

GRLIB_cargoSpace = [];
GRLIB_cargoSize = [];
// Maxiumim size object can be liftable, will still be dragable.
GRLIB_maxLiftWeight = 10;

// Vehicles & Objects cargo space
GRLIB_cargoSpace = [R3F_LOG_CFG_can_transport_cargo, 2] call F_invertArray;
// Objects that can be transported with its size
GRLIB_cargoSize = [R3F_LOG_CFG_can_be_transported_cargo, 2] call F_invertArray;
// Objects that can be moved
GRLIB_movableObjects = [] + boats_names + R3F_LOG_CFG_can_be_moved_by_player;
// Adding each buildings to movableObjects	
{GRLIB_movableObjects pushback (_x select 0);} foreach buildings;

// R3F functions
call compile preprocessFile "R3F_LOG\fonctions_generales\lib_geometrie_3D.sqf";
R3F_LOG_FNCT_objet_deplacer = compile preprocessFile "R3F_LOG\objet_deplacable\deplacer.sqf";
