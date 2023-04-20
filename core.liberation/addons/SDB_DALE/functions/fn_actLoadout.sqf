scriptName _fnc_scriptName;
if (!hasInterface) exitWith {};

private _veh = param [0,objNull,[objNull]];

if (!isNil {_veh getVariable "DALE_var_IDLoadout"}) exitWith {};

private _cfgComponent = configFile >> "CfgVehicles" >> typeOf _veh >> "Components" >> "TransportPylonsComponent";

if (!isClass _cfgComponent) exitWith {};
if (!(_veh isKindOf "Air")) exitWith {};

private _actionCond = "(isTouchingGround _target) && (driver _target isEqualTo _this) && (speed _target < 1) && ([player, 'REAMMO', 30, true] call F_check_near || (player distance2D lhd) <= 200 )";
private _actionText = localize "STR_DALE_Actions_Loadout";

private _actionID = _veh addAction ["",DALE_fnc_dlgLoadoutOpen,nil,20,true,true,"",_actionCond];
_veh setUserActionText [_actionID,_actionText,"<t size='2.5'><img image='a3\ui_f\data\IGUI\Cfg\Actions\reammo_ca.paa'/></t>"];

_veh setVariable ["DALE_var_IDLoadout",[_actionID],false];
