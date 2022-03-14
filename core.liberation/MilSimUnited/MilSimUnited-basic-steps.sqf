





Anpassungen für eine neue Liberation RX
------------------------------------------------------------------------------------------

\ui\mission_params.hpp

gameplay_constants.sqf

initServer.sqf: score loss on unconscious respawn and disconnect

\scripts\shared\fetch_params.sqf: Bug: GRLIB_fatigue und GRLIB_limited_arsenal have to be boolean
ca. 138: // ACE
if ( GRLIB_ACE_enabled ) then {	GRLIB_revive = 0; GRLIB_fatigue = true; GRLIB_fancy_info = 0; GRLIB_limited_arsenal = true; };  // Disable PAR/Fatigue/Fancy if ACE present


stringtable.xml: delete the following:
- You can sell the contents of vehicles near garages. 
- 4412: Remove "Only Weapons and Cargo is saved..."


mission.sqm:
Assign variable name chimeraofficer to something static


\scripts\client\misc\godmode.sqf:
deactivate VR Suit for admin


\scripts\client\build\do_build.sqf:
401: disable // A3 / R3F Inventory
433: who built the fob must be owner, to correct misplacement


\scripts\client\actions\do_repackage_fob.sqf:
ca. 13: commander must be able to repackage fob (using variable is_commander)
add condition (!is_commander)


\scripts\client\init_client.sqf: Initialise player handlers including get_in
ca. 46: [player] call player_EVH;
ca. 48: if on whitelist, then commander (variable is_commander)
ca. 105: comment virtual garage: [] execVM "addons\VIRT\virtual_garage_init.sqf";
ca. 106: comment trader shop: [] execVM "addons\SHOP\traders_shop_init.sqf";
ca. 157: comment chimera_sign addAction


\scripts\client\actions\action_manager.sqf: 
comment atm, shop, fuel, repair stuff
ca. 139: comment "|| _near_atm"
ca. 195: airdrop stuff
ca. 239: garage stuff: comment to disable
ca. 307: deploy fob only when is_commander
ca. 323: repackage fob only when is_commander
comment (player distance2D lhd) >= 1000 to do stuff near operation base
ca. 387: admin menu not only for is_admin but ( (is_commander) || (player == ( [] call F_getCommander ) || [] call is_admin) )
ca. 443: comment FOB Sign Actions


\scripts\client\actions\action_manager_veh.sqf: 
ca. 55: remove condition ([_this, _target] call is_owner) from vehicle actions
comment fuel action
disable STR_SELL_CARGO action 

******************************************************************************
Maybe useful later: 
_vehicle setVariable ["GRLIB_vehicle_owner", "", true];
_vehicle setVariable ["GRLIB_vehicle_owner", getPlayerUID player, true];

******************************************************************************


\scripts\client\actions\do_lock.sqf
comment _vehicle setVariable ["GRLIB_vehicle_owner", getPlayerUID player, true];


\scripts\server\game\manage_score.sqf:
ca. 44: //change perms ranks to permissions


\scripts\client\misc\set_rank.sqf:
same as above


\scripts\client\build\open_build_menu.sqf:
_iscommandant also for commander


\scripts\client\commander\admin_menu.sqf
ca. 44: comment map click teleport


\mod_template\RHS_USAF\classnames_west.sqf
/* 
RX permissions:
GRLIB_perm_inf
GRLIB_perm_log
GRLIB_perm_tank
GRLIB_perm_air
GRLIB_perm_max -> elite vehicles
*/


\mod_template\RHS_USAF\arsenal.sqf
blacklist stuff


\scripts\client\misc\init_markers.sqf: 
ca. 55: comment: markers
comment: "_x allowDamage false", "removeAllActions _vehicle"
add: [_vehicle, true] call ace_arsenal_fnc_initBox;


\addons\TAXI\call_taxi.sqf:
ca. 31: GRLIB_side_civilian -> GRLIB_side_friendly
allow damage
add arsenal
add jerrycan
remove lock
Go back if not boarded


\addons\PAR\PAR_EventHandler.sqf:
remove: InventoryClosed-handler for inventory value
remove: playsound "ZoomIn";
remove: InventoryOpened-handler


\scripts\client\actions\do_refuel.sqf
more fuel


\mod_template\RHS_USAF\loadout\player_set1.sqf
configure spawn loadout


\scripts\shared\default_classnames.sqf
default classes for boxes etc.


\scripts\shared\classnames.sqf: Airdrop etc.
\scripts\client\misc\drop_support.sqf: costs and permissions


\ui\liberation_airdrop.hpp:
comment "ButtonAir","LabelAir" stuff


\addons\PAR\PAR_fn_sortie.sqf:
add money bonus for medic


\scripts\server\ai\prisonner_captured.sqf:
add money bonus for capturer


\scripts\server\remotecall\intel_remote_call.sqf
add money bonus for POW to FOB


\scripts\shared\damage_manager.sqf
add money penalty for shooting friendly AI


\scripts\server\remotecall\sector_liberated_remote_call.sqf
money for sector


\scripts\client\misc\disable_remote_sensors.sqf:
disable hint


\scripts\server\base\huron_manager.sqf
disable


\scripts\client\spawn\redeploy_manager.sqf:
BASE CHIMERA -> Operation Base


\scripts\server\game\save_manager.sqf
ca. 349: _keep_score_id MUST be set


\scripts\client\misc\set_rank.sqf
correct bug because "None" is no legal rank in Arma
ca. 40:
if (_rank != "None") then {
	_unit setUnitRank _rank;
};


\addons\PAR\PAR_fn_death.sqf
\scripts\shared\kill_manager.sqf
amount of penalty for killing the wrong people
ca. 82: comment civ penalty because already fired by initServer.sqf


\scripts\client\ui\squad_management.sqf
disable refund calculation


\scripts\client\misc\send_ammo.sqf
min 20 score for send ammo


\scripts\client\misc\vehicle_permissions.sqf
ca. 42: comment the vehicle owner condition


\scripts\client\actions\do_recycle.sqf
ca. 42: remove && score player <= GRLIB_perm_log


\scripts\server\ai\bomber_ai.sqf
ca. 42: _unit addVest "V_TacChestrig_cbr_F";


\GREUH\GREUH_config.sqf
disable player markers etc.


\scripts\server\game\save_manager.sqf
ca. 366: evtl. wegen owner aufgedoppelt.


\addons\RPT\fn_repaintMenu.sqf
ca. 366: comment owner restriction


\addons\RPT\RPT_init.sqf
ca. 44: comment "Paint Shop Initialized"


\scripts\server\init_server.sqf
ca. 76: comment hall of fame


\scripts\client\actions\do_build_fob.sqf
ca. 26: no fob min dist from sector


\scripts\server\sector\manage_one_sector.sqf
ca. 22: _popfactor is multiplicator for spawns


\scripts\server\a3w\init_missions.sqf
ca. 12: sideMissionProcessor = "";  // compileFinal preprocessFileLineNumbers "scripts\server\a3w\missions\sideMissionProcessor.sqf";
NOPE!
scripts\server\a3w\missions\sideMissionProcessor.sqf
NOPE!
\scripts\server\a3w\missions\missionProcessor.sqf
ca. 8: exitwith {};


\scripts\client\spawn\redeploy_manager.sqf
ca. 48: comment bohemia loadout listing


\scripts\client\actions\open_arsenal.sqf
ca. 14: comment bohemia loadout listing


\scripts\server\sector\attack_in_progress_fob.sqf
ca. 51: private _countblufor_ownership = [_thispos, GRLIB_capture_size, GRLIB_side_friendly] call F_getUnitsCount;
add condition ( _countblufor_ownership < 3 )


------------------------------------------------------------------------------------------
Anpassungen für eine neue Liberation RX








Anpassungen für eine neue KP Liberation
------------------------------------------------------------------------------------------


initServer.sqf: Resourcen-Funktionen


scripts\server\remotecall\sector_liberated_remote_call.sqf
if (isServer) then { [] spawn gain_resources; []execVM "MilSimUnited\roadblocks.sqf" };


init.sqf: 
Klassen-Anpassungen für z.B. ACE-Cargo 
Advanced Towing und Sling Loading Config


Missionframework/scripts/client/build/do_build.sqf


kp_liberation_config.sqf


ui\mission_params.hpp


scripts\server\base\huron_manager.sqf: auskommentieren


presets\blufor\custom.sqf


scripts\client\actions\do_recycle.sqf
isKindOf "Car" etc. Recycle-Werte


stringtable.xml: "Tier 1- 4" als Fahrzeugbezeichnungen


ui/liberation_build.hpp: austauschen für "Tier 1- 4" Fahrzeug-Icons


scripts/client/build/do_build_fob.sqf:
_minfobdist = 1;
_minsectordist = 1;


initPlayerLocal.sqf: Regeln und Situation


Logo ersetzen: 
Statt "res/lib.paa" und "res/splash_libe2.paa" muss "res/MilSimUnited.paa" aufgerufen werden
	Dateiaufrufe ändern in:
		\description.ext
		ui\liberation_titles.hpp
		ui\liberation_menu.hpp
		
		
functions\curator\fn_initCuratorHandlers.sqf: Komplett auskommentieren


GUI nur noch auf Karte anzeigen: 
scripts\client\ui\ui_manager.sqf: durch den Modifizierten ersetzen


Notifications deaktivieren:
BIS_fnc_showNotification suchen und auskommentieren:
- scripts\client\remotecall\remote_call_sector.sqf





// Könnte Probleme machen, weil die Objekte zu Zeitpunkt x nicht im Netzwerk vorhanden sind ------------------------------

call KPLIB_fnc_createManagedUnit und KPLIB_fnc_spawnVehicle mit spawn ersetzen: 

Funktionssicher:
functions\fn_spawnRegularSquad.sqf
functions\fn_spawnBuildingSquad.sqf
functions\fn_spawnCivilians.sqf
functions\fn_spawnMilitaryPostSquad.sqf
scripts\server\ai\troup_transport.sqf
scripts\server\battlegroup\spawn_battlegroup.sqf
scripts\server\patrols\manage_one_civilian_patrol.sqf
scripts\server\patrols\manage_one_patrol.sqf
scripts\server\patrols\send_paratroopers.sqf


Alle Vorkommen:
functions\fn_forceBluforCrew.sqf
functions\fn_spawnBuildingSquad.sqf ------------------------------------ !
functions\fn_spawnCivilians.sqf --------------------------------------------- !
functions\fn_spawnGuerillaGroup.sqf
functions\fn_spawnMilitaryPostSquad.sqf ------------------------------ !
functions\fn_spawnMilitiaCrew.sqf
functions\fn_spawnRegularSquad.sqf
scripts\server\ai\troup_transport.sqf
scripts\server\battlegroup\spawn_battlegroup.sqf
scripts\server\civinformant\tasks\civinfo_task.sqf
scripts\server\patrols\manage_one_civilian_patrol.sqf
scripts\server\patrols\manage_one_patrol.sqf
scripts\server\patrols\send_paratroopers.sqf
scripts\server\secondary\convoy_hijack.sqf
scripts\server\secondary\fob_hunting.sqf
scripts\server\secondary\search_and_rescue.sqf
scripts\server\sector\attack_in_progress_fob.sqf
scripts\server\sector\attack_in_progress_sector.sqf

// Könnte Probleme machen, weil die Objekte zu Zeitpunkt x nicht im Netzwerk vorhanden sind ------------------------------









Useful snippets and console commands:
------------------------------------------------------------------------------------------
[] spawn gain_resources;
[] spawn lose_resources;



//SPAWN SUPPLYBOX CONSOLE:
params [["_resource", KP_liberation_supply_crate],["_amount", 100],["_pos", getPos player]];

private _crate = _resource createVehicle getPos player;
_crate setVariable ["KP_liberation_crate_value", 100, true]; 
clearWeaponCargoGlobal _crate; 
clearMagazineCargoGlobal _crate; 
clearBackpackCargoGlobal _crate; 
clearItemCargoGlobal _crate;

[_crate,3] call ace_cargo_fnc_setSize;
[_crate,3] call ace_cargo_fnc_setSpace;
["ACE_Wheel", _crate] call ace_cargo_fnc_addCargoItem;
["ACE_Track", _crate] call ace_cargo_fnc_addCargoItem;
_crate setVariable ["ACE_isRepairFacility",1];



//SPAWN AMMOBOX CONSOLE:
params [["_resource", KP_liberation_ammo_crate],["_amount", 100],["_pos", getPos player]];

private _crate = _resource createVehicle getPos player;
_crate setVariable ["KP_liberation_crate_value", 100, true]; 
clearWeaponCargoGlobal _crate; 
clearMagazineCargoGlobal _crate; 
clearBackpackCargoGlobal _crate; 
clearItemCargoGlobal _crate;

[_crate,3] call ace_cargo_fnc_setSize;
[_crate, 1200] call ace_rearm_fnc_makeSource;



//SPAWN FUELBOX CONSOLE:
params [["_resource", KP_liberation_fuel_crate],["_amount", 100],["_pos", getPos player]];

private _crate = _resource createVehicle getPos player;
_crate setVariable ["KP_liberation_crate_value", 100, true]; 
clearWeaponCargoGlobal _crate; 
clearMagazineCargoGlobal _crate; 
clearBackpackCargoGlobal _crate; 
clearItemCargoGlobal _crate;

[_crate,3] call ace_cargo_fnc_setSize;
[_crate, 1200] call ace_refuel_fnc_makeSource;



params [["_resource", KP_liberation_supply_crate],["_amount", 100],["_pos", getPos player]];



private _crate = _resource createVehicle getPos player; 
_crate setMass 500; 
_crate setVariable ["KP_liberation_crate_value", 100, true]; 
clearWeaponCargoGlobal _crate; 
clearMagazineCargoGlobal _crate; 
clearBackpackCargoGlobal _crate; 
clearItemCargoGlobal _crate;



addMissionEventHandler ["MapSingleClick", { 
    params ["", "_pos", "", ""]; 
    _marker = [allMapMarkers, _pos] call BIS_fnc_nearestPosition; 
    if (_marker in sectors_allSectors) then { 
        if (_marker in blufor_sectors) then { 
            blufor_sectors = blufor_sectors - [_marker]; 
        } else { 
            blufor_sectors = blufor_sectors + [_marker]; 
        }; 
        publicVariable "blufor_sectors"; 
    }; 
    removeMissionEventHandler ["MapSingleClick", _thisEventHandler]; 
    openMap [false, false]; 
}]; 
openMap [true, true];



// Serverseitige Nachricht:

hs_MPhint = { hint _this };
_hs_hint = format['Sexytime!']; 
[_hs_hint, 'hs_MPhint'] call BIS_fnc_mp;

_hs_hint = format['0: %1 | 1: %2 | 2: %3',_nearfob select 0, _nearfob select 1, _nearfob select 2];
OR
_hs_hint = format['_crate: %1', typeOf _crate];
[_hs_hint, 'hs_MPhint'] call BIS_fnc_mp;



// Do something to player
{ 
 if ( name _x == "Huber Sepp" ) then { 
  [_x, -601] remoteExec ["addScore", 2]; 
  _x setVariable ["GREUH_ammo_count", -1, true]; 
 }; 
} forEach allPlayers;



// Arsenal
	[_vehicle, true] call ace_arsenal_fnc_initBox;
	[_vehicle, blacklisted_weapon] call ace_arsenal_fnc_removeVirtualItems;


	
// Everything
["rhs_kamaz5350_ammo_vmf", "InitPost", {
    params ["_vehicle"];
	[_vehicle,12] call ace_cargo_fnc_setSpace;
	[_vehicle, 150000] call ace_rearm_fnc_makeSource;
    [_vehicle, 15000] call ace_refuel_fnc_makeSource;
	_vehicle setVariable ["ACE_isRepairVehicle",1];
	[_vehicle, true] call ace_arsenal_fnc_initBox;
	[_vehicle, blacklisted_weapon] call ace_arsenal_fnc_removeVirtualItems;
}, nil, nil, true] call CBA_fnc_addClassEventHandler;



// Load box
private _can = createVehicle [canisterFuel, [0, 0, 0], [], 0, "NONE"];
[_can, _vehicle, true] call ace_cargo_fnc_loadItem;




//[AiCacheDistance(players),TargetFPS(-1 for Auto),Debug,CarCacheDistance,AirCacheDistance,BoatCacheDistance]execvm "zbe_cache\main.sqf";
if (isServer) then {[2000,-1,false,100,1000,100]execvm "zbe_cache\main.sqf"};




resources_intel = 99;

combat_readiness = 99;



GRLIB_permissions
und auf server

GRLIB_permissions = [HIER DAS ARRAY EINFÜGEN]
global ausführen







