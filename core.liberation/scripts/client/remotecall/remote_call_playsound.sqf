params ["_sound", "_source", "_inside", "_source_pos", "_volume", "_pitch", "_distance"];

if ([player] call PAR_is_wounded) exitWith {};
playSound3D [_sound, _source, _inside, _source_pos, _volume, _pitch, _distance, 0, true];
