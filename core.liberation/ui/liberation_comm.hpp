class CfgCommunicationMenu
{
	class LRX_Unstuck
	{
		text = "Unblock unit";
		submenu = "";
		expression = "[groupSelectedUnits player] spawn PAR_unblock_AI";
		icon = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\call_ca.paa";
		cursor = "\a3\Ui_f\data\IGUI\Cfg\Cursors\iconCursorSupport_ca.paa";
		enable = "1";
		removeAfterExpressionCall = 0;
	};

	class LRX_Abandon
	{
		text = "Abandon Prisoner";
		submenu = "";
		expression = "[groupSelectedUnits player] spawn PAR_abandon_priso";
		icon = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\defend_ca.paa";
		cursor = "\a3\Ui_f\data\IGUI\Cfg\Cursors\iconCursorSupport_ca.paa";
		enable = "1";
		removeAfterExpressionCall = 0;
	};
};
