class liberation_admin {
  idd = 5204;
	movingEnable = false;
	controlsBackground[] = {};
	controls[] = {
	  "OuterBG",
	  "OuterBG_F",
	  "InnerBG",
	  "InnerBG_F",
	  "Header",
	  "ArsenalButton",
	  "AmmoButton",
    "BuildButton",
    "BuildList",
	  "SkipTimeButton",
    "UnlockButton",
    "ExportButton",
    "ImportButton",
    "Input_OuterBG",
    "Input_InnerBG",
    "Input_OuterBG_F",
    "Input_InnerBG_F",
    "Input_ButtonName_Ok",
    "Input_ButtonName_Abort",
    "Input_TextField",
    "Output_OuterBG",
    "Output_InnerBG",
    "Output_OuterBG_F",
    "Output_InnerBG_F",
    "Output_ButtonName_Abort",
    "Output_TextField",    
    "DeleteButton",
	  "Item01Button",
	  "Item02Button",
    "Item03Button",
    "Item04Button",
    "Item05Input",
    "Item06Button",
    "Item07Button",    
	  "CancelButton",
    "teleport_cb_text",
    "godmod_cb_text",
    "godmod_cb_1607",
    "teleport_cb_1620",
    "BannedList",
    "PlayerList"
	};

	objects[] = {};
  class OuterBG: StdBG {
    colorBackground[] = COLOR_BROWN;
    x = 0.19175 * safezoneW + safezoneX;
    y = 0.1324 * safezoneH + safezoneY;
    w = 0.25 * safezoneW;
    h = 0.62 * safezoneH;
  };
  class OuterBG_F: OuterBG {
		style = ST_FRAME;
  };
  class InnerBG: OuterBG {
    colorBackground[] = COLOR_GREEN;
    x = 0.1985 * safezoneW + safezoneX;
    y = 0.1916 * safezoneH + safezoneY;
    w = 0.2375 * safezoneW;
    h = 0.512 * safezoneH;
  };
  class InnerBG_F: InnerBG {
  	style = ST_FRAME;
  };
  class ArsenalButton: StdButton {
    idc = 1600;
    action = "closeDialog 0;buildtype=9;build_unit=[Arsenal_typename,[],1,[],[],[]];dobuild=1";
    text = $STR_ADMIN_ARSENAL;
    x = 0.2275 * safezoneW + safezoneX;
    y = 0.208 * safezoneH + safezoneY;
    w = 0.0875 * safezoneW;
    h = 0.04 * safezoneH;
  };
  class AmmoButton: StdButton {
    idc = 1601;
    action = "closeDialog 0;buildtype=9;build_unit=[ammobox_b_typename,[],1,[],[],[]];dobuild=1";
    text = $STR_ADMIN_AMMOBOX;
    x = 0.2275 * safezoneW + safezoneX;
    y = 0.26 * safezoneH + safezoneY;
    w = 0.0875 * safezoneW;
    h = 0.04 * safezoneH;
  };
  class BuildButton: StdButton {
    idc = 1617;
    action = "do_spawn=1";
    text = $STR_ADMIN_BUILD;
    x = 0.2275 * safezoneW + safezoneX;
    y = 0.312 * safezoneH + safezoneY;
    w = 0.0875 * safezoneW;
    h = 0.04 * safezoneH;
  };
  class BuildList: StdCombo {
    idc = 1618;
    x = 0.3275 * safezoneW + safezoneX;
    y = 0.316 * safezoneH + safezoneY;
    w = 0.09 * safezoneW;
    h = 0.033 * safezoneH;
  };
  class GREUH_RscStructuredText{
    type = 13;
    idc = -1;
    style = 0;
    colorText[] = {1,1,1,1};
      class Attributes
      {
        font = "PuristaMedium";
        color = "#ffffff";
        align = "left";
        shadow = 1;
      };
    x = 0;
    y = 0;
    h = 0.035;
    w = 0.1;
    text = "";
    size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
    shadow = 1;
  };
  class RscCheckBox {
    idc = -1;
    type = 7; // CT_CHECKBOXES
    style = 2; // ST_CENTER
    x = 0.25;
    y = 0.25;
    w = 0.5;
    h = 0.5;
    colorSelectedBg[] = {0, 0, 0, 0.2}; // selected item bg color
    colorText[] = {0, 1, 0, 1}; // checkbox unchecked color
    colorTextSelect[] = {1, 0, 0, 1}; // checkbox checked color
    colorBackground[] = {0, 0, 1, 0.3}; // control generic BG color
    font = "RobotoCondensed";
    sizeEx = 0.04;
  };
  class Item01Button: StdButton {
    idc = 1602;
    action = "do_unban=1";
    text = $STR_ADMIN_UNBAN;
    x = 0.2275 * safezoneW + safezoneX;
    y = 0.364 * safezoneH + safezoneY;
    w = 0.0875 * safezoneW;
    h = 0.04 * safezoneH;
  };
  class BannedList: StdCombo {
    idc = 1611;
    x = 0.3275 * safezoneW + safezoneX;
    y = 0.368 * safezoneH + safezoneY;
    w = 0.09 * safezoneW;
    h = 0.033 * safezoneH;
  };
  class Item02Button: RscActiveText {
    idc = 1603;
    action = "do_score=1";
    text = "";
    x = 0.2275 * safezoneW + safezoneX;
    y = 0.416 * safezoneH + safezoneY;
    w = 0.0290 * safezoneW;
    h = 0.04 * safezoneH;
  };
  class Item03Button: RscActiveText {
    idc = 1615;
    action = "do_ammo=1";
    text = "";
    x = 0.2567 * safezoneW + safezoneX;
    y = 0.416 * safezoneH + safezoneY;
    w = 0.0290 * safezoneW;
    h = 0.04 * safezoneH;
  };
  class Item04Button: RscActiveText {
    idc = 1616;
    action = "do_change=1";
    text = "";
    x = 0.2859 * safezoneW + safezoneX;
    y = 0.416 * safezoneH + safezoneY;
    w = 0.0290 * safezoneW;
    h = 0.04 * safezoneH;
  };
	class Item05Input: StdButton {
		idc = 1619;
		type = CT_EDIT;
		style = ST_LEFT;
    x = 0.3275 * safezoneW + safezoneX;
    y = 0.466 * safezoneH + safezoneY;
    w = 0.09 * safezoneW;
    h = 0.04 * safezoneH;    
		text = "";
		action = "";
		colorText[] = COLOR_WHITE;
		colorSelection[] = COLOR_BRIGHTGREEN;
		autocomplete = "";
	};
  class Item06Button: RscActiveText {
    idc = 1621;
    action = "do_kick=1";
    text = "";
    x = 0.2275 * safezoneW + safezoneX;
    y = 0.466 * safezoneH + safezoneY;
    w = 0.0290 * safezoneW;
    h = 0.04 * safezoneH;
  };
  class Item07Button: RscActiveText {
    idc = 1622;
    action = "do_ban=1";
    text = "";
    x = 0.2567 * safezoneW + safezoneX;
    y = 0.466 * safezoneH + safezoneY;
    w = 0.0290 * safezoneW;
    h = 0.04 * safezoneH;
  };
  class PlayerList: StdCombo {
    idc = 1612;
    x = 0.3275 * safezoneW + safezoneX;
    y = 0.416 * safezoneH + safezoneY;
    w = 0.09 * safezoneW;
    h = 0.033 * safezoneH;
  };
  class SkipTimeButton: StdButton {
    idc = 1604;
    action = "10 remoteExec ['SkipTime', 2];hint 'Time Forward...'";
    text = $STR_ADMIN_SKIPTIME;
    x = 0.2275 * safezoneW + safezoneX;
    y = 0.520 * safezoneH + safezoneY;
    w = 0.0875 * safezoneW;
    h = 0.04 * safezoneH;
  };
  class UnlockButton: StdButton {
    idc = 1609;
    action = "_x = cursorobject;if (isNull _x) exitWith {};_x setvariable ['R3F_LOG_disabled', false, true];_x setvariable ['GRLIB_vehicle_owner', '', true];hint format ['%1 Unlocked.',typeOf _x]";
    text = $STR_ADMIN_UNLOCK;
    x = 0.2275 * safezoneW + safezoneX;
    y = 0.572 * safezoneH + safezoneY;
    w = 0.0875 * safezoneW;
    h = 0.04 * safezoneH;
  };
  class DeleteButton: StdButton {
    idc = 1610;
    action = "deleteVehicle (cursorObject);closeDialog 0;";
    text = $STR_ADMIN_DELETEOBJ;
    x = 0.2275 * safezoneW + safezoneX;
    y = 0.624 * safezoneH + safezoneY;
    w = 0.0875 * safezoneW;
    h = 0.04 * safezoneH;
  };
  class ExportButton: StdButton {
    idc = 1613;
    action = "do_export=1";
    text = $STR_ADMIN_EXPORT;
    x = 0.3275 * safezoneW + safezoneX;
    y = 0.572 * safezoneH + safezoneY;
    w = 0.0875 * safezoneW;
    h = 0.04 * safezoneH;
  };
  class ImportButton: StdButton {
    idc = 1614;
    action = "do_import=1";
    text = $STR_ADMIN_IMPORT;
    x = 0.3275 * safezoneW + safezoneX;
    y = 0.624 * safezoneH + safezoneY;
    w = 0.0875 * safezoneW;
    h = 0.04 * safezoneH;
  };
  //----------------
	class Input_OuterBG : OuterBG {
		idc = 521;
		style = ST_SINGLE;
		x = (0.46 * safezoneW + safezoneX) - (BORDERSIZE);
		y = ((BASE_Y + 0.31) * safezoneH) + safezoneY - (1.5 * BORDERSIZE);
		w = 0.17 * safezoneW +  (2 * BORDERSIZE);
		h = 0.35 * safezoneH  + (3 * BORDERSIZE);
	};  
	class Input_InnerBG : InnerBG {
		idc = 522;
		colorBackground[] = COLOR_GREEN;
		x = (0.46 * safezoneW + safezoneX);
		y = ((BASE_Y + 0.31) * safezoneH) + safezoneY;
		w = 0.17 * safezoneW;
		h = 0.35 * safezoneH;
	};
	class Input_OuterBG_F : OuterBG_F {
		idc = 523;
		style = ST_FRAME;
	};
	class Input_InnerBG_F : InnerBG_F {
		idc = 524;
		style = ST_FRAME;
	};
	class Input_ButtonName_Ok : StdButton {
		idc = 525;
		x = 0.58 * safezoneW + safezoneX;
    y = ((BASE_Y + 0.32) * safezoneH) + safezoneY;
		w = ((0.2 * safezoneW) / 5) - BORDERSIZE;
		text = "OK";
		action = "input_save = ctrlText 527;";
	};
	class Input_ButtonName_Abort : StdButton {
		idc = 526;
		x = 0.58 * safezoneW + safezoneX;
    y = ((BASE_Y + 0.36) * safezoneH) + safezoneY;
		w = ((0.2 * safezoneW) / 5) - BORDERSIZE;    
		text = "Cancel";
		action = "input_save = 'null';";
	};
	class Input_TextField : StdButton {
		idc = 527;
		type = CT_EDIT;
		style = ST_MULTI;
		x = (0.46 * safezoneW + safezoneX) + BORDERSIZE;
    y = ((BASE_Y + 0.32) * safezoneH) + safezoneY;    
		w = 0.11 * safezoneW;
    h = 0.33 * safezoneH;
		text = "";
		action = "";
		colorText[] = COLOR_WHITE;
		colorSelection[] = COLOR_BRIGHTGREEN;
		autocomplete = "";
	};
  //------------------------
	class Output_OuterBG : OuterBG {
		idc = 531;
		style = ST_SINGLE;
		x = (0.46 * safezoneW + safezoneX) - (BORDERSIZE);
		y = ((BASE_Y + 0.31) * safezoneH) + safezoneY - (1.5 * BORDERSIZE);
		w = 0.17 * safezoneW +  (2 * BORDERSIZE);
		h = 0.35 * safezoneH  + (3 * BORDERSIZE);
	};  
	class Output_InnerBG : InnerBG {
		idc = 532;
		colorBackground[] = COLOR_GREEN;
		x = (0.46 * safezoneW + safezoneX);
		y = ((BASE_Y + 0.31) * safezoneH) + safezoneY;
		w = 0.17 * safezoneW;
		h = 0.35 * safezoneH;
	};
	class Output_OuterBG_F : OuterBG_F {
		idc = 533;
		style = ST_FRAME;
	};
	class Output_InnerBG_F : InnerBG_F {
		idc = 534;
		style = ST_FRAME;
	};
	class Output_ButtonName_Abort : StdButton {
		idc = 535;
		x = 0.58 * safezoneW + safezoneX;
    y = ((BASE_Y + 0.32) * safezoneH) + safezoneY;
		w = ((0.2 * safezoneW) / 5) - BORDERSIZE;
		text = "OK";
		action = "closeDialog 0;";
	};
	class Output_TextField : StdButton {
		idc = 536;
		type = CT_EDIT;
		style = ST_MULTI;
		x = (0.46 * safezoneW + safezoneX) + BORDERSIZE;
    y = ((BASE_Y + 0.32) * safezoneH) + safezoneY;    
		w = 0.11 * safezoneW;
    h = 0.33 * safezoneH;
		text = "";
		action = "";
		colorText[] = COLOR_WHITE;
		colorSelection[] = COLOR_BRIGHTGREEN;
		autocomplete = "";
    canModify = 0;
	};
  //------------------------
  class teleport_cb_1620: RscCheckbox {
    idc = 1620;
    text = "Teleport";
    x = 0.305 * safezoneW + safezoneX;
    y = 0.68 * safezoneH + safezoneY;
    w = 0.0125 * safezoneW;
    h = 0.02 * safezoneH;
    columns = 1;
    rows = 1;
    strings[] = {"O"};
    checked_strings[] = {"X"};
    onCheckBoxesSelChanged = "[_this] execVM 'scripts\client\misc\teleport.sqf';";
  };
  class teleport_cb_text: GREUH_RscStructuredText {
    idc = 1606;
    text = "<t size='0.7'>[ ALT + LMB ] on Map = Teleport :</t>";
    x = 0.2 * safezoneW + safezoneX;
    y = 0.68 * safezoneH + safezoneY;
    w = 0.125 * safezoneW;
    h = 0.02 * safezoneH;
    sizeEx = -2 * GUI_GRID_H;
  };
  class godmod_cb_1607: RscCheckbox {
    idc = 1607;
    text = $STR_ADMIN_GODMODE;
    x = 0.400 * safezoneW + safezoneX;
    y = 0.68 * safezoneH + safezoneY;
    w = 0.0125 * safezoneW;
    h = 0.02 * safezoneH;
    columns = 1;
    rows = 1;
    strings[] = {"O"};
    checked_strings[] = {"X"};
    onCheckBoxesSelChanged = "[_this] execVM 'scripts\client\misc\godmode.sqf';";
  };
  class godmod_cb_text: GREUH_RscStructuredText {
    idc = 1608;
    text = "<t size='0.7'>GodMode :</t>";
    x = 0.3625 * safezoneW + safezoneX;
    y = 0.68 * safezoneH + safezoneY;
    w = 0.05 * safezoneW;
    h = 0.02 * safezoneH;
  };
  class CancelButton: StdButton {
    idc = 1605;
    action = "closeDialog 0";
    text = "EXIT";
    x = 0.269271 * safezoneW + safezoneX;
    y = 0.71 * safezoneH + safezoneY;
    w = 0.09 * safezoneW;
    h = 0.035 * safezoneH;
  };
  class Header: StdHeader {
    text = $STR_ADMIN_MENUMENU;
    x = 0.1985 * safezoneW + safezoneX;
    y = 0.1444 * safezoneH + safezoneY;
    w = 0.2375 * safezoneW;
    h = 0.04 * safezoneH;
  };
};
