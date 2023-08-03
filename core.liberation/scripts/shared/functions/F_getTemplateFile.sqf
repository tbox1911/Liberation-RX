params ["_path", ["_args", objNull]];
if (isNil "_path") exitWith {};

private _template_name = _path splitString "\" select 1;

if (_template_name in (LRX_mod_list_west + LRX_mod_list_east)) then {
	[_path, _args] call LRX_Template_fnc_readfile;
} else {
	[_args] call compileFinal preprocessFileLineNumbers _path; 
};
