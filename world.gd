extends Node2D

@export var player: Player
@onready var camera: Camera2D = $Camera2D

var background_texture: Texture
var background_size = Vector2(1080, 720)
var offset = Vector2.ZERO

func _ready() -> void:
	offset = Vector2.ZERO
	for i in range(200):
		spawnRock()

func _process(delta: float) -> void:
	if player:
		camera.position = player.position
		update_background(delta)
	else:
		print("Error: Player is not assigned!")
	

func update_background(delta: float) -> void:
	offset -= player.get_real_velocity() * delta
	offset.x = wrap_value(offset.x, -background_size.x, 0)
	offset.y = wrap_value(offset.y, -background_size.y, 0)

func wrap_value(value: float, min_value: float, max_value: float) -> float:
	return fmod(value - min_value, max_value - min_value) + min_value

func spawnRock():
	var rock = preload("res://rock.tscn").instantiate()
	var randX = randi_range(-2000, 2000)
	var randY = randi_range(-2000, 2000)
	rock.global_position = Vector2(randX, randY)
	add_child(rock)
	
