params ["_text", "_pos", "_precise"];

private _marker_zone = "";
private _marker = createMarkerLocal [format ["side_mission_%1", _text], _pos];
if (_precise) then {
	_marker setMarkerTypeLocal "mil_destroy";
	_marker setMarkerSizeLocal [1.25, 1.25];
} else {
	_pos = ([_pos, 250] call F_getRandomPos);
	_marker setMarkerPosLocal (_pos getPos [200, 270]);
	_marker setMarkerTypeLocal "EmptyIcon";
	_marker_zone = createMarkerLocal [format ["side_mission_%1_zone", _text], _pos];
	_marker_zone setMarkerShapeLocal "ELLIPSE";
	_marker_zone setMarkerBrushLocal "FDiagonal";
	_marker_zone setMarkerSizeLocal [500,500];
	_marker_zone setMarkerColor "colorOPFOR";
};

_marker setMarkerShadowLocal true;
_marker setMarkerTextLocal (localize _text);
_marker setMarkerColor "ColorRed";

[_marker, _marker_zone];