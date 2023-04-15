if (player diarySubjectExists "LRX Info") exitWith {};
_getRandomColor = {
	private _str = "#";
	private _mColors = ["ff","30","40","60","6f","80","8f","B0"];
	for "_i" from 0 to 2 do { _str = _str + selectRandom _mColors };
	_str;
};

_getkeyName = {
	params ["_name"];
	private _ret = actionKeysNames _name;
	if (_ret == "") then {_ret = "N/A"};
	_ret;
};

player createDiarySubject ["LRX Info", "LRX Info"];
player createDiarySubject ["LRX Info", "Thanks"];
private _all_friends = "";
{
	_all_friends = _all_friends + format ["- <font color='%1'>%2</font><br/>", call _getRandomColor, _x];
} foreach (loadFile "GREUH\LRX_friends.txt" splitString toString [13,10]);

player createDiaryRecord ["LRX Info", ["Thanks", format ["... And You !!"]]];
player createDiaryRecord ["LRX Info", ["Thanks", format ["And to all the good friends:<br/> %1", _all_friends]]];
player createDiaryRecord ["LRX Info", ["Thanks", format ["<font color='%1'>Bohemia's Forum Community</font> for all the support and code tricks.", call _getRandomColor, call _getRandomColor]]];
player createDiaryRecord ["LRX Info", ["Thanks", format ["<font color='%1'>Arturo</font> for additional work.", call _getRandomColor]]];
player createDiaryRecord ["LRX Info", ["Thanks", format ["<font color='%1'>Mihuan</font>, <font color='%2'>O360_A1AD</font> for langage translation.", call _getRandomColor, call _getRandomColor]]];
player createDiaryRecord ["LRX Info", ["Thanks", format ["<font color='%1'>Varrkan</font>, <font color='%2'>Polox</font> for MP testing and much more.", call _getRandomColor, call _getRandomColor]]];
player createDiaryRecord ["LRX Info", ["Thanks", format ["<font color='%1'>AgentRev</font>, <font color='%2'>Larrow Zurb</font>, <font color='%3'>KillZoneKid</font>, <font color='%4'>Quiksilver</font> for code scripting.", call _getRandomColor,call _getRandomColor,call _getRandomColor,call _getRandomColor]]];
player createDiaryRecord ["LRX Info", ["Thanks", format ["<font color='%1'>Isa</font> for all the love.", call _getRandomColor]]];
player createDiaryRecord ["LRX Info", ["Thanks", "Thanks to all the people who contribute to the mission:"]];

player createDiaryRecord ["LRX Info", ["Modders", format ["<font color='%1'>Z-Warrior</font> for CUPS templates.", call _getRandomColor]]];
player createDiaryRecord ["LRX Info", ["Modders", format ["<font color='%1'>C0br4</font> for lots of templates.", call _getRandomColor]]];
player createDiaryRecord ["LRX Info", ["Modders", "Thanks to the Mod Template Master:"]];

player createDiarySubject ["LRX Info", "Support LRX !"];
player createDiaryRecord ["LRX Info", ["Support LRX !", "<img image='res\mail.paa' height='32' width='25'/>  <img image='res\paypal.paa' height='32' width='32'/>     <font color='#0080ff'>https://paypal.me/LiberationRX</font><br/><br/> Thank you !"]];
player createDiaryRecord ["LRX Info", ["Support LRX !", "or just buy me a beer ?!<br/><br/>You can use my payPal account:<br/>"]];
player createDiaryRecord ["LRX Info", ["Support LRX !", "You want to contribute to the mission dev ?<br/><br/>or contribute to the server hosting ?"]];
player createDiaryRecord ["LRX Info", ["Support LRX !", "<br/>You like Liberation RX ?<br/>"]];

player createDiarySubject ["LRX Info", "pSiKO Tweaks"];
player createDiaryRecord ["LRX Info", ["pSiKO Tweaks", format ["<img image='\a3\ui_f\data\map\markers\flags\france_ca.paa' height='20' width='20'/>&#160;&#160;This version was build on %1 at %2 in France, with love ;)", GRLIB_build_date, GRLIB_build_time]]];
player createDiaryRecord ["LRX Info", ["pSiKO Tweaks", format ["All the rest and Scripting Integration<br/>by <font color='#0080ff'>-pSiKO-</font>"]]];
player createDiaryRecord ["LRX Info", ["pSiKO Tweaks", format ["Advanced Rappelling v1.00<br/>by <font color='%1'>-Seth Duda-</font>", call _getRandomColor]]];
player createDiaryRecord ["LRX Info", ["pSiKO Tweaks", format ["Vehicle Appearance Manager v1.41<br/>by <font color='%1'>-UNIT_normal-</font>", call _getRandomColor]]];
player createDiaryRecord ["LRX Info", ["pSiKO Tweaks", format ["DALE Pylons v1.00<br/>by <font color='%1'>-Sgt. Dennenboom-</font>", call _getRandomColor]]];
player createDiaryRecord ["LRX Info", ["pSiKO Tweaks", format ["Dynamic Animal v.1.00<br/>by <font color='%1'>-Vandeanson-</font>", call _getRandomColor]]];
player createDiaryRecord ["LRX Info", ["pSiKO Tweaks", format ["Mag Repack v3.13<br/>by <font color='%1'>-Outlawled-</font>", call _getRandomColor]]];
player createDiaryRecord ["LRX Info", ["pSiKO Tweaks", format ["A3W Missions and so much!!<br/>by <font color='%1'>-AgentRev-</font>", call _getRandomColor]]];
player createDiaryRecord ["LRX Info", ["pSiKO Tweaks", format ["R3F Logistics v3.10<br/>by <font color='%1'>-Team-R3F.org-</font>", call _getRandomColor]]];
player createDiaryRecord ["LRX Info", ["pSiKO Tweaks", format ["Robust Air Taxi v1.05<br/>by <font color='%1'>-pSiKO-</font>", call _getRandomColor]]];
player createDiaryRecord ["LRX Info", ["pSiKO Tweaks", format ["pSiKO AI Revive v2.04<br/>by <font color='%1'>-pSiKO-</font>", call _getRandomColor]]];
player createDiaryRecord ["LRX Info", ["pSiKO Tweaks", format ["LARs Arsenal v1.05<br/>by <font color='%1'>-Larrow Zurb-</font>", call _getRandomColor]]];
player createDiaryRecord ["LRX Info", ["pSiKO Tweaks", localize "STR_MISSION_TITLE"]];

player createDiarySubject ["LRX Info", "Server"];
player createDiaryRecord ["LRX Info", ["Server", format ["Join us on the Official Server !<br/><br/>- ARMA III - Liberation RX<br/><img image='res\liberation.paa' height='128' width='256'/><br/><font color='#0080ff'>arma.liberation-rx.fr</font><br/><br/>Team Speak 3<br/><font color='#0080ff'>ts3.liberation-rx.fr</font><br/>Discord LRX<br/><font color='#0080ff'>https://discord.gg/uCRzJ7wauR</font>"]]];

player createDiarySubject ["LRX Info", "Original"];
player createDiaryRecord ["LRX Info", ["Original", format ["Last version 0.924"]]];
player createDiaryRecord ["LRX Info", ["Original", format ["Website: <font color='#ff8000'>arma.greuh.org</font>"]]];
player createDiaryRecord ["LRX Info", ["Original", format ["Original version coded by: <font color='#ff8000'>[GREUH] Zbug</font> and <font color='#ff8000'>[GREUH] McKeewa</font>"]]];

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
player createDiaryRecord ["Table", ["Table", format ["<font color='#ff4000'>-20</font> pts  :  Killing Prisoners"]]];
player createDiaryRecord ["Table", ["Table", format ["<font color='#ff4000'>-20</font> pts  :  Killing Civilians"]]];
player createDiaryRecord ["Table", ["Table", format ["<font color='#ff4000'>-10</font> pts  :  Team Kill"]]];
player createDiaryRecord ["Table", ["Table", format ["<font color='#ff4000'> -5</font> pts  :  Firendly Fires"]]];
player createDiaryRecord ["Table", ["Table", format ["<font color='#ff4000'> -5</font> pts  :  Respawn when Major and above"]]];
player createDiaryRecord ["Table", ["Table", format ["<font color='#00ff40'>+10</font> pts  :  Recycle AmmoBox<br/>"]]];
player createDiaryRecord ["Table", ["Table", format ["<font color='#00ff40'>+10</font> pts  :  Bring Prisoners at HQ"]]];
player createDiaryRecord ["Table", ["Table", format ["<font color='#00ff40'>+20</font> pts  :  Defend Attacked Sector"]]];
player createDiaryRecord ["Table", ["Table", format ["<font color='#00ff40'> +5</font> pts  :  Salvage Wrecks"]]];
player createDiaryRecord ["Table", ["Table", format ["<font color='#00ff40'> +5</font> pts  :  Revive other players"]]];
player createDiaryRecord ["Table", ["Table", format ["<font color='#00ff40'> +4</font> pts  :  Kill enemy vehicle"]]];
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
player createDiaryRecord ["MapInfo", ["MapInfo", format ["This Map: %1<br/>was made by: <font color='%3'>%2</font>.", worldname, GRLIB_map_modder, call _getRandomColor]]];
player createDiaryRecord ["MapInfo", ["MapInfo", format ["The East faction <font color='#f80000'>%1</font><br/>was made by: <font color='%3'>%2</font>.", GRLIB_mod_east, GRLIB_east_modder, call _getRandomColor]]];
player createDiaryRecord ["MapInfo", ["MapInfo", format ["The West faction <font color='#0000f8'>%1</font><br/>was made by: <font color='%3'>%2</font>.", GRLIB_mod_west, GRLIB_west_modder, call _getRandomColor]]];
player createDiaryRecord ["MapInfo", ["MapInfo", format ["-= Map Information =-"]]];
