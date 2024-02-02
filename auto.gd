extends Node

var mouse_sensitivity := 0.002

var torches: int = 0:
	get:
		return torches
	set(value):
		torches = value
		torches_updated.emit(torches)
var torches_total: int = 0
var torches_label: Label
var torches_timer: Timer
var candle: Node3D
signal torches_updated

func restart():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	torches = 0
	torches_total = 0
	# this could instead be done in _ready() inside of the candle, but it works and i'm tired :P
	candle.model.mesh.height = candle.original_height
	get_tree().reload_current_scene()

func win():
	restart()