@tool
extends EditorScenePostImport


func _post_import(scene: Node) -> Object:
	var mesh: MeshInstance3D = scene.get_child(0).get_child(0)
	mesh.name = mesh.name.capitalize()

	# var redundant_parent = scene.get_child(0)
	# scene.name = mesh.name.capitalize()
	# mesh.reparent(scene)
	# print(mesh.get_child_count())
	# redundant_parent.queue_free()
	# print('%s %s' % [scene.name, mesh.name])
	return scene

