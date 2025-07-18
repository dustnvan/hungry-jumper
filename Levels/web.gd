extends Area2D

const WEB_FRICTION := 15 
var _player: Player = null
var is_slowing_down: bool = false

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


func _physics_process(delta: float) -> void:
	if _player and not _player.is_hovering:
		_player.velocity = lerp(_player.velocity, Vector2.ZERO, delta * WEB_FRICTION )
		
		if _player.velocity.length() < 5.0:
			_player.velocity = Vector2.ZERO
			_player.is_hovering = true
		

func _on_body_entered(player: Player) -> void:
	_player = player
	_player.jump_landing.play()
	_player.entered_web = true
	
	
func _on_body_exited(player: Player) -> void:
	player.is_hovering = false
	_player.entered_web = false
	_player = null
	
	
