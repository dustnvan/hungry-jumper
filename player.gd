class_name Player extends CharacterBody2D

const GRAVITY := 980.0
const FRICTION := 20.0
const BOUNCE_FORCE := 75.0
const IDLE_FRAME: int = 0
const POUNCE_FRAME: int = 1
const JUMP_FRAME: int = 2

@export var speed := 5.0

var prev_velocity_x: float = 0.0
var is_aiming: bool = false

@onready var _sprite_2d: Sprite2D = $Sprite2D



func _physics_process(delta: float) -> void:
	prev_velocity_x = velocity.x
	if is_on_floor():
		if is_aiming:
			_sprite_2d.frame = POUNCE_FRAME
		else:
			_sprite_2d.frame = IDLE_FRAME
		velocity.x = lerpf(velocity.x, 0, FRICTION * delta)
	else:
		velocity.y += GRAVITY * delta
		_sprite_2d.frame = JUMP_FRAME
		
	move_and_slide()
	
	# Bounce if hitting wall
	if is_on_wall():
		if get_slide_collision_count() > 0:
			var collision = get_slide_collision(0)
			var normal = collision.get_normal()
		
			if abs(normal.x) > 0.9:
				velocity.x = abs(prev_velocity_x) * normal.x  

	
func slingshot(trajectory_vector: Vector2) -> void:	
	if not is_on_floor(): return
	velocity = trajectory_vector * speed
