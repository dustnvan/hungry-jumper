extends Line2D

const MAX_VELOCITY := 100.0

@export var _player: Node2D

var _is_dragging: bool = false
var _mouse_origin_pos: Vector2
var _mouse_end_pos: Vector2

	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("mouse_click"):
		_is_dragging = true
		_mouse_origin_pos = get_global_mouse_position()
		_mouse_end_pos = get_global_mouse_position()
		
	if event is InputEventMouseMotion and _is_dragging:
		visible = true
		set_point_position(0, _player.global_position)
		set_point_position(1, _get_end_point())
			
	if event.is_action_released("mouse_click"):
		visible = false
		print("released")
	

func _get_end_point() -> Vector2:
	return _player.global_position * -(_mouse_end_pos - _mouse_origin_pos)

func _physics_process(delta: float) -> void:
	pass
