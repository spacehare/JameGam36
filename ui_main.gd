extends Control

@onready var btn_resume: Button = %ButtonResume
@onready var btn_quit: Button = %ButtonQuit
@onready var btn_restart: Button = %ButtonRestart
@onready var sens_label: Label = %Sens
@onready var sens_slider: HSlider = %SensSlider

func _ready():
	get_tree().paused = true
	btn_quit.pressed.connect(func(): get_tree().quit())
	btn_resume.pressed.connect(menu_toggle)
	btn_restart.pressed.connect(Auto.restart)
	sens_label.text = "%.4f" % Auto.mouse_sensitivity
	sens_slider.value = Auto.mouse_sensitivity
	sens_slider.value_changed.connect(change_sens)

func change_sens(val: float):
	Auto.mouse_sensitivity = val
	sens_label.text = "%.4f" % Auto.mouse_sensitivity

func menu_toggle():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE else Input.MOUSE_MODE_VISIBLE
	visible = not visible
	get_tree().paused = not get_tree().paused

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		menu_toggle()