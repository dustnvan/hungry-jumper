class_name Level extends Node2D

signal level_reached(level: Level)
signal level_cleared

@onready var _locked_gate: Node2D = $LockedGate
@onready var _entrance_light: PointLight2D = $EntranceLight
@onready var _enemies: Node = $Enemies
@onready var camera_2d: Camera2D = $Camera2D

var _enemies_in_level: int = 0


func _ready() -> void:
	for enemy in _enemies.get_children():
		_enemies_in_level += 1
		enemy.tree_exited.connect(_enemy_died)


func _enemy_died() -> void:
	_enemies_in_level -= 1
	if not _enemies_in_level:
		level_cleared.emit()


func open_gate() -> void:
	_locked_gate.enabled = false
	_entrance_light.enabled = true
	
