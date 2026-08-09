extends Node

var steps = 0
enum GameMode{PLAYER,PLATAFORM}
var current_mode = GameMode.PLAYER 
var has_gear = false
var modo_rapido: bool = false
var timer_alternancia: float = 0.0
var level = 0
var timer = 0.0
var eixo_ativo:String = ""
var lever_activated: bool = false 
var level_container: Node = null
var fases = [
	"res://levels/level1.tscn",
	"res://levels/level2.tscn",
	"res://levels/level3.tscn",
	"res://levels/level4.tscn",
	"res://levels/level5.tscn",
	"res://levels/level6.tscn",
	"res://levels/level7.tscn",
	"res://levels/level8.tscn",
	"res://levels/level9.tscn",
	"res://levels/level10.tscn",
	"res://menus/game_over.tscn",
]
var fase_atual_index = 0
func proxima_fase() -> void:
	level+=1
	fase_atual_index += 1
	
	if fase_atual_index < fases.size():
		carregar_fase_atual()
	else:
		print("Fim do Jogo!")
		fase_atual_index = 0
		carregar_fase_atual()
func reiniciar_fase():
	carregar_fase_atual()
func carregar_fase_atual() -> void:
	if not level_container:
		print_rich("[color=red]Erro: LevelContainer não foi definido no Manager![/color]")
		return
	
	# 1. Remove a fase anterior que estiver aberta
	for child in level_container.get_children():
		child.queue_free()
		
	# 2. Carrega e instancia a nova fase
	var fase_scene = load(fases[fase_atual_index])
	var fase_instance = fase_scene.instantiate()
	
	# 3. Coloca a nova fase dentro do container na tela principal
	level_container.add_child(fase_instance)
	print("Fase carregada: ", fases[fase_atual_index])
func _ready() -> void:
	pass # Replace with function body.
func change_control(new_mode):
	current_mode = new_mode
	if current_mode == GameMode.PLATAFORM:
		print("Modo: Controlando a PLATAFORMA")
	else:
		print("Modo: Controlando o PLAYER")

func _process(delta: float) -> void:
	timer_alternancia += delta
	
	if timer_alternancia >= 7.0:
		timer_alternancia = 0.0
		modo_rapido = not modo_rapido
		
		if modo_rapido:
			print("MODO RÁPIDO ATIVADO! Cuidado para não bater!")
		else:
			print("MODO LENTO ATIVADO! Hora de planejar.")
