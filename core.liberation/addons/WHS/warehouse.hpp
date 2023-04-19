class Warehouse {
  	idd = 2302;
	name = "Warehouse";
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
			text = $STR_WAREHOUSE_SHOP;
			x = 0.1985 * safezoneW + safezoneX;
			y = 0.1444 * safezoneH + safezoneY;
			w = 0.2375 * safezoneW;
			h = 0.04 * safezoneH;
		};

		class VehListOut: StdListNBox {
			idc = 110;
			x = 0.2158 * safezoneW + safezoneX;
			y = 0.2074 * safezoneH + safezoneY;
			//w = 0.221719 * safezoneW;
			w = 0.1050 * safezoneW;
			h = 0.473 * safezoneH;
			columns[] = {0, 0.75};
			onLBSelChanged = "";
			shadow = 2;
			rowHeight = "1.25 * 0.018 * safezoneH";
			colorPicture[] = {1,1,1,1};
			colorPictureSelected[] = {0,1,0,1};
			colorPictureDisabled[] = {0.4,0.4,0.4,1};
		};

		class VehListIn: StdListNBox {
			idc = 111;
			x = 0.3166 * safezoneW + safezoneX;
			y = 0.2074 * safezoneH + safezoneY;
			//w = 0.221719 * safezoneW;
			w = 0.1200 * safezoneW;
			h = 0.473 * safezoneH;
			columns[] = {0, 0.75, 0.05};
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

		class UnloadButton : StdButton {
			idc = 120;
			text = $STR_GARAGE_LOAD;
			action = "load_box = 1";
			x = 0.21 * safezoneW + safezoneX;
			y = 0.71 * safezoneH + safezoneY;
			w = 0.09 * safezoneW;
			h = 0.035 * safezoneH;
		};

		class LoadButton : StdButton {
			idc = 121;
			text = $STR_GARAGE_UNLOAD;
			action = "load_box = 2";
			x = 0.33 * safezoneW + safezoneX;
			y = 0.71 * safezoneH + safezoneY;
			w = 0.09 * safezoneW;
			h = 0.035 * safezoneH;
		};
	};
};
