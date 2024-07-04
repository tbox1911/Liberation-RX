if (player diarySubjectExists "LRX Info") exitWith {};
private _getRandomColor = {
	private _str = "#";
	private _mColors = ["19","03","73","ff","30","40","58","60","6f","80","8f","B0"];
	for "_i" from 0 to 2 do { _str = _str + selectRandom _mColors };
	_str;
};

private _getkeyName = {
	params ["_name"];
	private _ret = actionKeysNames _name;
	if (_ret == "") then {_ret = "N/A"};
	_ret;
};

player createDiarySubject ["LRX Info", "LRX Info"];

player createDiarySubject ["LRX Info", "Support LRX !"];
player createDiaryRecord ["LRX Info", ["Support LRX !", "<br/>  Thank you !"]];
player createDiaryRecord ["LRX Info", ["Support LRX !", "<img image='res\mail.paa' height='32' width='25'/>  <img image='res\paypal.paa' height='32' width='32'/>     <font color='#0080ff'>https://paypal.me/LiberationRX</font><br/>"]];
player createDiaryRecord ["LRX Info", ["Support LRX !", "or you just want to offer me a beer ?!<br/><br/>You can use my payPal account:<br/>"]];
player createDiaryRecord ["LRX Info", ["Support LRX !", "You want to contribute to the mission development ?<br/><br/>or contribute to the server hosting fee ?"]];
player createDiaryRecord ["LRX Info", ["Support LRX !", "<br/>You like Liberation RX ?<br/>"]];

player createDiarySubject ["LRX Info", "Original Liberation"];
player createDiaryRecord ["LRX Info", ["Original Liberation", format ["Last version 0.927"]]];
player createDiaryRecord ["LRX Info", ["Original Liberation", format ["Website: <font color='#ff8000'>arma.greuh.org</font>"]]];
player createDiaryRecord ["LRX Info", ["Original Liberation", format ["Original version coded by: <font color='#ff8000'>[GREUH] Zbug</font> and <font color='#ff8000'>[GREUH] McKeewa</font>"]]];

player createDiarySubject ["LRX Info", "Thanks"];
private _all_friends = "";
{
	_all_friends = _all_friends + format ["- <font color='%1'>%2</font><br/>", call _getRandomColor, _x];
} foreach (loadFile "GREUH\LRX_friends.txt" splitString toString [13,10]);

player createDiaryRecord ["LRX Info", ["Thanks", format ["... And You !!"]]];
player createDiaryRecord ["LRX Info", ["Thanks", format ["And to all the good friends:<br/> %1", _all_friends]]];
player createDiaryRecord ["LRX Info", ["Thanks", format ["<font color='%1'>Bohemia's Forum Community</font> for all the support and code tricks.", call _getRandomColor, call _getRandomColor]]];
player createDiaryRecord ["LRX Info", ["Thanks", format ["<font color='%1'>GREUH Team</font> for the original work.", call _getRandomColor]]];
player createDiaryRecord ["LRX Info", ["Thanks", format ["<font color='%1'>Mihuan</font>, <font color='%2'>O360_A1AD</font> for langage translation.", call _getRandomColor, call _getRandomColor]]];
player createDiaryRecord ["LRX Info", ["Thanks", format ["<font color='%1'>Varrkan</font>, <font color='%2'>Polox</font> for MP testing and much more.", call _getRandomColor, call _getRandomColor]]];
player createDiaryRecord ["LRX Info", ["Thanks", format ["<font color='%1'>AgentRev</font>, <font color='%2'>Larrow Zurb</font>, <font color='%3'>KillZoneKid</font>, <font color='%4'>Quiksilver</font> for code scripting.", call _getRandomColor,call _getRandomColor,call _getRandomColor,call _getRandomColor]]];
player createDiaryRecord ["LRX Info", ["Thanks", format ["<font color='%1'>Isa</font> for all the love and patience.", "#f80000"]]];
player createDiaryRecord ["LRX Info", ["Thanks", "Thanks to all the people who contribute to the mission:"]];

player createDiaryRecord ["LRX Info", ["Modders", format ["<font color='%1'>Dark Demon</font> for Templates and Maps.", call _getRandomColor]]];
player createDiaryRecord ["LRX Info", ["Modders", format ["<font color='%1'>Z-Warrior</font> for Templates and Maps.", call _getRandomColor]]];
player createDiaryRecord ["LRX Info", ["Modders", format ["<font color='%1'>C0br4</font> for Templates.", call _getRandomColor]]];
player createDiaryRecord ["LRX Info", ["Modders", "Thanks to the Mod Template Team:"]];

player createDiarySubject ["LRX Info", "Contributors"];
player createDiaryRecord ["LRX Info", ["Contributors", format ["<img image='\a3\ui_f\data\map\markers\flags\france_ca.paa' height='20' width='20'/>&#160;&#160;This version (%1) was build on %2 at %3 in France, with love ;)", GRLIB_build_version, GRLIB_build_date, GRLIB_build_time]]];
player createDiaryRecord ["LRX Info", ["Contributors", format ["All the rest and Scripting Integration<br/>by <font color='#0080ff'>-pSiKO-</font>"]]];
player createDiaryRecord ["LRX Info", ["Contributors", format ["Nuke Script v1.00<br/>by <font color='%1'>-Moerderhoschi-</font>", call _getRandomColor]]];
player createDiaryRecord ["LRX Info", ["Contributors", format ["Advanced Rappelling v1.00<br/>by <font color='%1'>-Seth Duda-</font>", call _getRandomColor]]];
player createDiaryRecord ["LRX Info", ["Contributors", format ["Vehicle Appearance Manager v1.41<br/>by <font color='%1'>-UNIT_normal-</font>", call _getRandomColor]]];
player createDiaryRecord ["LRX Info", ["Contributors", format ["DALE Pylons v1.00<br/>by <font color='%1'>-Sgt. Dennenboom-</font>", call _getRandomColor]]];
player createDiaryRecord ["LRX Info", ["Contributors", format ["Wild Life Manager v1.8<br/>by <font color='%1'>-pSiKO-</font>", call _getRandomColor]]];
player createDiaryRecord ["LRX Info", ["Contributors", format ["Mag Repack v3.13<br/>by <font color='%1'>-Outlawled-</font>", call _getRandomColor]]];
player createDiaryRecord ["LRX Info", ["Contributors", format ["A3W Missions and so much!!<br/>by <font color='%1'>-AgentRev-</font>", call _getRandomColor]]];
player createDiaryRecord ["LRX Info", ["Contributors", format ["R3F Logistics v3.10<br/>by <font color='%1'>-Team-R3F.org-</font>", call _getRandomColor]]];
player createDiaryRecord ["LRX Info", ["Contributors", format ["Robust Air Taxi v2.05<br/>by <font color='%1'>-pSiKO-</font>", call _getRandomColor]]];
player createDiaryRecord ["LRX Info", ["Contributors", format ["pSiKO AI Revive v3.05<br/>by <font color='%1'>-pSiKO-</font>", call _getRandomColor]]];
player createDiaryRecord ["LRX Info", ["Contributors", format ["LARs Arsenal v1.05<br/>by <font color='%1'>-Larrow Zurb-</font>", call _getRandomColor]]];
player createDiaryRecord ["LRX Info", ["Contributors", format ["LRX Community Manager<br/>by <font color='%1'>-Legend_TS13-</font>", call _getRandomColor]]];

player createDiaryRecord ["LRX Info", ["Contributors", localize "STR_MISSION_TITLE"]];
player createDiarySubject ["LRX Info", "Settings"];
private _diary = [];
private ["_name", "_value_text"];
{
	_name = _x select 0;
	if (_name == "---") then {
		_diary pushBack format ["%1 <font color='#0080f0'>%2</font> %1", _name, (_x select 1)];
	} else {
		_value_text = "Error!";
		_data = [_name] call lrx_getParamData;
		if (count _data > 0) then {
			_name = _data select 0;
			_values_raw = _data select 2;
			if (isNil "_values_raw") then { _values_raw = [] };
			if (count (_values_raw) > 0) then {
				_value_text = (_data select 1) select (_values_raw find (_x select 1));
			} else {
				_value_text = (_data select 1) select (_x select 1);
			};		
		};
		_diary pushBack format ["%1: <font color='#ff8000'>%2</font>", _name, _value_text];
	};
	
} foreach GRLIB_LRX_params;
reverse _diary;
{ player createDiaryRecord ["LRX Info", ["Settings", _x]] } forEach _diary;
player createDiaryRecord ["LRX Info", ["Settings", format ["Game ID: <font color='#ff8000'>%1</font>", GRLIB_game_ID]]];
player createDiaryRecord ["LRX Info", ["Settings", format ["Build Version: <font color='#ff8000'>%1</font>", GRLIB_build_version]]];
player createDiaryRecord ["LRX Info", ["Settings", format ["-= LRX Current Settings =-"]]];

player createDiarySubject ["LRX Info", "Server"];
player createDiaryRecord ["LRX Info", ["Server", format ["Join us on the Official Server !<br/><br/>
- ARMA III - Liberation RX - %1<br/><font color='#0080ff'>arma.liberation-rx.fr</font><br/>
<img image='res\liberation.paa' height='128' width='256'/><br/><br/>
Team Speak 3<br/><font color='#0080ff'>ts3.liberation-rx.fr</font><br/><br/>
Discord LRX<br/><font color='#0080ff'>https://discord.gg/uCRzJ7wauR</font>", GRLIB_build_version]]];

player createDiarySubject ["Ranking","Ranking"];
player createDiaryRecord ["Ranking", ["Ranking", format ["<font color='#900000'>%1</font>  :  BANNED<br/>%2", GRLIB_perm_ban, localize "STR_RANK_LVLBAN"]]];
player createDiaryRecord ["Ranking", ["Ranking", format ["<font color='#ff4000'>%1</font>  :  UNNAMED<br/>%2", "Neg.", localize "STR_RANK_LVL0"]]];
player createDiaryRecord ["Ranking", ["Ranking", format ["<font color='#ff8000'>%1</font>  :  PRIVATE<br/>%2", "000", localize "STR_RANK_LVL1"]]];
player createDiaryRecord ["Ranking", ["Ranking", format ["<font color='#ffff00'>%1</font>  :  CORPORAL<br/>%2", GRLIB_perm_inf, localize "STR_RANK_LVL2"]]];
player createDiaryRecord ["Ranking", ["Ranking", format ["<font color='#8ff000'>%1</font>  :  SERGEANT<br/>%2", GRLIB_perm_log, localize "STR_RANK_LVL3"]]];
player createDiaryRecord ["Ranking", ["Ranking", format ["<font color='#00ffff'>%1</font>  :  CAPTAIN<br/>%2", GRLIB_perm_tank, localize "STR_RANK_LVL4"]]];
player createDiaryRecord ["Ranking", ["Ranking", format ["<font color='#0080ff'>%1</font>  :  MAJOR<br/>%2", GRLIB_perm_air, localize "STR_RANK_LVL5"]]];
player createDiaryRecord ["Ranking", ["Ranking", format ["<font color='#0000ff'>%1</font>  :  COLONEL<br/>%2", GRLIB_perm_max, localize "STR_RANK_LVL6"]]];
player createDiaryRecord ["Ranking", ["Ranking", format ["<font color='#0000ff'>%1</font>  :  SUPER COLONEL<br/>%2", GRLIB_perm_max*2, localize "STR_RANK_LVL7"]]];
player createDiaryRecord ["Ranking", ["Ranking", format ["-= How Work the Ranking System =-"]]];

player createDiarySubject["Table","Table"];
player createDiaryRecord ["Table", ["Table", format ["<br>note: XP points may vary depending on the nature or rank of the targets."]]];
player createDiaryRecord ["Table", ["Table", format ["<font color='#ff4000'>-50</font> pts  :  Killing Friendly Vehicles"]]];
player createDiaryRecord ["Table", ["Table", format ["<font color='#ff4000'>-20</font> pts  :  Killing Friendly Units"]]];
player createDiaryRecord ["Table", ["Table", format ["<font color='#ff4000'>-20</font> pts  :  Killing Prisoners"]]];
player createDiaryRecord ["Table", ["Table", format ["<font color='#ff4000'>-10</font> pts  :  Killing Civilians"]]];
player createDiaryRecord ["Table", ["Table", format ["<font color='#ff4000'> -5</font> pts  :  Eject Civilian from Vehicle"]]];
player createDiaryRecord ["Table", ["Table", format ["<font color='#ff4000'> -5</font> pts  :  Friendly Fires"]]];
player createDiaryRecord ["Table", ["Table", format ["<font color='#ff4000'> -5</font> pts  :  Respawn (Sergeant and above)"]]];
player createDiaryRecord ["Table", ["Table", format ["<font color='#ff4000'> -1</font> pts  :  Wounded (Sergeant and above)"]]];

player createDiaryRecord ["Table", ["Table", format ["<font color='#00ff40'>+50</font> pts  :  Recycle AAF AmmoBox (rank below Sergeant)"]]];
player createDiaryRecord ["Table", ["Table", format ["<font color='#00ff40'>+10</font> pts  :  Recycle any AmmoBox (rank below Captain)"]]];
player createDiaryRecord ["Table", ["Table", format ["<font color='#00ff40'>+15</font> pts  :  Find Intels or Search Traps"]]];
player createDiaryRecord ["Table", ["Table", format ["<font color='#00ff40'>+10</font> pts  :  Bring Prisoners or V.I.P at HQ"]]];
player createDiaryRecord ["Table", ["Table", format ["<font color='#00ff40'>+20</font> pts  :  Defend Attacked Sector"]]];
player createDiaryRecord ["Table", ["Table", format ["<font color='#00ff40'>+10</font> pts  :  Kill a Kamikaze"]]];
player createDiaryRecord ["Table", ["Table", format ["<font color='#00ff40'> +5</font> pts  :  Salvage Wrecks"]]];
player createDiaryRecord ["Table", ["Table", format ["<font color='#00ff40'> +5</font> pts  :  Revive other players (near combat)"]]];
player createDiaryRecord ["Table", ["Table", format ["<font color='#00ff40'> +5</font> pts  :  Kill enemy vehicle"]]];
player createDiaryRecord ["Table", ["Table", format ["<font color='#00ff40'> +1</font> pts  :  Kill enemy infantry"]]];
player createDiaryRecord ["Table", ["Table", format ["-= Killing Table =-"]]];

player createDiarySubject ["Shortcut","Shortcut"];
player createDiaryRecord ["Shortcut", ["Shortcut", format ["(UserAction n°14) Take Screenshot : Key <font color='#ff8000'>%1</font>", ["User14"] call _getkeyName]]];
player createDiaryRecord ["Shortcut", ["Shortcut", format ["(UserAction n°13) Toggle HUD : Key <font color='#ff8000'>%1</font>", ["User13"] call _getkeyName]]];
player createDiaryRecord ["Shortcut", ["Shortcut", format ["(UserAction n°12) Toggle earplugs : Key <font color='#ff8000'>%1</font>", ["User12"] call _getkeyName]]];
player createDiaryRecord ["Shortcut", ["Shortcut", format ["(UserAction n°11) Always run : Key <font color='#ff8000'>%1</font>", ["User11"] call _getkeyName]]];
player createDiaryRecord ["Shortcut", ["Shortcut", format ["(UserAction n°10) Weapon to back : Key <font color='#ff8000'>%1</font>", ["User10"] call _getkeyName]]];
player createDiaryRecord ["Shortcut", ["Shortcut", format ["Unblock unit (player/AI) : Key <font color='#ff8000'>[0 + 8 + 1]</font>"]]];
player createDiaryRecord ["Shortcut", ["Shortcut", format ["Teleport on Map (Admin) : Key <font color='#ff8000'>Alt + LMB</font>"]]];
player createDiaryRecord ["Shortcut", ["Shortcut", format ["Open MagRepack Utility : Key <font color='#ff8000'>Ctrl + %1</font>", keyName (MGR_Key)]]];
player createDiaryRecord ["Shortcut", ["Shortcut", format ["Tactical Ping : Key <font color='#ff8000'>%1</font>", ["TacticalPing"] call _getkeyName]]];
player createDiaryRecord ["Shortcut", ["Shortcut", format ["Show the Score Table : Key <font color='#ff8000'>%1</font>", ["NetworkStats"] call _getkeyName]]];
player createDiaryRecord ["Shortcut", ["Shortcut", format ["-= Key Shortcut =-"]]];

player createDiarySubject ["MapInfo","MapInfo"];
player createDiaryRecord ["MapInfo", ["MapInfo", format ["This Map: %1<br/>was ported to LRX by: <font color='%3'>%2</font>.", worldname, GRLIB_map_modder, call _getRandomColor]]];
player createDiaryRecord ["MapInfo", ["MapInfo", format ["The East faction <font color='#f80000'>%1</font><br/>was made by: <font color='%3'>%2</font>.", GRLIB_mod_east, GRLIB_east_modder, call _getRandomColor]]];
player createDiaryRecord ["MapInfo", ["MapInfo", format ["The West faction <font color='#0000f8'>%1</font><br/>was made by: <font color='%3'>%2</font>.", GRLIB_mod_west, GRLIB_west_modder, call _getRandomColor]]];
player createDiaryRecord ["MapInfo", ["MapInfo", format ["-= Map Information =-"]]];
