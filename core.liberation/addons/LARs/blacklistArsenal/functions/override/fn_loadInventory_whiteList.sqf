
#include "\A3\Ui_f\hpp\defineResinclDesign.inc"
#include "macros.hpp"

diag_log "LoadInventory WhiteList";

#define DEFAULT_SLOT 0
#define MUZZLE_SLOT 101
#define OPTICS_SLOT 201
#define FLASHLIGHT_SLOT 301
#define FIRSTAIDKIT_SLOT 401
#define FINS_SLOT 501
#define BREATHINGBOMB_SLOT 601
#define NVG_SLOT 602
#define GOGGLE_SLOT 603
#define SCUBA_SLOT 604
#define HEADGEAR_SLOT 605
#define UNIFORM_SLOT 801
#define FACTOR_SLOT 607

#define HMD_SLOT       616
#define BINOCULAR_SLOT 617
#define MEDIKIT_SLOT   619
#define RADIO_SLOT    611

#define VEST_SLOT      701
#define BACKPACK_SLOT  901


scopeName "LARs_fnc_loadInventory_whiteList";

private ["_cfg","_inventory","_isCfg","_whiteList"];

_object = _this param [0,objNull,[objNull]];

_cfg = _this param [1,configFile,[configFile,"",[]]];
_inventory = [];
private ["_namespace","_name","_data","_nameID"];
_namespace = _cfg param [0,missionNamespace,[missionNamespace,grpNull,objNull]];
_name = _cfg param [1,"",[""]];
_data = _namespace getVariable ["bis_fnc_saveInventory_data",[]];
_nameID = _data find _name;
if (_nameID >= 0) then {
	_inventory = _data select (_nameID + 1);
	_cfg = [_inventory];
} else {
	["Inventory '%1' not found",_name] call BIS_fnc_error; breakOut "LARs_fnc_loadInventory_whiteList";
};

_whiteList = _this param [2,[],[[]]];

_msg = format[ "LoadInventory: WL: %1", _whiteList ];
diag_log _msg;

//--- Send to where the object is local (weapons can be changed only locally)
if !(local _object) exitWith {[[_object,_cfg,_whiteList],"LARs_fnc_loadInventory_whiteList",_object] call BIS_fnc_MP; false};

//--- Process items
private ["_vest","_headgear","_goggles"];
_vest = "";
_headgear = ""; //--- Added as assigned item
_goggles = ""; //--- Added as assigned item

_vest = _inventory select 1 select 0;
_headgear = _inventory select 3;
_goggles = _inventory select 4;
//--- Do isNil check because weaponAccessories command can return nil
_linkedItemsMisc = [ (_inventory select 9) ];
if (!isNil {_inventory select 6 select 1}) then {
	_linkedItemsMisc = _linkedItemsMisc + [ _inventory select 6 select 1 ]
} else {
	_linkedItemsMisc = _linkedItemsMisc + [ ["","",""] ];
};
if (!isNil {_inventory select 7 select 1}) then {
	_linkedItemsMisc = _linkedItemsMisc + [ _inventory select 7 select 1 ]
} else {
	_linkedItemsMisc = _linkedItemsMisc + [ ["","",""] ];
};
if (!isNil {_inventory select 8 select 1}) then {
	_linkedItemsMisc = _linkedItemsMisc + [ _inventory select 8 select 1 ]
} else {
	_linkedItemsMisc = _linkedItemsMisc + [ ["","",""] ];
};

//--- Remove
removeUniform _object;
removeVest _object;
removeHeadgear _object;
removeGoggles _object;
removeBackpack _object;
removeAllItems _object;
removeAllAssignedItems _object;
removeAllWeapons _object;

_notification = "Certain items in the selected loadout<br />are not allowed and have been removed<br />";
_notAllowed = false;

//--- Add

//UNIFORM
_uniform = _inventory select 0 select 0;
if ( _uniform != "" ) then {
	if ( CONDITION( _uniform ) ) then {
		if (isClass (configFile >> "cfgWeapons" >> _uniform)) then {
			_object forceAddUniform _uniform;
		} else {
			["Uniform '%1' does not exist in CfgWeapons",_uniform] call BIS_fnc_error;
		};
	}else{
		_notAllowed = true;
		_notification = format[ "%1<br />%2 - %3", _notification, "Uniform", _uniform ];
	};
};

//VEST
if ( _vest != "" ) then {
	if ( CONDITION( _vest ) ) then {
		if (isClass (configFile >> "cfgWeapons" >> _vest)) then {
			_object addVest _vest;
		} else {
			["Vest '%1' does not exist in CfgWeapons",_vest] call BIS_fnc_error;
		};
	}else{
		_notAllowed = true;
		_notification = format[ "%1<br />%2 - %3", _notification, "Vest", _vest ];
	};
};

//HEADGEAR
if ( _headgear != "" ) then {
	if ( CONDITION( _headgear ) ) then {
		if (isClass (configFile >> "cfgWeapons" >> _headgear)) then {
			_object addHeadgear _headgear;
		} else {
			["Headgear '%1' does not exist in CfgWeapons",_headgear] call BIS_fnc_error;
		};
	}else{
		_notAllowed = true;
		_notification = format[ "%1<br />%2 - %3", _notification, "Headgear", _headgear ];
	};
};

//GOGGLES
if ( _goggles != "" ) then {
	if ( CONDITION( _goggles ) ) then {
		if (isClass (configFile >> "cfgGlasses" >> _goggles)) then {
			_object addGoggles _goggles;
		} else {
			["Goggles '%1' does not exist in CfgGlasses",_goggles] call BIS_fnc_error;
		};
	}else{
		_notAllowed = true;
		_notification = format[ "%1<br />%2 - %3", _notification, "Goggles", _goggles ];
	};
};

//BACKPACK
_backpack = _inventory select 2 select 0;
if ( _backpack != "" ) then {
	if ( CONDITION( _backpack ) ) then {
		if (isClass (configFile >> "cfgVehicles" >> _backpack)) then {
			_object addBackpack _backpack;
				
			// Default backpacks have default loadouts. Must be cleared if not loaded from config.
			clearAllItemsFromBackpack _object;
		} else {
			["Backpack '%1' does not exist in CfgVehicles",_backpack] call BIS_fnc_error;
		};
	}else{
		_notAllowed = true;
		_notification = format[ "%1<br />%2 - %3", _notification, "Backpack", _backpack ];
	};
};

//WEAPON MAGAZINES
{
	if (_x != "" ) then {
		if ( CONDITION( _x ) ) then {
			_object addMagazine _x;
		}else{
			_notAllowed = true;
			_notification = format[ "%1<br />%2 - %3", _notification, "Magazine", _x ];
		};
	};
} forEach [_inventory select 6 select 2,_inventory select 7 select 2,_inventory select 8 select 2];

//WEAPONS
{
	if ( _x != "" ) then {
		if ( CONDITION( _x ) ) then {
			_object addWeapon _x;
		}else{
			_notAllowed = true;
			_notification = format[ "%1<br />%2 - %3", _notification, "Weapon", _x ];
		};
	};
} forEach [_inventory select 5,_inventory select 6 select 0,_inventory select 7 select 0,_inventory select 8 select 0];
	
//WEAPON & LINKED - ITEMS
{
	_weaponType = _forEachIndex;
	{
		if ( _x != "" ) then {
			if ( CONDITION( _x ) ) then {
				switch ( _weaponType ) do {
					//linked items
					case 0 : {
						_object linkItem _x;
					};
					//primary
					case 1 : {
						_object addPrimaryWeaponItem _x;
					};
					//secondary
					case 2 : {
						_object addSecondaryWeaponItem _x;
					};
					//handgun
					case 3 : {
						_object addHandgunItem _x;
					};
				};
			}else{
				_notAllowed = true;
				_item = [ "Item", "Primary Weapon Item", "Secondary Weapon Item", "Handgun Item" ] select _weaponType;
				_notification = format[ "%1<br />%2 - %3", _notification, _item, _x ];
			};
		};
	}forEach _x;
} forEach _linkedItemsMisc;

//UNIFORM ITEMS
{
	if ( CONDITION( _x ) ) then {
		_object addItemToUniform _x;
	}else{
		_notAllowed = true;
		_notification = format[ "%1<br />%2 - %3", _notification, "Uniform Item", _x ];
	};
} forEach (_inventory select 0 select 1);

//VEST ITEMS
{
	if ( CONDITION( _x ) ) then {
		_object addItemToVest _x;
	}else{
		_notAllowed = true;
		_notification = format[ "%1<br />%2 - %3", _notification, "Vest Item", _x ];
	};
} forEach (_inventory select 1 select 1);
	
//BACKPACK ITEMS
{
	if ( CONDITION( _x ) ) then {
		_object addItemToBackpack _x;
	}else{
		_notAllowed = true;
		_notification = format[ "%1<br />%2 - %3", _notification, "Backpack Item", _x ];
	};
} forEach (_inventory select 2 select 1);


//_showNotification = getMissionConfigValue[ "LARs_overrideVA_showMsg", 0 ];
//if !( isNil { missionNamespace getVariable "LARs_overrideVA_msgThread" } ) then {
//	disableSerialization;
//	_display = uiNamespace getVariable "RscDisplayArsenal";
//	_ctrlGrp = ( missionNamespace getVariable "LARs_overrideVA_msgCtrls" ) deleteAt 0;
//	{
//		_ctrl = _display displayCtrl _ctrlGrp controlsGroupCtrl _x;
//		ctrlDelete _ctrl;
//	}forEach ( missionNamespace getVariable "LARs_overrideVA_msgCtrls" );
//	ctrlDelete ( _display displayCtrl _ctrlGrp );
//
//	terminate ( missionNamespace getVariable "LARs_overrideVA_msgThread" );
//};
//if ( _showNotification > 0 && { _notAllowed isEqualTo true } ) then {
//	missionNamespace setVariable [ "LARs_overrideVA_msgThread", [ _notification, _showNotification ] spawn {
//		disableSerialization;
//		params[ "_notification", "_showNotification" ];
//		_display = uiNamespace getVariable "RscDisplayArsenal";
//		
//		_ctrlGrp = _display ctrlCreate [ "RscControlsGroup", 1000 ];
//		_ctrlGrp ctrlSetPosition[ 0, 0, 0.5, 0.5 ];
//		_ctrlGrp ctrlCommit 0;
//		_pic = _display ctrlCreate [ "RscPicture", 1001, _ctrlGrp ];
//		_pic ctrlSetPosition[ 0, 0, 0.5, 2 ];
//		_pic ctrlCommit 0;
//		_pic ctrlSetText "#(rgb,8,8,3)color(0.2,0.2,0.2,1)";
//		_ctrl = _display ctrlCreate [ "RscStructuredText", 1002, _ctrlGrp ];
//		_ctrl ctrlSetPosition[ 0, 0, 0.5, 2 ];
//		_ctrl ctrlCommit 0;
//		_ctrl ctrlSetStructuredText parseText _notification;
//		missionNamespace setVariable [ "LARs_overrideVA_msgCtrls", [ ctrlIDC _ctrlGrp, ctrlIDC _pic, ctrlIDC _ctrl ] ];
//		uiSleep _showNotification;
//		ctrlDelete _ctrl;
//		ctrlDelete _pic;
//		ctrlDelete _ctrlGrp;
//	}];
//};

if ( _notAllowed ) then {
	_notification
}else{
	""
};
