extends Control

const GAME = "res://Game.tscn"

@onready var replay_button: Button = $MarginContainer/ReplayButton

func _ready() -> void:
	replay_button.button_down.connect(func(): get_tree().change_scene_to_file(GAME))
