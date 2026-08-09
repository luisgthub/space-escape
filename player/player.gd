extends CharacterBody2D

var com_turbo: bool = false
var SPEED = 80.0
var tile_size = 16
var target_position:Vector2
var is_moving = false
var offset = Vector2(3,0)
var origin_scale = Vector2(0.8,0.8)
@onready var raycast = $RayCast2D
func _ready() -> void:
	position = position.snapped(Vector2(tile_size,tile_size))

func _physics_process(delta: float) -> void:
	if Manager.current_mode == Manager.GameMode.PLAYER:
		if is_moving:
			#PARTICLE
			$walk.pitch_scale = randf_range(0.8,1.0)
			$walk.play()
			$CPUParticles2D.emitting = true
			#SCALE TWEEN
			player_anim()
			position = position.move_toward(target_position,SPEED*delta)
			if position==target_position:
				is_moving = false
			return
		else:
			$CPUParticles2D.emitting = false
		var input_dir:=Vector2.ZERO
		#configurar raycast

		if Input.is_action_pressed("restart"):
			Manager.reiniciar_fase()
		
		if Input.is_action_pressed("left"):
			input_dir = Vector2.LEFT
			$Sprite2D.flip_h = true
			
		if Input.is_action_pressed("right"):
			input_dir = Vector2.RIGHT
			$Sprite2D.flip_h = false
		if Input.is_action_pressed("up"):
			input_dir = Vector2.UP
		if Input.is_action_pressed("down"):
			input_dir = Vector2.DOWN
		if input_dir!=Vector2.ZERO:
			raycast.target_position = input_dir*tile_size
			raycast.force_raycast_update()
			if raycast.is_colliding():
				#print("player pos ", position)
				target_position = position +(input_dir*tile_size)
				is_moving = true
				Manager.steps+=1
func player_anim():
	var tween = create_tween()
	tween.tween_property($Sprite2D,"scale",Vector2(0.6,0.6),0.2)
	tween.tween_property($Sprite2D,"scale",origin_scale,0.2)
	await tween.finished

func kill_player():
	$Sprite2D.rotate(deg_to_rad(20))
	await get_tree().create_timer(1.0).timeout
