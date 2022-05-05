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
			y = 0.2294 * safezoneH + safezoneY;
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
			y = 0.2294 * safezoneH + safezoneY;
			w = 0.151875 * safezoneW;
			h = 0.033 * safezoneH;
			font = "PuristaMedium";
            align = "center";
			colorText[] = {0, 0, 1};
			size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
 		};
		class JKB_titleList : StdCombo {
			idc = 231;
			x = 0.2100 * safezoneW + safezoneX;
			y = 0.2876 * safezoneH + safezoneY;
			w = 0.20 * safezoneW;
			h = 0.033 * safezoneH;
			//sizeEx = 0.018 * safezoneH * GUI_GRID_H * GUI_GRID_H;
		};
		class StopButton : StdButton {
			idc = -1;
			text = $STR_JKB_STOP;
			onButtonClick = "play_music = 2";
			x = 0.2100 * safezoneW + safezoneX;
			y = 0.386 * safezoneH + safezoneY;
			w = 0.09 * safezoneW;
			h = 0.035 * safezoneH;
			default = true;
		};
		class PlayButton : StdButton {
			idc = -1;
			text = $STR_JKB_START;
			onButtonClick = "play_music = 1";
			x = 0.3300 * safezoneW + safezoneX;
			y = 0.386 * safezoneH + safezoneY;
			w = 0.09 * safezoneW;
			h = 0.035 * safezoneH;
		};
		class CancelButton : StdButton {
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
