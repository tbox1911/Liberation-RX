class Sector_Defense {
  	idd = 2310;
	name = "Sector_Defense";
	movingEnable = false;
	enableSimulation = true;

	class controlsBackground {
		class OuterBG1: StdBG {
			colorBackground[] = COLOR_BROWN;
			x = 0.1917 * safezoneW + safezoneX;
			y = 0.1324 * safezoneH + safezoneY;
			w = 0.2476 * safezoneW;
			h = 0.62 * safezoneH;
		};
		class OuterBG_F1: OuterBG1 {
			style = ST_FRAME;
		};
		class InnerBG1: OuterBG1 {
			colorBackground[] = COLOR_GREEN;
			x = 0.1985 * safezoneW + safezoneX;
			y = 0.1916 * safezoneH + safezoneY;
			w = 0.1515 * safezoneW;
			h = 0.55 * safezoneH;
		};
		class InnerBG_F1: InnerBG1 {
			style = ST_FRAME;
		};
	};

	class controls {
		class Header: StdHeader {
			text = "$STR_FOB_SECTORS_LIST";
			x = 0.198875 * safezoneW + safezoneX;
			y = 0.1414 * safezoneH + safezoneY;
			w = 0.2340 * safezoneW;
			h = 0.044 * safezoneH;
		};

		class VehList1 : StdListNBox {
			idc = 110;
			columns[] = {0,0.75};
			onLBSelChanged = "";
			shadow = 2;
			rowHeight = "1.25 * 0.018 * safezoneH";
			colorPicture[] = {1,1,1,1};
			colorPictureSelected[] = {0,1,0,1};
			colorPictureDisabled[] = {0.4,0.4,0.4,1};
			x = 0.2027 * safezoneW + safezoneX;
			y = 0.2074 * safezoneH + safezoneY;
			w = 0.1480 * safezoneW;
			h = 0.53 * safezoneH;
		};

		class CancelButton : StdButton {
			idc = -1;
			action = "closeDialog 0";
			text = "X";
			x = 0.4163 * safezoneW + safezoneX;
			y = 0.1414 * safezoneH + safezoneY;
			w = 0.015 * safezoneW;
			h = 0.02 * safezoneH;
			default = true;
		};

		class Button0 : StdButton {
			idc = 120;
			text = "$STR_FOB_OFF";
			action = "build_type = 0; build_action = 1";
			x = 0.3572 * safezoneW + safezoneX;
			y = 0.2074 * safezoneH + safezoneY;
			w = 0.07 * safezoneW;
			h = 0.03 * safezoneH;
		};

		class Button1 : StdButton {
			idc = 121;
			text = "$STR_FOB_LIGHT";
			action = "build_type = 1; build_action = 1";
			x = 0.3572 * safezoneW + safezoneX;
			y = 0.2474 * safezoneH + safezoneY;
			w = 0.07 * safezoneW;
			h = 0.03 * safezoneH;
		};

		class Button2 : StdButton {
			idc = 122;
			text = "$STR_FOB_MEDIUM";
			action = "build_type = 2; build_action = 1";
			x = 0.3572 * safezoneW + safezoneX;
			y = 0.2874 * safezoneH + safezoneY;
			w = 0.07 * safezoneW;
			h = 0.03 * safezoneH;
		};

		class Button3 : StdButton {
			idc = 123;
			text = "$STR_FOB_HEAVY";
			action = "build_type = 3; build_action = 1";
			x = 0.3572 * safezoneW + safezoneX;
			y = 0.3274 * safezoneH + safezoneY;
			w = 0.07 * safezoneW;
			h = 0.03 * safezoneH;
		};

		class ButtonExit : StdButton {
			text = "$STR_FOB_EXIT";
			action = "closeDialog 0";
			x = 0.3572 * safezoneW + safezoneX;
			y = 0.4474 * safezoneH + safezoneY;
			w = 0.07 * safezoneW;
			h = 0.03 * safezoneH;
		};				
	};
};
