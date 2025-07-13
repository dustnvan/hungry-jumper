extends Node

signal floor_changed

func _ready() -> void:
	floor_changed.connect(_on_floor_changed)
	

func _on_floor_changed(floor) -> void:
	pass
