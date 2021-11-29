// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: towns.sqf
//	@file Author: AgentRev, JoSchaap
//	LRX Integration: pSiKO
/*
private _towns =
[
	["bigtown9",-1,"Kavala"],
	["bigtown8",-1,"Zaros"],
	["bigtown7",-1,"Agios Dionysios"],
	["bigtown4",-1,"Pyrgos"],
	["bigtown3",-1,"Paros"],
	["bigtown1",-1,"Molos"],
	["bigtown6",-1,"Athira"]
];
//copyToClipboard str ((allMapMarkers select {_x select [0,5] == "Town_"}) apply {[_x, -1, markerText _x]})
*/

private _towns = ((allMapMarkers select {_x select [0,7] == "bigtown"}) apply {[_x, -1, markerText _x]});
{
	_x params ["_marker"];

	if (markerShape _marker == "ELLIPSE") then
	{
		private _size = markerSize _marker;
		_x set [1, (_size select 0) min (_size select 1)];
	};
} forEach _towns;

_towns
