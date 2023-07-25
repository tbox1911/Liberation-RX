// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: getBallMagazine.sqf
//	@file Author: AgentRev
//	@file Created: 30/06/2013 15:06

private ["_mag", "_magCfg"];

_mag = _this;
_magCfg = configFile >> "CfgMagazines" >> _mag;

if (isClass _magCfg) then
{
	// Fix case
	_mag = configName (_magCfg);

	while { (configName _magCfg) find '_Tracer' > 0} do	{
		_magCfg = inheritsFrom _magCfg;
	};

	if (isClass _magCfg) then {
		_mag = configName (_magCfg);
	};
};

_mag
