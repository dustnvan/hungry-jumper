extends Node2D

@onready var _camera_2d: Camera2D = $Camera2D
@onready var _player: Player = $Player
@onready var levels: Node = $Levels

var current_floor = 0


func _ready() -> void:
	for level in levels.get_children():
		level.level_cleared.connect(_on_level_cleared)
		
	_camera_2d.floor_changed.connect(_on_floor_changed)


func _on_level_cleared() -> void:
	if current_floor + 1 >= len(levels.get_children()):
		return
	
	var next_floor = levels.get_children()[current_floor + 1]
	next_floor.open_gate()


func _game_over() -> void:
	_player.queue_free()


func _on_floor_changed(floor: int) -> void:
	current_floor = floor
