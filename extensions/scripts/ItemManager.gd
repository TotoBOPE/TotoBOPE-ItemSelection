extends "res://scripts/ItemManager.gd"

const ITEM_SLCT_LOG := "TotoBOPE-ItemSelection:ItemManager"

signal cp_steal_start
signal cp_steal_end

func SetupItemSteal():
	await super()
	cp_steal_start.emit()
	
func RevertItemSteal():
	await super()
	cp_steal_end.emit()

func RevertItemSteal_Timeout():
	await super()
	cp_steal_end.emit()
