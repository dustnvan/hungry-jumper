extends Camera2D

@export var _player: Player 
var current_floor_y: int = 0

@onready var room_height: int = get_viewport_rect().size.y 
@onready var _camera_position_offset: float = global_position.y


func _process(delta):
	var player_pos = _player.global_position
	var new_floor_y = floor(abs(player_pos.y) / room_height)
	
	if new_floor_y != current_floor_y:
		current_floor_y = new_floor_y
		global_position.y = _camera_position_offset - current_floor_y * room_height
	
