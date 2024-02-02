extends Area3D

@export var eyes: Sprite3D
@onready var col: CollisionShape3D = get_child(0)

func _ready():
	body_entered.connect(toggle)

func toggle(_area):
	if Auto.torches == Auto.torches_total:
		eyes.visible = not eyes.visible
		col.set_deferred('disabled', true)
