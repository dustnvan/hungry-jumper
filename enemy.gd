class_name Enemy extends AnimatableBody2D


@export var _death_effects: PackedScene  
@onready var hurtbox: Area2D = $Hurtbox


func _init() -> void:
	add_to_group("enemies") 


func _ready() -> void:
	hurtbox.body_entered.connect(_die)


func _die(body: Player) -> void: 
	var death_effects_instance: Node2D = _death_effects.instantiate()
	death_effects_instance.global_position = global_position
	get_tree().root.add_child(death_effects_instance)
	queue_free()
