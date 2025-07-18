extends Path2D

@export var actor: Node2D 
@export var speed: float = 50.0

var last_position: Vector2
@onready var path_follow_2d: PathFollow2D = $PathFollow2D


func _physics_process(delta: float) -> void:
	path_follow_2d.progress += speed * delta

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	actor.tree_exited.connect(queue_free)
