extends Node3D
class_name Player

@onready var body: CharacterBody3D = $CharacterBody3D
@onready var hand: Node3D = %Hand
@onready var ray: RayCast3D = %HandRay
@onready var use_prompt: Control = $UiUsePrompt
var holding_item: bool = false:
	get:
		return hand.get_child_count() != 0

func _ready():
	use_prompt.visible = false
	Auto.torches_label = $UiTorchesLeft
	Auto.torches_timer = $Timer
	$Timer.timeout.connect(func(): $UiTorchesLeft.visible = false)

func _process(_delta):
	ray.force_raycast_update()
	if ray.is_colliding():
		use_prompt.text = 'put candle down first' if ray.get_collider().collision_layer == 4 and holding_item else 'E'
	use_prompt.visible = ray.is_colliding() and (ray.get_collider().collision_layer == 4 or holding_item and target_is_floorish(ray))

func _input(event):
	if event.is_action_pressed("act_use") and ray.is_colliding():
		if not holding_item:
			var item = ray.get_collider()
			var item_parent = item.get_parent()

			if item.collision_layer == 4:
				if item_parent.has_method('pick_up'):
					item_parent.pick_up(self)
				elif item_parent.has_method('use'):
					item_parent.use()
		else:
			# printt(ray.get_collision_normal())
			if target_is_floorish(ray):
				hand.get_child(0).put_down(ray.get_collision_point())

func target_is_floorish(raycast: RayCast3D):
	return raycast.get_collision_normal() == Vector3.UP