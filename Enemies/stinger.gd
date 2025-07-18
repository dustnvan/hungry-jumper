extends Area2D

const TIMESCALE = 0.1
const FREEZE_DURATION = 0.3

@onready var sting_animation: AnimationPlayer = $StingAnimation

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(player: Player):
	player.velocity = Vector2.ZERO
	sting_animation.play("Sting")


func frame_freeze() -> void:
	Engine.time_scale = TIMESCALE
	await get_tree().create_timer(FREEZE_DURATION * TIMESCALE).timeout
	Engine.time_scale = 1
