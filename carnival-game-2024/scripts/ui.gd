extends Control

signal start

@onready var bar = $"../bar"
@onready var health_label = $HealthLabel
@onready var begin_button = $BeginButton
@onready var middle_text = $MiddleText

var health = 0:
	set(e):
		health = e
		health_label.text = str(e)
var level = 0

func _ready():
	health_label.hide()

func _on_begin_button_pressed():
	bar.show()
	health_label.show()
	begin_button.hide()
	start.emit()
	health = 200
	level += 1

func next_level():
	middle_text.show()
	await get_tree().create_timer(2).timeout
	middle_text.hide()
	level += 1
	match level:
		2:
			health = 300
		3:
			health = 400
