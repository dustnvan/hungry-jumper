extends Line2D

const MAX_VELOCITY := 100.0
const MAX_ZOOM := 1.5
const NUM_POINTS_ON_TRAJECTORY_VECTOR: int = 5
const DRAG_SCALAR := 2.0 # Scales the distance between mouse origin/end so user doesn't have to drag as much

var _is_dragging: bool = false
var _mouse_origin_pos: Vector2
var _mouse_end_pos: Vector2

@export var _player: Player

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("mouse_click"):
		_is_dragging = true
		_mouse_origin_pos = get_global_mouse_position()
		_mouse_end_pos = get_global_mouse_position()
	
	if event is InputEventMouseMotion and _is_dragging:
		_mouse_end_pos = get_global_mouse_position()
		
		if _get_drag_distance() == MAX_VELOCITY:
			_mouse_origin_pos += _mouse_origin_pos.direction_to(_mouse_end_pos)
		
		var curve_points = _get_trajectory_points()
		clear_points()
		for p in curve_points:
			add_point(p)
			
		_player.is_aiming = true
		
	if event.is_action_released("mouse_click"):
		_is_dragging = false
		clear_points()
		if _player.has_method("slingshot"):
			_player.slingshot(_get_velocity_vector())

		_player.is_aiming = false


func _physics_process(delta: float) -> void:
	if _is_dragging:
		global_position = _player.global_position
	

func _get_velocity_vector() -> Vector2:
		return -(_get_drag_distance() * _mouse_origin_pos.direction_to(_mouse_end_pos))


func _get_trajectory_points() -> PackedVector2Array:
	var trajectory_points := PackedVector2Array()
	var time_step = 0.05
	var initial_velocity = _get_velocity_vector() * _player.JUMP_POWER
	var initial_position = Vector2.ZERO
	var gravity = _player.GRAVITY
	
	for i in range(NUM_POINTS_ON_TRAJECTORY_VECTOR):
		var t: float = i * time_step
		var pos: Vector2 = initial_position + (initial_velocity * t) + (0.5 * Vector2(0, gravity) * t * t)
		trajectory_points.append(pos)
	return trajectory_points


func _get_drag_distance() -> float:
	var _distance = _mouse_origin_pos.distance_to(_mouse_end_pos) * DRAG_SCALAR
	if _distance > MAX_VELOCITY:
		return MAX_VELOCITY
	
	return _distance 
	
	
	
