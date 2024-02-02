extends Node3D

@onready var area: Area3D = $Area3D

func extinguish(target):
	target.get_parent().get_parent().extinguish()