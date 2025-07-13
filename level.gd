class_name Level extends Node2D

signal level_reached(level: Level)

@onready var _locked_gate: Node2D = $LockedGate
@onready var _entrance_light: PointLight2D = $EntranceLight

func _ready() -> void:
	
	for child in get_children():
		if child is not Enemy:
			continue
		
		child.tree_exited.connect(_enemy_died)


func _enemy_died() -> void:
	for child in get_children():
		if child is Enemy:
			return
		
	_locked_gate.enabled = false
	_entrance_light.enabled = true
	
