extends Node3D

@onready var model: Node3D = $valve
@onready var area: Area3D = $Area3D
@export var target: Node3D
signal used

func use():
	var t = create_tween()
	t.tween_property(model, 'rotation_degrees', Vector3(0, 180, 0), 2.0)
	# t.tween_method(model.rotate_y, 0, deg_to_rad(180), 2.0)
	area.get_child(0).set_deferred('disabled', true)
	used.emit()
	if target and target.has_method('act'):
		target.act()
