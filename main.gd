extends Node2D
@onready var background = $TextureRect
var orign_pos:Vector2
@onready var level_container: Node2D = $levelcontainer

func _ready() -> void:
	Manager.level_container = level_container
	Manager.carregar_fase_atual()
	orign_pos = background.scale
	background_move()
	pass


func _process(delta: float) -> void:
	if Manager.current_mode == 0:
		Manager.timer = 0.0
		$Label.text = "Controlando: Player"
		 
	else:
		Manager.timer+=delta
		$Label.text = "Controlando: Alavanca "+str(snappedf(Manager.timer,0.1))
	pass

func background_move():
	var tween = create_tween()
	tween.set_loops()
	tween.tween_property(background,"scale",Vector2(1.5,1.5),10.0)
	tween.tween_property(background,"scale",orign_pos,10.0)


func _on_texture_button_pressed() -> void:
	Manager.reiniciar_fase()
