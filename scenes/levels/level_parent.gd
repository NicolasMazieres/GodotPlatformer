extends Node2D

var spell_scene = preload("res://scenes/spells/spell.tscn")

func _on_player_action_pressed(pos, flip):
	var spell = spell_scene.instantiate() as Area2D
	spell.position = pos
	if flip:
		spell.direction.x = -1
		spell.scale.x = -1
		spell.position.x -= 46

	$Spells.add_child(spell)
