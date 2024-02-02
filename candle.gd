extends Node3D

@onready var area_pickup: Area3D = $Area3D
@onready var model: MeshInstance3D = %Mesh
@onready var candle_base: Node3D = %Base
@onready var candle_bottom: Node3D = $Bottom
@onready var wick: Node3D = $Wick
@onready var light: OmniLight3D = %Light
@onready var light_wick: OmniLight3D = %LightWick
@export var MAX_LIFE: float
@export var cheat := false
var frozen = false
@onready var life_seconds := MAX_LIFE:
	get:
		return life_seconds
	set(value):
		life_seconds = clampf(value, 0, MAX_LIFE)
		life_changed.emit(life_seconds)
		# print(life_seconds)
		if life_seconds == 0:
			extinguish()
			died.emit()
			alive = false
signal died
signal life_changed(new: float)
var original_height = 0.5
var alive = true
var main_tween: Tween

func _ready():
	Auto.candle = self
	model.position.y = candle_base.position.y + model.mesh.height / 2
	wick.position.y = model.position.y + model.mesh.height / 2
	if not cheat:
		main_tween = create_tween()
		main_tween.tween_property(model.mesh, 'height', 0.01, MAX_LIFE)
		main_tween.parallel().tween_property(model, 'position:y', candle_base.position.y + 0.005, MAX_LIFE)
		main_tween.parallel().tween_property(wick, 'position:y', candle_base.position.y + 0.01, MAX_LIFE)

func _physics_process(delta):
	if not cheat and not frozen and alive:
		life_seconds -= delta
	# printt(model.position.y, candle_base.position.y, life_seconds)

func freeze():
	frozen = true
	main_tween.stop()

func pick_up(node: Node3D):
	reparent(node.hand)
	transform = node.hand.transform
	area_pickup.get_child(0).set_deferred('disabled', true)

func put_down(where):
	reparent(get_tree().current_scene)
	area_pickup.get_child(0).set_deferred('disabled', false)
	position = where

func extinguish(seconds: float = .2):
	if not frozen:
		Auto.torches_label.text = 'your light has fled'
		Auto.torches_label.visible = true
		var t := create_tween()
		t.tween_property(light, 'omni_range', 0, seconds)
		t.parallel().tween_property(light, 'light_energy', 0, seconds)
		t.parallel().tween_property(light_wick, 'light_energy', 0, seconds)
		$TimerRestart.timeout.connect(reset)
		$TimerRestart.start(5)

func reset():
	Auto.restart()