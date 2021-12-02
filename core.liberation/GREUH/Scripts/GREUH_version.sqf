if (player diarySubjectExists "LRX Info") exitWith {};
_getRandomColor = {
	private _str = "#";
	private _mColors = ["ff","20","40","80","B0"];
	for [{_i=0}, {_i<3}, {_i=_i+1}] do {
		_str = _str + selectRandom _mColors;
	};
_str;
};

_getkeyName = {
	params ["_name"];
	private _ret = actionKeysNames _name;
	if (_ret == "") then {_ret = "N/A"};
	_ret;
};

player createDiarySubject ["LRX Info","LRX Info"];
player createDiarySubject ["LRX Info","Support LRX !"];
player createDiaryRecord ["LRX Info", ["Support LRX !", "<img image='res\mail.paa' height='32' width='25'/>  <img image='res\paypal.paa' height='32' width='32'/>     <font color='#0080ff'>tbox1911@gmail.com</font><br/><br/>Thank you !"]];
player createDiaryRecord ["LRX Info", ["Support LRX !", "or just buy me a beer !!<br/><br/>You can use my payPal account:<br/>"]];
player createDiaryRecord ["LRX Info", ["Support LRX !", "You want to participate to the mission dev ?<br/><br/>or contribute to the server hosting ?"]];
player createDiaryRecord ["LRX Info", ["Support LRX !", "<br/>You like Liberation RX ?<br/>"]];

player createDiarySubject ["LRX Info", "pSiKO Tweaks"];
player createDiaryRecord ["LRX Info", ["pSiKO Tweaks", format ["<img image='\a3\ui_f\data\map\markers\flags\france_ca.paa' height='20' width='20'/>&#160;&#160;This version was build on %1 at %2 in France, with love ;)", GRLIB_build_date, GRLIB_build_time]]];
player createDiaryRecord ["LRX Info", ["pSiKO Tweaks", format ["All the rest and Scripting Integration<br/>by <font color='#0080ff'>-pSiKO-</font>"]]];
player createDiaryRecord ["LRX Info", ["pSiKO Tweaks", format ["Advanced Rappelling v1.00<br/>by <font color='%1'>-Seth Duda-</font>", call _getRandomColor]]];
player createDiaryRecord ["LRX Info", ["pSiKO Tweaks", format ["DALE Pylons v1.00<br/>by <font color='%1'>-Sgt. Dennenboom-</font>", call _getRandomColor]]];
player createDiaryRecord ["LRX Info", ["pSiKO Tweaks", format ["GRAD Fireworks v.1.20<br/>by <font color='%1'>-Nomisum-</font>", call _getRandomColor]]];
player createDiaryRecord ["LRX Info", ["pSiKO Tweaks", format ["Dynamic Animal v.1.00<br/>by <font color='%1'>-Vandeanson-</font>", call _getRandomColor]]];
player createDiaryRecord ["LRX Info", ["pSiKO Tweaks", format ["Mag Repack v3.13<br/>by <font color='%1'>-Outlawled-</font>", call _getRandomColor]]];
player createDiaryRecord ["LRX Info", ["pSiKO Tweaks", format ["A3W Missions v1.30<br/>by <font color='%1'>-AgentRev-</font>", call _getRandomColor]]];
player createDiaryRecord ["LRX Info", ["pSiKO Tweaks", format ["R3F Logistics v3.10<br/>by <font color='%1'>-Team-R3F.org-</font>", call _getRandomColor]]];
player createDiaryRecord ["LRX Info", ["pSiKO Tweaks", format ["Robust Air Taxi v1.05<br/>by <font color='%1'>-pSiKO-</font>", call _getRandomColor]]];
player createDiaryRecord ["LRX Info", ["pSiKO Tweaks", format ["pSiKO AI Revive v2.04<br/>by <font color='%1'>-pSiKO-</font>", call _getRandomColor]]];
player createDiaryRecord ["LRX Info", ["pSiKO Tweaks", format ["LARs Arsenal v1.05<br/>by <font color='%1'>-Larrow Zurb-</font>", call _getRandomColor]]];
player createDiaryRecord ["LRX Info", ["pSiKO Tweaks", localize "STR_MISSION_TITLE"]];

player createDiarySubject ["LRX Info", "Server"];
player createDiaryRecord ["LRX Info", ["Server", format ["Join us on the Official Server !<br/><br/>- ARMA III - Liberation RX<br/><img image='res\liberation.paa' height='128' width='256'/><br/><font color='#0080ff'>arma.liberation-rx.fr</font><br/><br/>Team Speak 3<br/><font color='#0080ff'>ts3.liberation-rx.fr</font>"]]];

player createDiarySubject ["LRX Info","Original"];
player createDiaryRecord ["LRX Info", ["Original", format ["<font color='#ff8000'>Extended Options</font><br/>arma.greuh.org<br/><br/><font color='#ff8000'>Scripted by [GREUH] Zbug</font><br/>Version 924"]]];

player createDiarySubject ["Ranking","Ranking"];
player createDiaryRecord ["Ranking", ["Ranking", format ["<font color='#900000'>%1</font>  :  BANNED<br/>%2", GRLIB_perm_ban, localize "STR_RANK_LVLBAN"]]];
player createDiaryRecord ["Ranking", ["Ranking", format ["<font color='#ff4000'>%1</font>  :  UNNAMED<br/>%2", "Neg.", localize "STR_RANK_LVL0"]]];
player createDiaryRecord ["Ranking", ["Ranking", format ["<font color='#ff8000'>%1</font>  :  PRIVATE<br/>%2", "000", localize "STR_RANK_LVL1"]]];
player createDiaryRecord ["Ranking", ["Ranking", format ["<font color='#ffff00'>%1</font>  :  CORPORAL<br/>%2", GRLIB_perm_inf, localize "STR_RANK_LVL2"]]];
player createDiaryRecord ["Ranking", ["Ranking", format ["<font color='#8ff000'>%1</font>  :  SERGEANT<br/>%2", GRLIB_perm_log, localize "STR_RANK_LVL3"]]];
player createDiaryRecord ["Ranking", ["Ranking", format ["<font color='#00ffff'>%1</font>  :  CAPTAIN<br/>%2", GRLIB_perm_tank, localize "STR_RANK_LVL4"]]];
player createDiaryRecord ["Ranking", ["Ranking", format ["<font color='#0080ff'>%1</font>  :  MAJOR<br/>%2", GRLIB_perm_air, localize "STR_RANK_LVL5"]]];
player createDiaryRecord ["Ranking", ["Ranking", format ["<font color='#0000ff'>%1</font>  :  COLONEL<br/>%2", GRLIB_perm_max, localize "STR_RANK_LVL6"]]];
player createDiaryRecord ["Ranking", ["Ranking", format ["-= How Work the Ranking System =-"]]];

player createDiarySubject["Table","Table"];
player createDiaryRecord ["Table", ["Table", format ["<font color='#ff4000'>-20</font> pts  :  Killing Prisoners"]]];
player createDiaryRecord ["Table", ["Table", format ["<font color='#ff4000'>-20</font> pts  :  Killing Civilians"]]];
player createDiaryRecord ["Table", ["Table", format ["<font color='#ff4000'>-10</font> pts  :  Team Kill"]]];
player createDiaryRecord ["Table", ["Table", format ["<font color='#ff4000'> -5</font> pts  :  Firendly Fires"]]];
player createDiaryRecord ["Table", ["Table", format ["<font color='#00ff40'>+10</font> pts  :  Recycle AmmoBox<br/>"]]];
player createDiaryRecord ["Table", ["Table", format ["<font color='#00ff40'>+10</font> pts  :  Bring Prisoners at HQ"]]];
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
