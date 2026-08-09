extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func gear_catch_anim():
	var tween = create_tween()
	tween.tween_property($Sprite2D,"position:y",4.0,0.4)
	tween.tween_property($Sprite2D,"scale",Vector2(1.8,1.8),0.5)
	tween.tween_property($Sprite2D,"position:y",-4.0,0.8)
func _on_player_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		$pick.pitch_scale = randf_range(0.8,1.0)
		$pick.play()
		Manager.has_gear = true
		gear_catch_anim()
		await get_tree().create_timer(1.7).timeout
		Manager.proxima_fase()
		queue_free()
