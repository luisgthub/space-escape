extends CharacterBody2D

@export var tile_size:int = 16
var target_position:Vector2
var is_moving = false
var box_speed = 100.0
@onready var raycast = $RayCast2D
var player_inside = false
func _ready() -> void:
	position = position.snapped(Vector2(tile_size,tile_size))
	$target.visible = false
	#target_position = position - offset

func _physics_process(delta: float) -> void:
	if Manager.lever_activated:
		$target.visible = true
	else:
		$target.visible = false
	if Manager.current_mode == Manager.GameMode.PLATAFORM:
		if is_moving and not player_inside:
			#PARTICLE
			#SCALE TWEEN
			position = position.move_toward(target_position,box_speed*delta)
			if position==target_position:
				is_moving = false
			return

		var input_dir:=Vector2.ZERO
		if Manager.eixo_ativo == "horizon":
			if Input.is_action_pressed("left"):
				input_dir = Vector2.LEFT
				$Sprite2D.flip_h = true
				
			if Input.is_action_pressed("right"):
				input_dir = Vector2.RIGHT
				$Sprite2D.flip_h = false

		if input_dir != Vector2.ZERO:
			raycast.target_position = input_dir * tile_size
			raycast.force_raycast_update()
			
			if raycast.is_colliding():
				# O raycast bateu em algo (parede, obstáculo, etc)
				# Aqui você pode checar se é a caixa/plataforma para empurrar, 
				# ou simplesmente não fazer nada se for uma parede fixa.
					#target_position = position + (input_dir * tile_size)
									# O raycast NÃO bateu em nada! O caminho está totalmente livre.
				var collider = raycast.get_collider()
				if collider.is_in_group("player"):
					is_moving = false
					
			else:
					target_position = position + (input_dir * tile_size)
					is_moving = true
	
func _on_area_box_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		is_moving = false
		player_inside = true


func _on_player_box_exited(body: Node2D) -> void:
	player_inside = false
