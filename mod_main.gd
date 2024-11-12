extends Node

const CPModConfig = preload("./util/CPModConfig.gd")
const AUTHORNAME_MODNAME_DIR := "TotoBOPE-ItemSelection"
const AUTHORNAME_MODNAME_LOG_NAME := "TotoBOPE-ItemSelection:Main"
var mod_dir_path := ""
var patches_dir_path := ""

var patches := {}
var last_scene := ""

func _init() -> void:
	ModLoaderLog.debug("Init phase started", AUTHORNAME_MODNAME_LOG_NAME)
	mod_dir_path = CPModConfig.get_root_path()
	randomize()
	add_extensions()
	add_patches()
	ModLoaderLog.debug("Init phase finished", AUTHORNAME_MODNAME_LOG_NAME)
	
func add_patches() -> void:
	patches_dir_path = mod_dir_path + "/patches"
	
	var dir = DirAccess.open(patches_dir_path)
	for file in dir.get_files():
		if (file == "patch.gd"):
			continue
		var cl = load(patches_dir_path + "/" + file)
		var obj = cl.new()
		ModLoaderLog.debug("Found patch for scene '" + obj.getSceneName() + "': " + file, AUTHORNAME_MODNAME_LOG_NAME)
		
		if !(patches.has(obj.getSceneName())):
			patches[obj.getSceneName()] = []
		patches[obj.getSceneName()].append(obj)
		
func add_extensions() -> void:
	ModLoaderMod.install_script_extension(mod_dir_path+"/extensions/scripts/DeathManager.gd")
	ModLoaderMod.install_script_extension(mod_dir_path+"/extensions/scripts/ItemManager.gd")
	ModLoaderMod.install_script_extension(mod_dir_path+"/extensions/scripts/BurnerPhone.gd")
	ModLoaderMod.install_script_extension(mod_dir_path+"/extensions/scripts/ShellExamine.gd")
	ModLoaderMod.install_script_extension(mod_dir_path+"/extensions/scripts/ShellSpawner.gd")
	ModLoaderMod.install_script_extension(mod_dir_path+"/extensions/scripts/ShellLoader.gd")

func _ready() -> void:
	ModLoaderLog.info("Mod Ready!", AUTHORNAME_MODNAME_LOG_NAME)
	
func _process(delta):
	var scene := get_scene_name()
	if (!scene):
		return
	if !(patches.has(scene.name)):
		return
		
	var repeated = (last_scene == scene.name)
	last_scene = scene.name
	
	if (!repeated):
		ModLoaderLog.debug("Scene loaded: " + last_scene, AUTHORNAME_MODNAME_LOG_NAME)
		
	var patchArr = patches[scene.name]
	for patch in patchArr:
		patch.apply(scene, repeated)
		
func get_scene_name() -> Node:
	return get_tree().current_scene;
