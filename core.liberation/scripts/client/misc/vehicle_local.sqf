params ["_vehicle"];

if (!local _vehicle) then {
	[_vehicle, clientOwner] remoteExec ["setOwner", 2];
	systemchat "Vehicle is not local, transfer request from server...";
	waitUntil { sleep 0.1; local _vehicle };
};