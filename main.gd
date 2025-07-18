extends Control

@onready var play_button: Button = $MainMenu/PlayButton
const GAME = "res://Game.tscn"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play_button.button_down.connect(func(): get_tree().change_scene_to_file(GAME))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
