extends "res://scripts/DeathManager.gd"

const ITEM_SLCT_LOG := "TotoBOPE-ItemSelection:DeathManager"

signal cp_death

func MainDeathRoutine():
	await super()
	cp_death.emit()
