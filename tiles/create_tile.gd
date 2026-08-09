extends Area2D
var off_texture:Texture2D
@onready var on_texture = preload("res://assets/tiles/vertical-lever-on.png") 
var in_cooldown = false
var player_close = false
var player_ref:Node2D = null
@export var tile_alvo:Area2D
func _ready() -> void:
	off_texture = $Sprite2D.texture
	$Label.visible = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_close and not in_cooldown and Input.is_action_just_pressed("interact"):
		activate_lever()		
func activate_lever():
	in_cooldown = true
	$Sprite2D.texture = on_texture
	
	# Manda o tile específico ativar
	tile_alvo.ativar_tile()
	# Manda o tile voltar a ser buraco
	
	$Sprite2D.texture = off_texture
	in_cooldown = false
func _on_body_lever_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		$Label.visible = true
		player_close = true
		player_ref = body
		
func _on_body_lever_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		$Label.visible = false
		player_close = false
		player_ref = null
