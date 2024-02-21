systemchat "build def!";

// copy dialog _sell
// format [ "full name", "filename"]
// get fobpos source template
// build _objects_to_build


private _template_selected = "scripts\fob_templates\defense1.sqf";
private _template = ([] call compile preprocessFileLineNumbers _template_selected);
private _template_name =  _template select 0;
private _objects_to_build = _template select 1;
private _base_position = [] call F_getNearestFob;

systemchat format ["Build defense %1 on FOB %2 ", _template_name, ([_base_position] call F_getFobName)];

private ["_nextclass", "_nextobject", "_nextpos", "_nextdir"];
{
	_nextclass = _x select 0;
	_nextpos = _x select 1;
	_nextpos = [((_base_position select 0) + (_nextpos select 0)),((_base_position select 1) + (_nextpos select 1)),0];
	_nextdir = _x select 2;

	_nextobject = _nextclass createVehicle _nextpos;
    _nextobject allowDamage false;
    _nextobject setPosATL _nextpos;
    if (_nextclass isKindOf "HBarrier_base_F") then {
        _nextobject setVectorDirAndUp [[-cos _nextdir, sin _nextdir, 0] vectorCrossProduct surfaceNormal _nextpos, surfaceNormal _nextpos];
     } else {
        _nextobject setVectorDirAndUp [[_nextdir, _nextdir, 0], [0,0,1]];
    };
    sleep 0.3;
	//_base_objects pushBack _nextobject;
} foreach _objects_to_build;

