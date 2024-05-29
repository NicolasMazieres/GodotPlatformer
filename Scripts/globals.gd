extends Node

signal player_health_change
signal player_dead
signal active_spell_change
signal collectible_value_change

const PLAYER_MAX_HEALTH: float = 10.0
const MAX_COLLECTIBLE: float = 100.0
const SPELLS_LIST = [preload("res://scenes/spells/fireball.tscn"),preload("res://scenes/spells/ice_spell.tscn")]
const INITIAL_LOCATION: Vector2 = Vector2(250, 390)

var is_player_vulnerable: bool = true
var last_saved_location: Vector2 = INITIAL_LOCATION

var player_health: float = PLAYER_MAX_HEALTH:
	get:
		return player_health
	set(value):
		if value > player_health:
			player_health = min(value, PLAYER_MAX_HEALTH)
		else:
			if is_player_vulnerable:
				player_health = value
				is_player_vulnerable = false
		player_health_change.emit()
		if player_health == 0:
			player_dead.emit()

var active_spell = SPELLS_LIST[0]:
	get:
		return active_spell
	set(value):
		active_spell = value
		active_spell_change.emit()

var collectible_value: float = 0.0:
	get:
		return collectible_value
	set(value):
		if value > collectible_value:
			collectible_value = min(value, MAX_COLLECTIBLE)
		collectible_value_change.emit()
