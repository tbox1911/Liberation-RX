params ["_vehicle"];
if (isNil "_vehicle") exitWith {};

if (!([player, _vehicle] call is_owner)) exitWith { hintSilent "Wrong Vehicle Owner.\nAccess is Denied !" };
if ((damage _vehicle) != 0) exitWith { hintSilent "Damaged Vehicles cannot be Painted !" };
if ([typeOf _vehicle, GRLIB_vehicle_blacklist] call F_itemIsInClass) exitWith { hintSilent "This Vehicle cannot be Painted !" };

[_vehicle, clientOwner] remoteExec ["setOwner", 2];
waitUntil { sleep 0.2; local _vehicle };

VAM_targetvehicle = _vehicle;
createDialog 'VAM_GUI';
waitUntil { dialog };

VAM_arsenal_item_text = {
	if (isNil "VAM_arsenal_item") exitWith { "" };
	if (count VAM_arsenal_item == 0) exitWith { "" };
	private _id = VAM_arsenal_item select 1;
	(VAM_arsenal_class_names select _id);
};

private _VAM_display = findDisplay 4900;
private _list_arsenal = _VAM_display displayCtrl 4921;
private _veh_free_cap = _VAM_display displayCtrl 4922;
private _msg = "";

while { dialog && alive player } do {
	_list_arsenal ctrlSetTooltip ([] call VAM_arsenal_item_text);
	_msg = format ["%1kg - %2%3",(maxLoad _vehicle - loadAbs _vehicle), (1-(load _vehicle)*100), "%" ];
	_veh_free_cap ctrlSetText _msg;

	sleep 0.3;
};
