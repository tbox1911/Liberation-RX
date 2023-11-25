params ["_box", "_item"];

private _old_content = everyContainer _box;

if (_item isKindOf "Bag_Base") then {
	_box addBackpackCargoGlobal [_item, 1];
} else {
	_box addItemCargoGlobal [_item, 1];
};
sleep 0.1;

((everyContainer _box) - _old_content) select 0 select 1; 
