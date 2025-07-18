class_name Player extends CharacterBody2D

const GRAVITY := 980.0
const FLOOR_FRICTION := 25.0
const BOUNCE_FORCE := 75.0
const IDLE_FRAME: int = 0
const POUNCE_FRAME: int = 1
const JUMP_FRAME: int = 2
const JUMP_POWER := 3.5

var prev_velocity_x: float = 0.0
var is_aiming: bool = false
var _just_jumped := false
var is_hovering := false
var entered_web := false

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var jump_particles: GPUParticles2D = $JumpParticles
@onready var jump_sound: AudioStreamPlayer2D = $JumpSound
@onready var jump_landing: AudioStreamPlayer2D = $JumpLanding
@onready var sleep_particles: GPUParticles2D = $SleepParticles

func _init() -> void:
	add_to_group("player")
	

func _physics_process(delta: float) -> void:
	prev_velocity_x = velocity.x
	if is_on_floor() or is_hovering:
		if is_aiming:
			sprite_2d.frame = POUNCE_FRAME
		else:
			sprite_2d.frame = IDLE_FRAME
		
		# Prevents friction from being applied right before jumping
		if not _just_jumped:
			velocity.x = lerpf(velocity.x, 0, FLOOR_FRICTION * delta)
			
	# Apply gravity
	else:
		if not entered_web:
			velocity.y += GRAVITY * delta
			sprite_2d.frame = JUMP_FRAME
		
	move_and_slide()
	
	if get_slide_collision_count() > 0:
		var collision = get_slide_collision(0)
		var normal = collision.get_normal()
		
		# Landed
		if normal.y < -0.9 and _just_jumped:
			jump_landing.play()
			_just_jumped = false
			
		# Bounce if hitting wall
		if is_on_wall():
				if abs(normal.x) > 0.9:
					velocity.x = abs(prev_velocity_x) * normal.x  


func slingshot(trajectory_vector: Vector2) -> void:	
	if not is_on_floor() and not is_hovering: return
	velocity = trajectory_vector * JUMP_POWER
	jump_particles.emitting = true
	jump_particles.restart()
	_just_jumped = true
	jump_sound.play()
