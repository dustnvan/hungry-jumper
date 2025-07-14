class_name Enemy extends Node2D

@export var _speed: float = 50.0
@export var _death_effects: PackedScene  

@onready var _hurtbox: Area2D = %Hurtbox
@onready var _path_2d: Path2D = $Path2D
@onready var _path_follow_2d: PathFollow2D = $Path2D/PathFollow2D

func _ready() -> void:
	_hurtbox.body_entered.connect(_die)


func _physics_process(delta: float) -> void:
	if _path_follow_2d and _path_2d.curve:
		_path_follow_2d.progress += _speed * delta
	

func _die(body: Player) -> void: 
	var death_effects_instance: Node2D = _death_effects.instantiate()
	death_effects_instance.global_position = global_position
	get_tree().root.add_child(death_effects_instance)
	queue_free()
