
extends Control

@onready var toggle_music_button: TextureButton = $ToggleMusicButton
@export var bg_music: AudioStreamPlayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	toggle_music_button.button_down.connect(_on_button_pressed)


func _on_button_pressed() -> void:
	if toggle_music_button.button_pressed:
		bg_music.play()
	else:
		bg_music.stop()
