class liberation_admin_a3w {
  idd = 5202;
	movingEnable = false;
	controlsBackground[] = {};
	controls[] = {
	  "OuterBG",
	  "OuterBG_F",
	  "InnerBG",
	  "InnerBG_F",
	  "Header",
	  "A3W_debug_txt",
	  "A3W_debug_marker_txt",
    "A3W_debug_list",
    "A3W_debug_marker_list",
    "A3W_mission_txt",
    "A3W_mission_list",
	  "A3W_Mission_delay_txt",
    "A3W_Mission_delay_list",
    "A3W_Mission_timeout_txt",
    "A3W_Mission_timeout_list",
	  "CancelButton",
    "ApplyButton"
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
  class Header: StdHeader {
    text = $STR_ADMIN_MENU_TITLE_A3W;
    x = 0.1985 * safezoneW + safezoneX;
    y = 0.1444 * safezoneH + safezoneY;
    w = 0.2375 * safezoneW;
    h = 0.04 * safezoneH;
  };  
  // ------------------
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
    size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
    shadow = 1;
  };
  // ------------------
  class A3W_debug_txt: GREUH_RscStructuredText {
    idc = 1600;
    text = "A3W Debug";
    x = 0.2275 * safezoneW + safezoneX;
    y = 0.208 * safezoneH + safezoneY;
    w = 0.0875 * safezoneW;
    h = 0.04 * safezoneH;
  };
  class A3W_debug_list: StdCombo {
    idc = 1623;
    x = 0.3275 * safezoneW + safezoneX;
    y = 0.208 * safezoneH + safezoneY;
    w = 0.09 * safezoneW;
    h = 0.033 * safezoneH;
  };
  class A3W_debug_marker_txt: GREUH_RscStructuredText {
    idc = 1601;
    text = "A3W Debug Marker";
    x = 0.2275 * safezoneW + safezoneX;
    y = 0.26 * safezoneH + safezoneY;
    w = 0.0875 * safezoneW;
    h = 0.04 * safezoneH;
  };
  class A3W_debug_marker_list: StdCombo {
    idc = 1627;
    x = 0.3275 * safezoneW + safezoneX;
    y = 0.26 * safezoneH + safezoneY;
    w = 0.09 * safezoneW;
    h = 0.033 * safezoneH;
  };
  class A3W_mission_txt: GREUH_RscStructuredText {
    idc = 1617;
    text = "A3W Select Mission";
    x = 0.2275 * safezoneW + safezoneX;
    y = 0.312 * safezoneH + safezoneY;
    w = 0.0875 * safezoneW;
    h = 0.04 * safezoneH;
  };
  class A3W_mission_list: StdCombo {
    idc = 1618;
    x = 0.3275 * safezoneW + safezoneX;
    y = 0.316 * safezoneH + safezoneY;
    w = 0.09 * safezoneW;
    h = 0.033 * safezoneH;
  };
  class A3W_Mission_timeout_txt: GREUH_RscStructuredText {
    idc = 1602;
    text = "A3W Mission Timeout";
    x = 0.2275 * safezoneW + safezoneX;
    y = 0.416 * safezoneH + safezoneY;
    w = 0.0875 * safezoneW;
    h = 0.04 * safezoneH;
  };
  class A3W_Mission_timeout_list: StdCombo {
    idc = 1612;
    x = 0.3275 * safezoneW + safezoneX;
    y = 0.416 * safezoneH + safezoneY;
    w = 0.09 * safezoneW;
    h = 0.033 * safezoneH;
  };
  class A3W_Mission_delay_txt: GREUH_RscStructuredText {
    idc = 1602;
    text = "A3W Mission Delay";
    x = 0.2275 * safezoneW + safezoneX;
    y = 0.364 * safezoneH + safezoneY;
    w = 0.0875 * safezoneW;
    h = 0.04 * safezoneH;
  };
  class A3W_Mission_delay_list: StdCombo {
    idc = 1611;
    x = 0.3275 * safezoneW + safezoneX;
    y = 0.368 * safezoneH + safezoneY;
    w = 0.09 * safezoneW;
    h = 0.033 * safezoneH;
  };

  // ------------------
  class CancelButton: StdButton {
    idc = -1;
    action = "closeDialog 0";
    text = "Exit";
    x = 0.2100 * safezoneW + safezoneX;
    y = 0.71 * safezoneH + safezoneY;
    w = 0.09 * safezoneW;
    h = 0.035 * safezoneH;
    default = true;
  };
  class ApplyButton : StdButton {
    idc = 1610;
    text = "Apply";
    onButtonClick = "apply_a3w_conf = 1";
    x = 0.3300 * safezoneW + safezoneX;
    y = 0.71 * safezoneH + safezoneY;
    w = 0.09 * safezoneW;
    h = 0.035 * safezoneH;
  };
};
