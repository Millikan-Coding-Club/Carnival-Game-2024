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
	new_game()

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
	level += 1

func next_level():
	rock.hide()
	middle_text.show()
	middle_text.text = 'YOU PASSED LEVEL ' + str(level)
	await get_tree().create_timer(2).timeout
	rock.show()
	middle_text.hide()
	level += 1
	match level:
		2:
			rock_health = 300
			lives = 4
		3:
			rock_health = 450
			lives = 5
		4:
			rock_health = 600
			lives = 6


func _on_bar_died():
	middle_text.text = 'YOU LOST!!! THANKS FOR THE TICKETS LOSER!!'
	middle_text.show()
	restart_button.show()

func _on_restart_button_pressed():
	get_tree().reload_current_scene()
