extends Camera2D

signal floor_changed

@export var _player: Player 
var current_floor: int = 0

@onready var room_height: int = get_viewport_rect().size.y 
@onready var _camera_position_offset: float = global_position.y


func _process(delta):
	var player_pos = _player.global_position
	var new_floor = floor(abs(player_pos.y) / room_height)
	
	if new_floor != current_floor:
		current_floor = new_floor
		global_position.y = _camera_position_offset - current_floor * room_height
		
		floor_changed.emit(current_floor)
		
