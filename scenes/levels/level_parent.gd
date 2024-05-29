extends Node2D

var spell_scene = Globals.active_spell
var drop_item_scene = preload("res://scenes/items/drop_item.tscn")
@onready var player = $Player

func _ready():
	Globals.connect("player_dead", reset_after_death)
	player.position = Globals.last_saved_location
	Globals.player_health = Globals.PLAYER_MAX_HEALTH
	Globals.collectible_value = 0.0

func _on_player_action_pressed(pos, flip):
	spell_scene = Globals.active_spell
	var spell = spell_scene.instantiate() as Area2D
	spell.position = pos
	if flip:
		spell.direction.x = -1
		spell.scale.x = -1
		spell.position.x -= 46

	$Spells.add_child(spell)

func _on_base_enemy_enemy_dead(pos, drop_quantity):
	for i in range(drop_quantity):
		var drop_item = drop_item_scene.instantiate() as CharacterBody2D
		drop_item.position = pos
		$Items.call_deferred('add_child',drop_item)

func reset_after_death():
	get_tree().call_deferred("reload_current_scene")
	
