waitUntil { sleep 1; !(isNil "resources_infantry") };

GRLIB_player_admin_actions = [];
GRLIB_player_vehicle_actions = [];
GRLIB_player_dog_actions = [];
GRLIB_player_squad_actions = [];

// Tuto
private _icon_tuto = "\a3\ui_f\data\map\markers\handdrawn\unknown_ca.paa";
player addAction ["<t color='#80FF80'>" + localize "STR_TUTO_ACTION" + "</t> <img size='1' image='" + _icon_tuto + "'/>","[] execVM 'scripts\client\ui\tutorial_manager.sqf'","",-740,false,true,"","(_target distance2D lhd < GRLIB_fob_range)"];

// Admin Menu
if ([] call is_admin) then { [true] call player_admin_actions };

// Extended Options
player addAction ["<t color='#FF8000'>" + localize "STR_EXTENDED_OPTIONS" + "</t>","GREUH\scripts\GREUH_dialog.sqf","",-999,false,true];

// Dog - Actions
private _my_dog = player getVariable ["my_dog", nil];
if (!isNil "_my_dog") then { [true] call player_dog_actions };

// Squad - Actions
private _my_squad = player getVariable ["my_squad", nil];
if (!isNil "_my_squad") then { [true] call player_squad_actions };

// Support vehicle
player addAction ["<t color='#0080F0'>" + localize "STR_VEH_SUPPORT" + "</t> <img size='1' image='res\ui_veh.paa'/>","scripts\client\actions\do_support.sqf","",997,false,true,"","call GRLIB_checkVehicleSupport"];

// Redeploy
player addAction ["<t color='#80FF80'>" + localize "STR_DEPLOY_ACTION" + "</t> <img size='1' image='res\ui_redeploy.paa'/>","scripts\client\spawn\redeploy_manager.sqf","",-300,false,true,"","call GRLIB_checkRedeploy"];

// Halo Jump
player addAction ["<t color='#80FF80'>" + localize "STR_HALO_ACTION" + "</t> <img size='1' image='res\ui_redeploy.paa'/>","scripts\client\spawn\do_halo.sqf","",-301,false,true,"","call GRLIB_checkHalo"];

// Send Ressource
player addAction ["<t color='#80FF00'>" + localize "STR_SEND_RSC" + "</t> <img size='1' image='res\ui_arsenal.paa'/>","scripts\client\actions\do_send_ammo.sqf","",-981,true,true,"","call GRLIB_checkSendAmmo"];

// Buy Fuel
player addAction ["<t color='#00F080'>" + localize "STR_BUY_FUEL" + "</t> <img size='1' image='\A3\ui_f\data\map\mapcontrol\Fuelstation_CA.paa'/>", "scripts\client\actions\do_buy_fuel.sqf","",-900,true,true,"","call GRLIB_checkBuyFuel"];

// Heal Self
//player addAction ["<img size='1' image='\a3\ui_f\data\igui\cfg\simpletasks\types\Heal_ca.paa'/>" + localize "STR_HEAL_SELF_ACTION", { (_this select 1) playMove "AinvPknlMstpSlayWnonDnon_medic"; (_this select 1) setDamage 0;},"",999,true,true,"", "call GRLIB_checkHeal"];

// Trench Menu
player addAction ["<t color='#FFFF00'>" + localize "STR_BUILD_TRENCH_ACTION" + "</t> <img size='1' image='\a3\ui_f\data\IGUI\Cfg\Actions\Obsolete\ui_action_turnin_ca'/>","scripts\client\build\open_build_menu.sqf",true,-300,false,true,"","call GRLIB_checkBuildTrench"];

// UnPack Beacon
player addAction ["<t color='#FFFF00'>" + localize "STR_UNPACK_BEACON" + "</t> <img size='1' image='res\ui_deployfob.paa'/>","scripts\client\actions\do_beacon_unpack.sqf","",-950,false,true,"","call GRLIB_checkUnpackBeacon"];

// Air Drop
player addAction ["<t color='#00F0F0'>" + localize "STR_AIR_SUPPORT" + "</t> <img size='1' image='R3F_LOG\icons\r3f_drop.paa'/>","scripts\client\misc\drop_support.sqf","",-980,false,true,"","call GRLIB_checkAirDrop"];

// Personal Arsenal
if (GRLIB_filter_arsenal == 4) then {
    player addAction ["<t color='#FFFF00'>" + localize "STR_ARSENAL_OPEN" + "</t> <img size='1' image='res\ui_arsenal.paa'/>","scripts\client\actions\open_personal_arsenal.sqf","",-401,true,true,"","call GRLIB_checkArsenalPerso"];
    player addAction ["<t color='#00FFFF'>" + localize "STR_ARSENAL_UNPACK" + "</t> <img size='1' image='res\ui_arsenal.paa'/>","scripts\client\actions\unpack_personal_arsenal.sqf","",-402,false,true,"","call GRLIB_checkArsenalPerso"];
} else {
    // Classic Arsenal
    player addAction ["<t color='#FFFF00'>" + localize "STR_ARSENAL_OPEN" + "</t> <img size='1' image='res\ui_arsenal.paa'/>","scripts\client\actions\open_arsenal.sqf","",-401,true,true,"","call GRLIB_checkArsenal"];
};
