extends Camera3D

var locked := false
@onready var parent: CharacterBody3D = get_parent()

func _input(event):
	if not locked:
		# https://kidscancode.org/godot_recipes/4.x/3d/basic_fps/index.html
		if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			parent.rotate_y(-event.relative.x * Auto.mouse_sensitivity)

			rotate_x(-event.relative.y * Auto.mouse_sensitivity)
			rotation.x = clampf(rotation.x, -deg_to_rad(90), deg_to_rad(90))
