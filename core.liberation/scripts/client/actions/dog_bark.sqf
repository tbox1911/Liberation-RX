params [ "_my_dog", "_tone" ];
if (isNil "_my_dog") exitWith {};

private _sound = format ["a3\sounds_f\ambient\animals\%1", _tone select 0];
private _pitch = _tone select 1;
playSound3D [_sound, _my_dog, false, getPosASL _my_dog, 5, _pitch, 250];

_my_dog switchMove "Dog_Idle_Bark";
_my_dog playMoveNow "Dog_Idle_Bark";
