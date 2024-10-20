extends Control

@onready var animation = $AnimationPlayer
@onready var box = $box
@onready var ui = $"../UI"

func _ready():
	hide()

func _on_ui_start():
	animation.play("bar")

var delay = false
func _unhandled_key_input(event):
	if Input.is_key_pressed(KEY_SPACE) && delay == false:
		delay = true
		animation.pause()
		var pos = animation.current_animation_position
		# if statement monstrosity that checks the position of the box
		if pos < 0.3046 or pos > 1.2: #red
			ui.health -= 0
		elif pos < 0.44 or pos > 1.0662: #orange
			ui.health -= 10
		elif pos < 0.55 or pos > 0.9373: #yellow
			ui.health -= 25
		elif pos < 0.6796 or pos > 0.8084: #lime
			ui.health -= 50
		elif pos < 0.8084 and pos > 0.6796: #green
			ui.health -= 100
		else:
			print('wtf')
		
		if ui.health > 0:
			await get_tree().create_timer(1.2).timeout
			delay = false
			animation.stop()
			animation.play("bar")
		else:
			ui.health = 0
			ui.next_level()
			await get_tree().create_timer(2).timeout
			delay = false
			animation.stop()
			animation.play("bar")
