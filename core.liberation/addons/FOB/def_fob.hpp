class FOB_Defense {
  	idd = 2309;
	name = "FOB_Defense";
	movingEnable = false;
	enableSimulation = true;

	class controlsBackground {
		class OuterBG1: StdBG {
			colorBackground[] = COLOR_BROWN;
			x = 0.1917 * safezoneW + safezoneX;
			y = 0.1324 * safezoneH + safezoneY;
			w = 0.1651 * safezoneW;
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
			h = 0.512 * safezoneH;
		};
		class InnerBG_F1: InnerBG1 {
			style = ST_FRAME;
		};
	};

	class controls {
		class Header: StdHeader {
			text = "$STR_FOB_DEFENSE_NAME";
			x = 0.198875 * safezoneW + safezoneX;
			y = 0.1414 * safezoneH + safezoneY;
			w = 0.1515 * safezoneW;
			h = 0.044 * safezoneH;
		};

		class VehList1 : StdListNBox {
			idc = 110;
			columns[] = {0,0.78};
			onLBSelChanged = "";
			shadow = 2;
			rowHeight = "1.25 * 0.018 * safezoneH";
			colorPicture[] = {1,1,1,1};
			colorPictureSelected[] = {0,1,0,1};
			colorPictureDisabled[] = {0.4,0.4,0.4,1};
			x = 0.2027 * safezoneW + safezoneX;
			y = 0.2074 * safezoneH + safezoneY;
			w = 0.1515 * safezoneW;
			h = 0.484 * safezoneH;
		};

		class CancelButton : StdButton {
			idc = -1;
			action = "closeDialog 0";
			text = "X";
			x = 0.3338 * safezoneW + safezoneX;
			y = 0.1414 * safezoneH + safezoneY;
			w = 0.015 * safezoneW;
			h = 0.02 * safezoneH;
			default = true;
		};

		class SellButton : StdButton {
			idc = 120;
			text = "$STR_FOB_BUILD";
			action = "build_action = 1";
			x = 0.2300 * safezoneW + safezoneX;
			y = 0.7100 * safezoneH + safezoneY;
			w = 0.09 * safezoneW;
			h = 0.035 * safezoneH;
		};

		//----------------
		class Input_OuterBG : StdBG {
			idc = 521;
			style = ST_SINGLE;
			colorBackground[] = COLOR_BROWN;
			x = (0.46 * safezoneW + safezoneX) - (BORDERSIZE);
			y = ((BASE_Y + 0.31) * safezoneH) + safezoneY - (1.5 * BORDERSIZE);
			w = 0.17 * safezoneW +  (2 * BORDERSIZE);
			h = 0.35 * safezoneH  + (3 * BORDERSIZE);
		};
		class Input_InnerBG : StdBG {
			idc = 522;
			colorBackground[] = COLOR_GREEN;
			x = (0.46 * safezoneW + safezoneX);
			y = ((BASE_Y + 0.31) * safezoneH) + safezoneY;
			w = 0.17 * safezoneW;
			h = 0.35 * safezoneH;
		};
		class Input_OuterBG_F : Input_OuterBG {
			idc = 523;
			style = ST_FRAME;
		};
		class Input_InnerBG_F : Input_InnerBG {
			idc = 524;
			style = ST_FRAME;
		};
		class Input_ButtonName_Ok : StdButton {
			idc = 525;
			x = 0.58 * safezoneW + safezoneX;
			y = ((BASE_Y + 0.32) * safezoneH) + safezoneY;
			w = ((0.2 * safezoneW) / 5) - BORDERSIZE;
			text = "$STR_FOB_OK";
			action = "input_save = ctrlText 527;";
		};
		class Input_ButtonName_Abort : StdButton {
			idc = 526;
			x = 0.58 * safezoneW + safezoneX;
			y = ((BASE_Y + 0.36) * safezoneH) + safezoneY;
			w = ((0.2 * safezoneW) / 5) - BORDERSIZE;
			text = "$STR_FOB_CANCEL";
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
	};
};
