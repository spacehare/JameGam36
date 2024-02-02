extends Node3D

@onready var light: OmniLight3D = $Light
@onready var particles: GPUParticles3D = $SmokeParent
@onready var area: Area3D = $Area3D

func _ready():
	Auto.torches_total += 1

func handle_candle(_area):
	burn()

func burn():
	Auto.torches += 1
	var remaining: int = Auto.torches_total - Auto.torches
	var hint: String
	match remaining:
		0:
			hint = "return the candle"
			Auto.torches_timer.start(5)
		1:
			hint = "%s torch left..." % remaining
			Auto.torches_timer.start(3)
		_:
			hint = "%s torches left..." % remaining
			Auto.torches_timer.start(3)

	Auto.torches_label.text = hint
	Auto.torches_label.visible = true
	area.get_child(0).set_deferred('disabled', true)
	light.visible = true
	particles.emitting = true
	var t = create_tween()
	t.tween_property(light, 'light_energy', 0, 10.0)
	t.finished.connect(func(): particles.emitting = false)

