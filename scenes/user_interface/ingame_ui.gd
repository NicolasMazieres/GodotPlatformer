extends CanvasLayer

@onready var player_health_bar: ProgressBar = $PlayerHealth/MarginContainer/ProgressBar

func _ready():
	Globals.connect("player_health_change", update_player_health)
	update_player_health()

func update_player_health():
	player_health_bar.value = Globals.player_health
	print(player_health_bar.value)
