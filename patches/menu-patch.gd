extends "./patch.gd"

const CPGameOptionsMenuManager = preload("../util/CPGameOptionsMenuManager.gd")
const ITEM_SLCT_LOG := "TotoBOPE-ItemSelection:MenuPatch"

var manager: CPGameOptionsMenuManager

func _init():
	scene_name = "menu"

func _apply(root: Node):
	ModLoaderLog.debug("Apply phase started", ITEM_SLCT_LOG)
	self.manager = _create_custom_manager(root)
	ModLoaderLog.debug("Custom menu created", ITEM_SLCT_LOG)
	
	var menu_manager = root.get_node("standalone managers/menu manager")
	var mod_manager = self.manager
	
	menu_manager.buttons[22].disconnect("is_pressed", menu_manager.Start);
	menu_manager.buttons[22].connect("is_pressed", _on_custom_start_click)
	ModLoaderLog.debug("Start button rebind successfull", ITEM_SLCT_LOG)
	ModLoaderLog.debug("Apply phase finished", ITEM_SLCT_LOG)
	return true

func _on_custom_start_click():
	ModLoaderLog.debug("Trying to show mod menu", ITEM_SLCT_LOG)
	self.manager.show()

func _create_custom_manager(root: Node):
	var parent = root.get_node("standalone managers")
	var manager = CPGameOptionsMenuManager.new(root)
	parent.add_child(manager)
	return manager
