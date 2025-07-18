## This script handles opening new floors upon completion and moving the camera between floors

extends Node2D

@onready var levels: Node2D = $Levels
@onready var room_height: int = get_viewport_rect().size.y 
@onready var _player: Player = $Player/Player

var current_floor = 0


func _ready() -> void:
	Global.start()
	
	for level in levels.get_children():
		level.level_cleared.connect(_on_level_cleared)
		

func _process(delta):
	var player_y_pos = _player.global_position.y 
	var new_floor = floori(abs(player_y_pos) / room_height)
	var current_camera = get_viewport().get_camera_2d()
	
	if new_floor != current_floor and _is_floor_exists(new_floor):
		levels.get_children()[current_floor].camera_2d.enabled = false
		current_floor = new_floor
		levels.get_children()[current_floor].camera_2d.enabled = true


func _on_level_cleared() -> void:
	if not _is_floor_exists(current_floor + 1):
		return
	
	var next_floor = levels.get_children()[current_floor + 1]
	next_floor.open_gate()


func _game_over() -> void:
	_player.queue_free()


func _on_floor_changed(floor: int) -> void:
	current_floor = floor


func _is_floor_exists(floor: int) -> bool:
	return floor < len(levels.get_children())
