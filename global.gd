extends Node

var time_elapsed := 0.0
var running := false

func start():
	time_elapsed = 0.0
	running = true

func stop():
	running = false

func _process(delta):
	if running:
		time_elapsed += delta
