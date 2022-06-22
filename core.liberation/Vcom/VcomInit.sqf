//Parameters
VCM_PublicScript = compileFinal "[] call (_this select 0);";
VCM_ServerAsk = compileFinal "(_this select 1) publicVariableClient (_this select 0);";

if (isServer) then
{
	if (isFilePatchingEnabled) then
	{
		private _Filecheck = loadFile "\userconfig\VCOM_AI\AISettingsV3.hpp";

		if !(_FileCheck isEqualTo "") then
		{
			[] call compile preprocessFileLineNumbers "\userconfig\VCOM_AI\AISettingsV3.hpp";
			[Vcm_Settings] remoteExec ["VCM_PublicScript",0,false];
		}
		else
		{
			[] call compile preprocessFileLineNumbers "Vcom\Functions\VCOMAI_DefaultSettings.sqf";
			[Vcm_Settings] remoteExec ["VCM_PublicScript",0,false];
		};
	}
	else
	{
			[] call compile preprocessFileLineNumbers "Vcom\Functions\VCOMAI_DefaultSettings.sqf";
			[Vcm_Settings] remoteExec ["VCM_PublicScript",0,false];
	};
}
else
{
	private _id = clientOwner;
	["Vcm_Settings",_id] remoteExec ["VCM_ServerAsk",2,false];
	waitUntil {!(isNil "Vcm_Settings")};
	[] call Vcm_Settings;
};

waitUntil {!(isNil "VCM_AIMagLimit")};

//Mod checks
//ACE CHECK
if (!(isNil "ACE_Medical_enableFor") && {ACE_Medical_enableFor isEqualTo 1}) then {VCM_MEDICALACTIVE = false;} else {VCM_MEDICALACTIVE = true;};
//CBA CHECK
if (isClass(configFile >> "CfgPatches" >> "cba_main")) then {CBAACT = true;} else {CBAACT = false;};

//Global actions compiles
Vcm_PMN = compileFinal "(_this select 0) playMoveNow (_this select 1);";
Vcm_SM = compileFinal "(_this select 0) switchMove (_this select 1);";
Vcm_PAN = compileFinal "(_this select 0) playActionNow (_this select 1);";
VCOM_MINEARRAY = [];

//OnEachFrame monitor for mines. Should make them more responsive, without a significant impact on FPS.
["VCMMINEMONITOR", "onEachFrame", {[] call VCM_fnc_MineMonitor}] call BIS_fnc_addStackedEventHandler;

//Below is loop to check for new AI spawning in to be added to the list
[] spawn
{
	sleep 2;
	if (hasInterface) then
	{
		//Event handlers for players	
		player addEventHandler ["Fired",{_this call VCM_fnc_HearingAids;}];
		player spawn VCM_fnc_IRCHECK;
		player addEventHandler ["Respawn",{_this spawn VCM_fnc_IRCHECK;}];
	};
	
	while {true} do 
	{
		if (Vcm_ActivateAI) then
		{
			{
				if (local _x && {simulationEnabled (leader _x)} && {!(isplayer (leader _x))} && {(leader _x) isKindOf "Man"}) then 
				{
					private _Grp = _x;
						if !(_Grp in VcmAI_ActiveList) then //{!(VCM_SIDEENABLED findIf {_x isEqualTo (side _Grp)} isEqualTo -1)}
						{
							if !(((units _Grp) findIf {alive _x}) isEqualTo -1) then
							{
								_x call VCM_fnc_SquadExc;
							};
						};
				};
			} foreach allGroups;
		};
		sleep 10;
	};
};