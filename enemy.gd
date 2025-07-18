class_name Enemy extends Node2D

@export var _speed: float = 50.0
@export var _death_effects: PackedScene  

@onready var hurtbox: Hurtbox = %Hurtbox

var last_position = Vector2.ZERO


func _ready() -> void:
	hurtbox.died.connect(on_died)


func on_died(player: Player) -> void: 
	player.velocity *= 0.5
	var death_effects_instance: Node2D = _death_effects.instantiate()
	death_effects_instance.global_position = global_position
	get_tree().root.add_child(death_effects_instance)
	
	queue_free()

	
