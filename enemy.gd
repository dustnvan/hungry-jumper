class_name Enemy extends Node2D

@export var _speed: float = 50.0
@export var _death_effects: PackedScene  

@onready var _hurtbox: Area2D = %Hurtbox
@onready var _path_2d: Path2D = $Path2D
@onready var _path_follow_2d: PathFollow2D = $Path2D/PathFollow2D
@onready var _sprite_2d: AnimatedSprite2D = %Sprite2D

var last_position = Vector2.ZERO

func _ready() -> void:
	last_position = _path_follow_2d.position
	_hurtbox.body_entered.connect(_die)


func _physics_process(delta: float) -> void:
	if _path_follow_2d and _path_2d.curve:
		_path_follow_2d.progress += _speed * delta
		
	var direction = _path_follow_2d.position - last_position
	
	if direction.x != 0:
		_sprite_2d.flip_h = direction.x < 0
	
	last_position = _path_follow_2d.position
	

func _die(body: Player) -> void: 
	var death_effects_instance: Node2D = _death_effects.instantiate()
	death_effects_instance.global_position = global_position
	get_tree().root.add_child(death_effects_instance)
	queue_free()
