extends Node

# this allows us to choose the mob scene that we want to instance -> what does this mean?
export (PackedScene) var Mob

# Declare member variables here
var score


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func game_over():
	# signal emitted from Player triggers this function
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	
	# we created a Group called "mobs"
	# remove this group from the screen when the game ends
	get_tree().call_group("mobs", "queue_free")
	
	
func new_game():
	# set up for a new game
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	
	# update score and display a message
	$HUD.show_message("Get Ready")


func _on_MobTimer_timeout():
	# pick a random starting location and set the mob motion
	# choose a random location on the path
	$MobPath/MapSpawnLocation.offset = randi()
	# create a Mob instance and add it to the scene
	var mob = Mob.instance()
	add_child(mob)
	# set the mob's position perpendicular to the path direction
	var direction = $MobPath/MapSpawnLocation.rotation + PI/2
	# set the mob's position to a random location
	mob.position = $MobPath/MapSpawnLocation.position
	# add some randomness to the direction so that it's not simply perpendicular
	direction += rand_range(-PI/4, PI/4) # functions that require angles use radians
	mob.rotation  = direction
	# set the mob's velocity (speed and direction)
	mob.linear_velocity = Vector2(rand_range(mob.min_speed, mob.max_speed), 0)
	mob.linear_velocity = mob.linear_velocity.rotated(direction)


func _on_ScoreTimer_timeout():
	# increment the score every second
	score += 1
	# update the HUD to keep the display in sync with the changing score
	$HUD.update_score(score)


func _on_StartTimer_timeout():
	# starts the other two timers
	# there is a slight delay before starting the other two timers
	$MobTimer.start()
	$ScoreTimer.start()
