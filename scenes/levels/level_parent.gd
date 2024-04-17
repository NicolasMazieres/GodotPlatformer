extends Node2D

var spell_scene = preload("res://scenes/spells/fireball.tscn")
var drop_item_scene = preload("res://scenes/items/drop_item.tscn")

func _on_player_action_pressed(pos, flip):
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
