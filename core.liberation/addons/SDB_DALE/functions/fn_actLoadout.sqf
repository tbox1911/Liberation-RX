scriptName _fnc_scriptName;
if (!hasInterface) exitWith {};

private _veh = param [0,objNull,[objNull]];

if (!isNil {_veh getVariable "DALE_var_IDLoadout"}) exitWith {};

private _cfgComponent = configFile >> "CfgVehicles" >> typeOf _veh >> "Components" >> "TransportPylonsComponent";

if (!isClass _cfgComponent) exitWith {};

//private _vehType = ["LandVehicle","Ship","Helicopter","Plane"] findIf {_veh isKindOf _x};
//private _actionCond = format [" and {((EVOR_list_BaseService select %1) findIf {_target distance _x < 25} >= 0)}",_vehType];
//_actionCond = format ["(isTouchingGround _target) and {(driver _target isEqualTo _this) and {(speed _target < 1)%1}}",_actionCond];

if (!(_veh isKindOf "Plane")) exitWith {};

_fobdistance = round (player distance2D ([] call F_getNearestFob));

private _actionCond = "(isTouchingGround _target) && (driver _target isEqualTo _this) && (speed _target < 1) && round (_target distance2D ([] call F_getNearestFob)) < 100";
private _actionText = "STR_DALE_Actions_Loadout" call BIS_fnc_localize;

private _actionID = _veh addAction ["",DALE_fnc_dlgLoadoutOpen,nil,20,true,true,"",_actionCond];
_veh setUserActionText [_actionID,_actionText,"<t size='2.5'><img image='a3\ui_f\data\IGUI\Cfg\Actions\reammo_ca.paa'/></t>"];

_veh setVariable ["DALE_var_IDLoadout",[_actionID],false];
