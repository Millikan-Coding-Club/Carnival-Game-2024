extends Control

signal died

@onready var animation = $AnimationPlayer
@onready var box = $box
@onready var ui = $"../UI"
@onready var game_anim = $"../Animations"

func _process(delta):
	if ui.godmode == true && delay == false:
		var pos = animation.current_animation_position
		if pos > 0.74 && pos < 0.79:
			charge()

func _ready():
	hide()

func _on_ui_start():
	delay = false
	animation.play("bar")

var delay = true
func _unhandled_key_input(event):
	if Input.is_key_pressed(KEY_SPACE) && delay == false && ui.godmode == false:
		charge()

func charge():
	$"../Node/hit".play()
	delay = true
	game_anim.play("charge")
	animation.pause()
	ui.lives -= 1
	
	var damage = 0
	var pos = animation.current_animation_position
	# if statement monstrosity that checks the position of the box
	if pos < 0.3046 or pos > 1.2: #red
		damage = 0
	elif pos < 0.44 or pos > 1.0662: #orange
		damage = 10
	elif pos < 0.55 or pos > 0.9373: #yellow
		damage = 25
	elif pos < 0.6796 or pos > 0.8084: #lime
		damage = 50
	elif pos < 0.8084 and pos > 0.6796: #green
		damage = 100
	else:
		print('wtf')
	
	ui.rock_health -= damage
	ui.damage_display(damage)
	
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
		$"../Node/death".play()
		died.emit()

func change_speed(amount):
	animation.speed_scale = amount
