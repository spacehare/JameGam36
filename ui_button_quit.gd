extends Button

func _ready():
	if OS.get_name() == 'Web':
		disabled = true
		visible = false