extends Node2D

var spell_scene = preload("res://scenes/spells/spell.tscn")

func _on_player_action_pressed():
	var instance = spell_scene.instantiate()
	$Spells.add_child(instance)
