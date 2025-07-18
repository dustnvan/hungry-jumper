class_name Hurtbox extends Area2D

signal died

@export var is_invincible: bool = false

func _ready() -> void:
	body_entered.connect(func(body): died.emit(body))
