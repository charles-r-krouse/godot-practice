extends MarginContainer

onready var number_label = $Bars/LifeBar/Count/Background/Number
onready var bar = $Bars/LifeBar/TextureProgress
onready var tween = $Tween

# create a variable for animating health
var animated_health = 0


func _ready():
	var player_max_health = $"../Characters/Player".max_health
	bar.max_value = player_max_health
	# initialize the player's health at the start of the game to max health
	update_health(player_max_health)


func _on_Player_health_changed(player_health):
	update_health(player_health)


func update_health(new_value):
	# update the player health, but don't animate
	# number_label.text = str(new_value)
	# bar.value = new_value
	tween.interpolate_property(self, "animated_health", animated_health, new_value, 0.6)
	# activate the animation
	if not tween.is_active():
		tween.start()


func process(delta):
	var round_value = round(animated_health)
	number_label.text = str(animated_health)
	bar.value = round_value


func _on_Player_died():
	var start_color = Color(1.0, 1.0, 1.0, 1.0)
	var end_color = Color(1.0, 1.0, 1.0, 0.0)
	tween.interpolate_property(self, "modulate", start_color, end_color, 1.0)
