extends CharacterBody2D

class_name Player

var maxSpeep = 500.0
var accel = 1000
var friction = 1000
var input = Vector2.ZERO
var can_dodge = true
var can_attack = true
var dodgeFric = false

func getInput():
	input.x = int(Input.is_action_pressed("east")) - int(Input.is_action_pressed("west"))
	input.y = int(Input.is_action_pressed("south")) - int(Input.is_action_pressed("north"))
	
	return input.normalized()

func _physics_process(delta: float) -> void:
	input = getInput()
	
	if input == Vector2.ZERO:
		if velocity.length() > (friction * delta):
			velocity -= velocity.normalized() * (friction * delta)
		else:
			velocity = Vector2.ZERO
	else:
		velocity += (input * accel * delta)
		velocity = velocity.limit_length(maxSpeep)
		rotation = lerp_angle(rotation,velocity.angle(),0.15)
	
	move_and_slide()
	
	if Global.over:
		$TextLose.visible = true
		$RestartButton.visible = true
	
	if Global.finish:
		$TextWin.visible = true
		$RestartButton.visible = true
	
	# Hide the button when not needed
	if not Global.over and not Global.finish:
		$RestartButton.visible = false

# Function to restart the game
func _on_restart_button_pressed():
	Global.over = false
	Global.finish = false
	
	get_tree().reload_current_scene()
