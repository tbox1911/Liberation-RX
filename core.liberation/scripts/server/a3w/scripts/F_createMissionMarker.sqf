// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: createMissionMarker.sqf
//	@file Author: AgentRev
//	LRX Integration: pSiKO

params ["_text", "_pos"];

private _marker = createMarker [format ["side_mission_%1", _text], _pos];
_marker setMarkerType "mil_destroy";
_marker setMarkerSize [1.25, 1.25];
_marker setMarkerColor "ColorRed";
_marker setMarkerText _text;
_marker
