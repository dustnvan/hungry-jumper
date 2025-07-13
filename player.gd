class_name Player extends CharacterBody2D

const GRAVITY := 980.0
const FRICTION := 20.0
const BOUNCE_FORCE  := 100.0

@export var speed := 5.0


var prev_velocity_x: float = 0.0

@onready var _sprite_2d: Sprite2D = $Sprite2D

	
func slingshot(trajectory_vector: Vector2):	
	if not is_on_floor(): return
	velocity = trajectory_vector * speed
	

func _physics_process(delta: float) -> void:
	prev_velocity_x = velocity.x
	if is_on_floor():
		_sprite_2d.frame = 0
		velocity.x = lerpf(velocity.x, 0, FRICTION * delta)
	else:
		velocity.y += GRAVITY * delta
		_sprite_2d.frame = 1
		
	move_and_slide()
	
	# Bounce if hitting wall
	if is_on_wall():
		if get_slide_collision_count() > 0:
			var collision = get_slide_collision(0)
			var normal = collision.get_normal()
		
			if abs(normal.x) > 0.9:
				print(prev_velocity_x)
				velocity.x = abs(prev_velocity_x) * normal.x  

	
	
