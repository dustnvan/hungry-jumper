## This script handles opening new floors upon completion and moving the camera between floors

extends Node2D

@onready var _player: Player = $Player
@onready var levels: Node = $Levels

var current_floor = 0
@onready var room_height: int = get_viewport_rect().size.y 


func _ready() -> void:
	for level in levels.get_children():
		level.level_cleared.connect(_on_level_cleared)
		

func _process(delta):
	var player_pos = _player.global_position
	var new_floor = floori(abs(player_pos.y) / room_height)
	var current_camera = get_viewport().get_camera_2d()
	
	if new_floor != current_floor:
		levels.get_children()[current_floor].camera_2d.enabled = false
		current_floor = new_floor
		levels.get_children()[current_floor].camera_2d.enabled = true

func _on_level_cleared() -> void:
	if current_floor + 1 >= len(levels.get_children()):
		return
	
	var next_floor = levels.get_children()[current_floor + 1]
	next_floor.open_gate()


func _game_over() -> void:
	_player.queue_free()


func _on_floor_changed(floor: int) -> void:
	current_floor = floor
