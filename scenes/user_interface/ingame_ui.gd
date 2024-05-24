extends CanvasLayer

@onready var player_health_bar: ProgressBar = $PlayerHealth/MarginContainer/ProgressBar
@onready var collectible_bar: ProgressBar = $Collectible/MarginContainer/ProgressBar
@onready var spell_logo: TextureRect = $ActiveSpell/MarginContainer/SpellLogo

func _ready():
	Globals.connect("player_health_change", update_player_health)
	Globals.connect("active_spell_change", update_active_spell)
	Globals.connect("collectible_value_change", update_collectible_value)
	update_collectible_value()
	update_player_health()
	update_active_spell()

func update_player_health():
	player_health_bar.value = Globals.player_health

func update_active_spell():
	match Globals.active_spell:
		Globals.SPELLS_LIST[0]:
			spell_logo.texture = load("res://graphics/Items/fireball.png")
		Globals.SPELLS_LIST[1]:
			spell_logo.texture = load("res://graphics/Items/gemBlue.png")

func update_collectible_value():
	collectible_bar.value = Globals.collectible_value
