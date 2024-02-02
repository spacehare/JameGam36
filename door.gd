extends Node3D

@export var direction: Vector3
@export var seconds: float = 2.0

func act():
	var t = create_tween()
	t.tween_property(self, 'position', position + direction, seconds)