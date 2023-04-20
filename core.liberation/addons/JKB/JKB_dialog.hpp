class JKB_dialog {
  	idd = 2306;
	name = "JKB_dialog";
	movingEnable = false;
	enableSimulation = true;
	class controlsBackground {
		class OuterBG1: StdBG {
			colorBackground[] = COLOR_BROWN;
			x = 0.19175 * safezoneW + safezoneX;
			y = 0.1324 * safezoneH + safezoneY;
			w = 0.25 * safezoneW;
			h = 0.296 * safezoneH;
		};
		class OuterBG_F1: OuterBG1 {
			style = ST_FRAME;
		};
		class InnerBG1: OuterBG1 {
			colorBackground[] = COLOR_GREEN;
			x = 0.1985 * safezoneW + safezoneX;
			y = 0.1916 * safezoneH + safezoneY;
			w = 0.2375 * safezoneW;
			h = 0.188 * safezoneH;
		};
		class InnerBG_F1: InnerBG1 {
			style = ST_FRAME;
		};
	};
	class GREUH_RscStructuredText {
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

	class controls {
		class Header: StdHeader {
			text = $STR_JKB_MENU;
			x = 0.1985 * safezoneW + safezoneX;
			y = 0.1444 * safezoneH + safezoneY;
			w = 0.2375 * safezoneW;
			h = 0.04 * safezoneH;
		};
		class VehText: StdText {
			idc = -1;
			x = (0.210 * safezoneW + safezoneX);
			y = 0.2094 * safezoneH + safezoneY;
			w = 0.061 * safezoneW;
			h = 0.033 * safezoneH;
			font = "PuristaMedium";
            align = "center";
			colorText[] = {1, 1, 1};
			size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
			text = "Now listening: ";
 		};
        class VehText2: StdText {
			idc = 230;
			x = (0.272 * safezoneW + safezoneX);
			y = 0.2094 * safezoneH + safezoneY;
			w = 0.160 * safezoneW;
			h = 0.033 * safezoneH;
			font = "PuristaMedium";
            align = "center";
			colorText[] = {0, 0, 1};
			size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
 		};
		class JKB_titleList: StdCombo {
			idc = 231;
			x = 0.210 * safezoneW + safezoneX;
			y = 0.2576 * safezoneH + safezoneY;
			w = 0.20 * safezoneW;
			h = 0.033 * safezoneH;
			//sizeEx = 0.018 * safezoneH * GUI_GRID_H * GUI_GRID_H;
		};
		class VehText3: StdText {
			idc = -1;
			x = (0.210 * safezoneW + safezoneX);
			y = 0.3058 * safezoneH + safezoneY;
			w = 0.075 * safezoneW;
			h = 0.033 * safezoneH;
			font = "PuristaMedium";
            align = "center";
			colorText[] = {1, 1, 1};
			size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
			text = "Music in Jukebox: ";
 		};
        class VehText4: StdText {
			idc = 232;
			x = (0.286 * safezoneW + safezoneX);
			y = 0.3058 * safezoneH + safezoneY;
			w = 0.151875 * safezoneW;
			h = 0.033 * safezoneH;
			font = "PuristaMedium";
            align = "center";
			colorText[] = {0, 0, 1};
			size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
 		};
		class AutoplayCB: RscCheckbox {
			idc = 233;
			text = "Auto play";
			x = (0.210 * safezoneW + safezoneX);
			y = 0.3540 * safezoneH + safezoneY;
			w = 0.0125 * safezoneW;
			h = 0.02 * safezoneH;
			columns = 1;
			rows = 1;
			strings[] = {" "};
			checked_strings[] = {"X"};
			onCheckBoxesSelChanged = "[_this] execVM 'addons\JKB\fn_toggle.sqf';";
		};
		class AutoplayCBText: GREUH_RscStructuredText {
			idc = -1;
			text = "<t size='0.7'>Auto play</t>";
			x = (0.226 * safezoneW + safezoneX);
			y = 0.3540 * safezoneH + safezoneY;
			w = 0.05 * safezoneW;
			h = 0.02 * safezoneH;
		};
		class RandomCB: RscCheckbox {
			idc = 234;
			text = "Random";
			x = (0.300 * safezoneW + safezoneX);
			y = 0.3540 * safezoneH + safezoneY;
			w = 0.0125 * safezoneW;
			h = 0.02 * safezoneH;
			columns = 1;
			rows = 1;
			strings[] = {" "};
			checked_strings[] = {"X"};
			onCheckBoxesSelChanged = "[_this] execVM 'addons\JKB\fn_toggle.sqf';";
		};
		class RandomCBText: GREUH_RscStructuredText	{
			idc = -1;
			text = "<t size='0.7'>Random</t>";
			x = (0.316 * safezoneW + safezoneX);
			y = 0.3540 * safezoneH + safezoneY;
			w = 0.05 * safezoneW;
			h = 0.02 * safezoneH;
		};
		class StopButton: StdButton {
			idc = -1;
			text = $STR_JKB_STOP;
			onButtonClick = "play_music = 2";
			x = 0.2100 * safezoneW + safezoneX;
			y = 0.386 * safezoneH + safezoneY;
			w = 0.09 * safezoneW;
			h = 0.035 * safezoneH;
			default = true;
		};
		class PlayButton: StdButton {
			idc = -1;
			text = $STR_JKB_START;
			onButtonClick = "play_music = 1";
			x = 0.3300 * safezoneW + safezoneX;
			y = 0.386 * safezoneH + safezoneY;
			w = 0.09 * safezoneW;
			h = 0.035 * safezoneH;
		};
		class CancelButton: StdButton {
			idc = -1;
			text = "X";
			onButtonClick = "closeDialog 0";
			x = 0.425 * safezoneW + safezoneX;
			y = 0.1444 * safezoneH + safezoneY;
			w = 0.01 * safezoneW;
			h = 0.02 * safezoneH;
		};
	};
};
