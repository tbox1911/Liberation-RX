params ["_vehicle"];
if (isNil "_vehicle") exitWith {};

removeAllActions _vehicle;
_pos = getPos _vehicle;

[_pos, 'normal','white'] remoteExec ["GRAD_fireworks_fnc_prepareFireworks", 2];
sleep 5;
[_pos, 'normal','blue'] remoteExec ["GRAD_fireworks_fnc_prepareFireworks", 2];
sleep 5;
[_pos, 'normal','red'] remoteExec ["GRAD_fireworks_fnc_prepareFireworks", 2];
sleep 6;

for "_i" from 1 to 3 do {
	[_pos, 'fizzer','random'] remoteExec ["GRAD_fireworks_fnc_prepareFireworks", 2];
	sleep 2;
};
sleep 6;

for "_i" from 1 to 3 do {
	[_pos, 'rain','random'] remoteExec ["GRAD_fireworks_fnc_prepareFireworks", 2];
	sleep 2;
};
sleep 6;

for "_i" from 1 to 8 do {
	[_pos, 'random','random'] remoteExec ["GRAD_fireworks_fnc_prepareFireworks", 2];
	sleep 2;
};
sleep 8;

for "_i" from 1 to 4 do {
	[_pos, 'fizzer','random'] remoteExec ["GRAD_fireworks_fnc_prepareFireworks", 2];
	sleep 2;
	[_pos, 'normal','random'] remoteExec ["GRAD_fireworks_fnc_prepareFireworks", 2];
	sleep 2;
};
sleep 8;

for "_i" from 1 to 4 do {
	[_pos, 'fizzer','random'] remoteExec ["GRAD_fireworks_fnc_prepareFireworks", 2];
	sleep 2;
	[_pos, 'rain','random'] remoteExec ["GRAD_fireworks_fnc_prepareFireworks", 2];
	sleep 2;
};
sleep 10;

for "_i" from 1 to 20 do {
	[_pos, 'random','random'] remoteExec ["GRAD_fireworks_fnc_prepareFireworks", 2];
	sleep 1 + random 2;
};

[_vehicle] remoteExec ["deleteVehicle", 2];