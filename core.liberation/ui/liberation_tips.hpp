class liberation_tips {
	idd = 5137;
	movingEnable = false;
	controlsBackground[] = {};

	controls[] = { "OuterBG1", "OuterBG_F1", "InnerBG1", "InnerBG_F1", "Header", "ButtonClose", "NoticeStructuredText" };

	objects[] = {};

	class OuterBG1 : StdBG{
		colorBackground[] = COLOR_BROWN;
		x = (0.2 * safezoneW + safezoneX) - (2 * BORDERSIZE);
		y = (0.15 * safezoneH + safezoneY) - (3 * BORDERSIZE);
		w = (0.6 * safezoneW) + (4 * BORDERSIZE);
		h = (0.65 * safezoneH) + (6 * BORDERSIZE);
	};
	class OuterBG_F1 : OuterBG1 {
		style = ST_FRAME;
	};

	class InnerBG1 : OuterBG1 {
		colorBackground[] = COLOR_GREEN;
		x = (0.2 * safezoneW + safezoneX)  - ( BORDERSIZE);
		y = 0.2 * safezoneH + safezoneY - (1.5 * BORDERSIZE);
		w = (0.6 * safezoneW) +  (2 * BORDERSIZE);
		h = 0.55 * safezoneH  + (3 * BORDERSIZE);
	};
	class InnerBG_F1 : InnerBG1 {
		style = ST_FRAME;
	};
	class Header : StdHeader{
		x = 0.2 * safezoneW + safezoneX - (BORDERSIZE);
		y = 0.14 * safezoneH + safezoneY;
		w = 0.6 * safezoneW + ( 2 * BORDERSIZE);
		h = 0.05 * safezoneH - (BORDERSIZE);
		text = "-- Liberation RX - Tips --";
	};

	class ButtonClose : StdButton{
		idc = 752;
		x = 0.45 * safezoneW + safezoneX;
		y = 0.77 * safezoneH + safezoneY;
		w = 0.09 * safezoneW;
		h = 0.035 * safezoneH;
		text = "OK !";
		action = "closeDialog 0";
	};

	class NoticeStructuredText
	{
		idc = 515;
		type = CT_STRUCTURED_TEXT;
		colorBackground[] = COLOR_NOALPHA;
		style = ST_LEFT;
		x = -0.05;
		y = -0.060;
		w = (0.45 * safezoneW);
		h = 0.6 * safezoneH;
		text = "$STR_TUTO_TEXT12";
		size =  0.020 * safezoneH;
		shadow = 2;
		font = FONTM;
		color = "#e0e0e0";
		align = "left";
		valign = "top";
	};

};