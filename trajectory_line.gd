extends Line2D

const GRAVITY := 980.0
const MAX_VELOCITY := 100.0

var _is_dragging: bool = false
var _mouse_origin_pos: Vector2
var _mouse_end_pos: Vector2

@export var _player: Player


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("mouse_click"):
		_is_dragging = true
		_mouse_origin_pos = get_global_mouse_position()
	
		_mouse_end_pos = get_global_mouse_position()
	
	if event is InputEventMouseMotion and _is_dragging:
		global_position = global_position
		_mouse_end_pos = get_global_mouse_position()
		
		set_point_position(1, get_trajectory_vector())
		
		# Allows the user to drag back without going back to threshold
		if _mouse_origin_pos.distance_to(_mouse_end_pos) > MAX_VELOCITY:
			_mouse_origin_pos = _mouse_end_pos - _mouse_origin_pos.direction_to(_mouse_end_pos) * MAX_VELOCITY

	if event.is_action_released("mouse_click"):
		_is_dragging = false
		set_point_position(1, Vector2.ZERO)
		if _player.has_method("slingshot"):
			_player.slingshot(get_trajectory_vector())
		

func _physics_process(delta: float) -> void:
	if _is_dragging:
		global_position = _player.global_position
	

func get_trajectory_vector() -> Vector2:
		return -(_mouse_end_pos - _mouse_origin_pos).limit_length(MAX_VELOCITY)
	
