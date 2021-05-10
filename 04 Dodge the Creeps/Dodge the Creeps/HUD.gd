extends CanvasLayer

# the start_game signal tells the Main node that the Start button was pressed
signal start_game

# temporarily display a message such as "Get Ready"
func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

# this function is called when the player loses
func show_game_over():
	show_message("Game Over")
	# wait 2 seconds until the MessageTimer counts down
	yield($MessageTimer, "timeout")
	
	# return to the title screen, pause briefly, and then show the "Start" button
	$Message.text = "Dodge the\nCreeps!"
	$Message.show()
	yield(get_tree().create_timer(1), "timeout")
	$StartButton.show()

# called by Main when the score changes
func update_score(score):
	$ScoreLabel.text = str(score)


func _on_MessageTimer_timeout():
	$Message.hide()


func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal("start_game")
