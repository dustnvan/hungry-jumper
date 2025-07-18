extends Area2D

const WEB_FRICTION := 15 

var _player: Player

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _physics_process(delta: float) -> void:
	if _player:
		_player.velocity = lerp(_player.velocity, Vector2.ZERO, delta * WEB_FRICTION )
		_player.sprite_2d.frame = 0

func _on_body_entered(player: Player) -> void:
	_player = player
	player.entered_web = true
	await get_tree().create_timer(1).timeout
	player.sleep_particles.emitting = true
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file("res://game_over_menu.tscn")
