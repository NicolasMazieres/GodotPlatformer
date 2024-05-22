extends Node

signal player_health_change
signal active_spell_change

const PLAYER_MAX_HEALTH: float = 10.0
const SPELLS_LIST = [preload("res://scenes/spells/fireball.tscn"),preload("res://scenes/spells/ice_spell.tscn")]

var is_player_vulnerable: bool = true
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

var active_spell = SPELLS_LIST[0]:
	get:
		return active_spell
	set(value):
		active_spell = value
		active_spell_change.emit()
