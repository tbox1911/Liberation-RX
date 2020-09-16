set_skill = compileFinal preprocessfilelinenumbers "scripts\shared\set_skill.sqf";
limit_skill = compileFinal preprocessFileLineNumbers "scripts\shared\limit_skill.sqf";

while { true } do {
	{ [_x] call set_skill } foreach ( [ allUnits, { local _x && !isplayer _x } ] call BIS_fnc_conditionalSelect );
	sleep 15;
};
