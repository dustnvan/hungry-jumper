extends Node2D

@onready var _camera_2d: Camera2D = $Camera2D
@onready var _player: Player = $Player

func _game_over() -> void:
	_player.queue_free()
	print("Game Over")
