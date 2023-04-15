#include "\A3\Ui_f\hpp\defineResinclDesign.inc"

if ( hasInterface ) then {
	[ missionNamespace, "arsenalOpened", {
	    disableSerialization;
	    _display = _this select 0;
		
		//diag_log "arsenalOpened SEH called";
		_center = BIS_fnc_arsenal_center;
		_cargo = BIS_fnc_arsenal_cargo;

		_virtualItemCargo =
			(missionNamespace call BIS_fnc_getVirtualItemCargo) +
			(_cargo call BIS_fnc_getVirtualItemCargo) +
			items _center +
			assignedItems _center +
			primaryWeaponItems _center +
			secondaryWeaponItems _center +
			handgunItems _center +
			[uniform _center,vest _center,headgear _center,goggles _center];
			
		_virtualWeaponCargo = [];
		{
			if !( isNil _x || { _x == "%ALL" || _x == "" } ) then {
				_weapon = _x call BIS_fnc_baseWeapon;
				_virtualWeaponCargo set [count _virtualWeaponCargo,_weapon];
				{
					private ["_item"];
					_item = getText (_x >> "item");
					if !(_item in _virtualItemCargo) then {
						_virtualItemCargo set [ count _virtualItemCargo, _item ];
					};
				} forEach ((configFile >> "cfgweapons" >> _x >> "linkeditems") call BIS_fnc_returnChildren);
			}else{
				_virtualWeaponCargo set [ count _virtualWeaponCargo, _x ];
			};
		} forEach ((missionNamespace call BIS_fnc_getVirtualWeaponCargo) + (_cargo call BIS_fnc_getVirtualWeaponCargo) + weapons _center + [binocular _center]);
			
		_virtualMagazineCargo = (missionNamespace call BIS_fnc_getVirtualMagazineCargo) + (_cargo call BIS_fnc_getVirtualMagazineCargo) + magazines _center;
		_virtualBackpackCargo = (missionNamespace call BIS_fnc_getVirtualBackpackCargo) + (_cargo call BIS_fnc_getVirtualBackpackCargo) + [backpack _center];
		
		_virtualCargo = [];
		{
			_cargo = _x;
			{
				if !( _x == "" ) then {
					_cargo set [ _forEachIndex, ( toLower _x ) ];
				};
				if ( _x == "%all" ) exitWith {
					_cargo = [ "%all" ];
				};
			}forEach _cargo;
			_cargo = _cargo - [ "" ];
			_nul = _virtualCargo set [ _forEachIndex, _cargo ];
		}forEach [
			_virtualItemCargo,
			_virtualWeaponCargo,
			_virtualMagazineCargo,
			_virtualBackpackCargo
		];
		
		[_display] call compileFinal preprocessFileLineNumbers "addons\LARs\blacklistArsenal\functions\override\fn_addVAKeyEvents.sqf";
	} ] call BIS_fnc_addScriptedEventHandler;

	[ missionNamespace, "arsenalClosed", {
		[player] call F_filterLoadout;
		[player] spawn F_payLoadout;
	} ] call BIS_fnc_addScriptedEventHandler;
};