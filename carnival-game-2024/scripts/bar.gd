extends Control

signal died

@onready var animation = $AnimationPlayer
@onready var box = $box
@onready var ui = $"../UI"
@onready var game_anim = $"../Animations"

func _ready():
	hide()

func _on_ui_start():
	animation.play("bar")

var delay = false
func _unhandled_key_input(event):
	if Input.is_key_pressed(KEY_SPACE) && delay == false:
		delay = true
		game_anim.play("charge")
		animation.pause()
		ui.lives -= 1
		
		var pos = animation.current_animation_position
		# if statement monstrosity that checks the position of the box
		if pos < 0.3046 or pos > 1.2: #red
			ui.rock_health -= 0
		elif pos < 0.44 or pos > 1.0662: #orange
			ui.rock_health -= 10
		elif pos < 0.55 or pos > 0.9373: #yellow
			ui.rock_health -= 25
		elif pos < 0.6796 or pos > 0.8084: #lime
			ui.rock_health -= 50
		elif pos < 0.8084 and pos > 0.6796: #green
			ui.rock_health -= 100
		else:
			print('wtf')
		
		if ui.rock_health > 0 && ui.lives > 0:
			await get_tree().create_timer(1.2).timeout
			delay = false
			animation.stop()
			animation.play("bar")
		elif ui.rock_health <= 0:
			ui.rock_health = 0
			ui.next_level()
			await get_tree().create_timer(2).timeout
			delay = false
			animation.stop()
			animation.play("bar")
		else:
			died.emit()
