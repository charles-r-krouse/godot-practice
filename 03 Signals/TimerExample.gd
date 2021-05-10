extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	# <source_node>.connect(<signal_name>, <target_node>, <target_function_name>)
	$Timer.connect("timeout", self, "_on_Timer_timeout")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	# get_node("Sprite") is equivalent to $Sprite
	get_node("Sprite").visible = !get_node("Sprite").visible
