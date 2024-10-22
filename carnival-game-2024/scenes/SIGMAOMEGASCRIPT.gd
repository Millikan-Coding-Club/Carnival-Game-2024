extends Node2D

@onready var heart = $Heart
@onready var rock = $rock
@onready var ram = $ram

func _ready():
	rock.hide()
	ram.hide()
	heart.hide()


func _on_bar_died():
	pass
