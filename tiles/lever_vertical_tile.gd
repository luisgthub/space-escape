extends Area2D
var off_texture:Texture2D
@onready var on_texture = preload("res://assets/tiles/vertical-lever-on.png") 
var in_cooldown = false
var player_close = false

func _ready() -> void:
	off_texture = $Sprite2D.texture
	$Label.visible = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_close and not in_cooldown and Input.is_action_just_pressed("interact"):
		$use.pitch_scale = randf_range(0.8,1.0)
		$use.play()
		activate_lever()		
func activate_lever():
	Manager.eixo_ativo = "vertical"
	in_cooldown = true
	$Sprite2D.texture = on_texture
	print("ativou")		
	Manager.lever_activated = true
	Manager.change_control(Manager.GameMode.PLATAFORM)
	await get_tree().create_timer(7.0).timeout		
	Manager.eixo_ativo = ""
	in_cooldown = false
	$Sprite2D.texture = off_texture
	Manager.lever_activated = false
	Manager.change_control(Manager.GameMode.PLAYER)


func _on_body_lever_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		$Label.visible = true
		player_close = true
		
func _on_body_lever_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		$Label.visible = false
		player_close = false
