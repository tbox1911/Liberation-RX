class RPT_vehicle_repaint {
  	idd = 2300;
	name = "RPT_vehicle_repaint";
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
			text = $STR_PAINT_SHOP;
			x = 0.1985 * safezoneW + safezoneX;
			y = 0.1444 * safezoneH + safezoneY;
			w = 0.2375 * safezoneW;
			h = 0.04 * safezoneH;
		};
		class IconImage {
			idc = -1;
			type = CT_STATIC;
			style = ST_PICTURE;
			colorText[] = {1, 1, 1, 1};
			colorBackground[] = {0, 0, 0, 1};
			sizeEx = 0.023;
			x = 0.1;
			y = 0.1;
			w = (0.030 * safezoneW);
			h = (0.050 * safezoneH);
			moving = false;
			font = FONTM;
			text = "";
		};
		class VehImageShadow : IconImage {
            idc = 235;
			x = (0.2160 * safezoneW + safezoneX) + 0.003;
			y = (0.2790 * safezoneH + safezoneY) + 0.005;
			colorText[] = {0, 0, 0, 1};
		};
		class VehImage : IconImage {
            idc = 234;
            x = 0.2160 * safezoneW + safezoneX;
			y = 0.2790 * safezoneH + safezoneY;
		};
		 class VehText: StdText {
			idc = -1;
			x = (0.2100 * safezoneW + safezoneX);
			y = 0.2294 * safezoneH + safezoneY;
			w = 0.051875 * safezoneW;
			h = 0.033 * safezoneH;
			font = "PuristaMedium";
            align = "center";
			colorText[] = {1, 1, 1};
			size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
			text = "Vehicle: ";
 		};
        class VehText2: StdText {
			idc = 230;
			x = (0.2490 * safezoneW + safezoneX);
			y = 0.2294 * safezoneH + safezoneY;
			w = 0.151875 * safezoneW;
			h = 0.033 * safezoneH;
			font = "PuristaMedium";
            align = "center";
			colorText[] = {0, 0, 1};
			size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
 		};
		class RPT_colorList : StdCombo {
			idc = 231;
			x = 0.263437 * safezoneW + safezoneX;
			y = 0.2976 * safezoneH + safezoneY;
			w = 0.149531 * safezoneW;
			h = 0.033 * safezoneH;
			//sizeEx = 0.018 * safezoneH * GUI_GRID_H * GUI_GRID_H;
		};
		class CancelButton : StdButton {
			idc = -1;
			action = "closeDialog 0";
			text = "Exit";
			x = 0.2100 * safezoneW + safezoneX;
			y = 0.71 * safezoneH + safezoneY;
			w = 0.09 * safezoneW;
			h = 0.035 * safezoneH;
			default = true;
		};
		class PaintButton : StdButton {
			idc = -1;
			text = $STR_SHOP_PAINT;
			onButtonClick = "paint_veh = 1";
			x = 0.3300 * safezoneW + safezoneX;
			y = 0.71 * safezoneH + safezoneY;
			w = 0.09 * safezoneW;
			h = 0.035 * safezoneH;
		};
	};
};
