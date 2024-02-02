extends Area3D

func _ready():
	Auto.torches_updated.connect(try_activate)
	area_entered.connect(try_win)

func try_activate(current_torch_count):
	if current_torch_count == Auto.torches_total:
		get_child(0).set_deferred('disabled', false)

func try_win(candle_area):
	if Auto.torches == Auto.torches_total:
		candle_area.get_parent().get_parent().freeze()
		Auto.torches_label.text = 'it is done'
		Auto.torches_label.visible = true
		$Timer.timeout.connect(Auto.win)
		$Timer.start(5)