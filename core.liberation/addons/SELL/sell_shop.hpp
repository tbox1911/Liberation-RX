class Sell_Shop {
  	idd = 2305;
	name = "Sell_Shop";
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
			text = "$STR_SELL_NAME";
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
			text = $STR_SHOP_ACTION1;
			action = "sell_action = 1";
			x = 0.2300 * safezoneW + safezoneX;
			y = 0.7100 * safezoneH + safezoneY;
			w = 0.09 * safezoneW;
			h = 0.035 * safezoneH;
		};

	};
};
