params ["_text", "_pos"];

private _marker = createMarkerLocal [format ["side_mission_civ_%1", _text], _pos];
_marker setMarkerShapeLocal "ELLIPSE";
_marker setMarkerBrushLocal "FDiagonal";
_marker setMarkerSizeLocal [20,20];
_marker setMarkerColor GRLIB_color_civilian;

_marker;