extends Control

signal start

@onready var bar = $"../bar"
@onready var rock_health_label = $HealthLabel
@onready var begin_button = $BeginButton
@onready var restart_button = $RestartButton
@onready var middle_text = $MiddleText
@onready var rock = $"../rock"
@onready var ram = $"../ram"
@onready var heart = $"../Heart"
@onready var ticket = $"../Ticket"
@onready var damage_label = $HealthLabel/DamageLabel
@onready var console = $TextEdit

var rock_health = 0:
	set(e):
		rock_health = e
		rock_health_label.text = str(e)
var lives = 0:
	set(e):
		lives = e
		$"../Heart/LivesLabel".text = str(e)
var level = 0

func _ready():
	rock_health_label.hide()

func _on_begin_button_pressed():
	$"../Node/select".play()
	heart.show()
	new_game()
 
var godmode = false
func _input(event):
	if Input.is_action_just_pressed('console') && console.visible == false:
		await get_tree().create_timer(.01).timeout
		console.show()
		console.grab_focus()
	elif Input.is_action_just_pressed("enter") && console.visible == true:
		if console.text == 'godmode':
			godmode = true
		if console.text == 'manmode':
			godmode = false
		console.text = ''
		console.hide()
	elif Input.is_action_just_pressed('console') && console.visible == true:
		console.hide()
	elif Input.is_key_pressed(KEY_COMMA):
		godmode = true
	elif Input.is_key_pressed(KEY_PERIOD):
		godmode = false

func new_game():
	heart.show()
	ram.show()
	rock.show()
	bar.show()
	rock_health_label.show()
	begin_button.hide()
	start.emit()
	bar.delay = false
	rock_health = 200
	lives = 3
	level = 1

func next_level():
	$"../Node/levelpass".play()
	rock.hide()
	middle_text.show()
	middle_text.text = 'YOU PASSED LEVEL ' + str(level)
	$"../Ticket/TicketsLabel".text = str(level)
	await get_tree().create_timer(2).timeout
	rock.show()
	middle_text.hide()
	level += 1
	match level:
		2:
			rock_health = 300
			lives = 4
			bar.change_speed(1.2)
		3:
			rock_health = 400
			lives = 5
			bar.change_speed(1.6)
		4:
			rock_health = 500
			lives = 7
			bar.change_speed(2.5)
		5:
			rock_health = 600
			lives = 9
			bar.change_speed(3.5)
		6:
			rock_health = 700
			lives = 11
			bar.change_speed(4)
		7:
			rock_health = 800
			lives = 14
			bar.change_speed(4.3)
		8:
			rock_health = 900
			lives = 15
			bar.change_speed(4.7)
		9:
			rock_health = 950
			lives = 16
			bar.change_speed(5.2)
		10:
			rock_health = 1000
			lives = 17
			bar.change_speed(5.8)
		11:
			bar.die()

func damage_display(amount):
	damage_label.show()
	damage_label.text = '-' + str(amount)
	await get_tree().create_timer(.5).timeout
	damage_label.hide()

var prize = 'STARTBURST'
func _on_bar_died():
	if level > 5:
		prize = 'SODA'
	if level > 6:
		prize = 'PRIME'
	if level > 10:
		prize = 'IPHONE'
	middle_text.text = 'YOU LOST'
	await get_tree().create_timer(.1).timeout
	middle_text.text = 'YOU PASSED ' + str(level - 1) + " LEVELS. 
	YOU GET A " + prize
	middle_text.show()
	restart_button.show()

func _on_restart_button_pressed():
	$"../Node/select".play()
	get_tree().reload_current_scene()
