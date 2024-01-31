class VIRT_vehicle_garage {
  	idd = 2301;
	name = "VIRT_vehicle_garage";
	movingEnable = false;
	enableSimulation = true;

	class controlsBackground {
		class OuterBG1: StdBG {
			colorBackground[] = COLOR_BROWN;
			x = 0.19175 * safezoneW + safezoneX;
			y = 0.1324 * safezoneH + safezoneY;
			w = 0.25 * safezoneW;
			h = 0.62 * safezoneH;
		};
		class OuterBG_F1: OuterBG1 {
			style = ST_FRAME;
		};
		class InnerBG1: OuterBG1 {
			colorBackground[] = COLOR_GREEN;
			x = 0.1985 * safezoneW + safezoneX;
			y = 0.1916 * safezoneH + safezoneY;
			w = 0.2375 * safezoneW;
			h = 0.512 * safezoneH;
		};
		class InnerBG_F1: InnerBG1 {
			style = ST_FRAME;
		};
	};

	class controls {
		class Header: StdHeader {
			text = $STR_VIRT_GARAGE;
			x = 0.1985 * safezoneW + safezoneX;
			y = 0.1444 * safezoneH + safezoneY;
			w = 0.2375 * safezoneW;
			h = 0.04 * safezoneH;
		};

		class VehList: StdListNBox {
			idc = 110;
			x = 0.205887 * safezoneW + safezoneX;
			y = 0.2074 * safezoneH + safezoneY;
			w = 0.221719 * safezoneW;
			h = 0.473 * safezoneH;
			columns[] = {0, 0.75};
			onLBSelChanged = "";
			shadow = 2;
			rowHeight = "1.25 * 0.018 * safezoneH";
			colorPicture[] = {1,1,1,1};
			colorPictureSelected[] = {0,1,0,1};
			colorPictureDisabled[] = {0.4,0.4,0.4,1};
		};

		class CancelButton : StdButton {
			idc = -1;
			action = "closeDialog 0";
			text = "X";
			x = 0.42 * safezoneW + safezoneX;
			y = 0.1444 * safezoneH + safezoneY;
			w = 0.015 * safezoneW;
			h = 0.02 * safezoneH;
			default = true;
		};

		class LoadButton : StdButton {
			idc = 120;
			text = $STR_GARAGE_LOAD;
			action = "load_veh = 1";
			x = 0.33 * safezoneW + safezoneX;
			y = 0.71 * safezoneH + safezoneY;
			w = 0.09 * safezoneW;
			h = 0.035 * safezoneH;
		};
		class UnloadButton : StdButton {
			idc = 121;
			text = $STR_GARAGE_UNLOAD;
			action = "load_veh = 2";
			x = 0.21 * safezoneW + safezoneX;
			y = 0.71 * safezoneH + safezoneY;
			w = 0.09 * safezoneW;
			h = 0.035 * safezoneH;
		};
	};
};
