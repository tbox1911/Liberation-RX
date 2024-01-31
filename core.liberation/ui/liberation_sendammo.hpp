class liberation_sendammo_menu {
  	idd = 2337;
	name = "liberation_sendammo_menu";
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
			text = $STR_SENDAMMO_MENU;
			x = 0.1985 * safezoneW + safezoneX;
			y = 0.1444 * safezoneH + safezoneY;
			w = 0.2375 * safezoneW;
			h = 0.04 * safezoneH;
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
		class IconImage {
			idc = -1;
			type = CT_STATIC;
			style = ST_PICTURE;
			colorText[] = {1, 1, 1, 1};
			colorBackground[] = {0, 0, 0, 1};
			sizeEx = 0.023;
			x = (0.206094 * safezoneW + safezoneX);
			y = 0.2294 * safezoneH + safezoneY;
			w = (0.015 * safezoneW);
			h = (0.025 * safezoneH);
			moving = false;
			font = FONTM;
			text = "";
		};
		class AmmoImageShadow : IconImage {
			x = (0.206094 * safezoneW + safezoneX) + 0.003;
			y = (0.2294 * safezoneH + safezoneY) + 0.005;
			text = "res\ui_ammo.paa";
			colorText[] = {0, 0, 0, 1};
		};
		class AmmoImage : IconImage {
			x = (0.206094 * safezoneW + safezoneX);
			y = 0.2294 * safezoneH + safezoneY;
			text = "res\ui_ammo.paa";
		};
		class PlayerAmmoText: StdText {
			idc = 230;
			x = 0.226094 * safezoneW + safezoneX;
			y = 0.2294 * safezoneH + safezoneY;
			w = 0.071875 * safezoneW;
			h = 0.033 * safezoneH;
			font = "PuristaMedium";
			colorText[] = {0.75, 0, 0, 1};
			size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
			shadow = 1;
		};
		class PlayerText: GREUH_RscStructuredText {
			idc = -1;
			text = $STR_SENDAMMO_PLAYER;
			x = 0.206094 * safezoneW + safezoneX;
			y = 0.2976 * safezoneH + safezoneY;
			w = 0.061875 * safezoneW;
			h = 0.033 * safezoneH;

		};
		class PlayerList: StdCombo {
			idc = 231;
			x = 0.263437 * safezoneW + safezoneX;
			y = 0.2976 * safezoneH + safezoneY;
			w = 0.149531 * safezoneW;
			h = 0.033 * safezoneH;
			//sizeEx = 0.018 * safezoneH * GUI_GRID_H * GUI_GRID_H;
		};
		class AmmoText: GREUH_RscStructuredText {
			idc = -1;
			text = $STR_SENDAMMO_AMMO;
			x = 0.206094 * safezoneW + safezoneX;
			y = 0.3658 * safezoneH + safezoneY;
			w = 0.061875 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class AmmoList: StdCombo {
			idc = 232;
			x = 0.263437 * safezoneW + safezoneX;
			y = 0.3658 * safezoneH + safezoneY;
			w = 0.149531 * safezoneW;
			h = 0.033 * safezoneH;
		};
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
		class SendAmmo : StdButton {
			idc = -1;
			text = $STR_SENDAMMO_SEND;
			onButtonClick = "send_ammo = 1";
			x = 0.3300 * safezoneW + safezoneX;
			y = 0.71 * safezoneH + safezoneY;
			w = 0.09 * safezoneW;
			h = 0.035 * safezoneH;
		};
	};
};
