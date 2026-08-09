extends Area2D


@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var sprite: Sprite2D = $Sprite2D
func _ready() -> void:
	collision_shape.disabled = true
# Função que a alavanca vai chamar diretamente
func ativar_tile() -> void:
	collision_shape.disabled = false # Libera a passagem (some a colisão do buraco)
	sprite.texture = preload("res://assets/tiles/tilegreen.png")
	# Se quiser mudar o sprite para a versão preenchida:
	# sprite.frame = 1 (ou mude a textura)
	print("Este tile foi preenchido!")
