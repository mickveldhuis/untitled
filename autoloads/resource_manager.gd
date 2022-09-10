extends Node


onready var projectiles = {
	"spear": preload("res://entities/player/projectiles/ThrowableSpear.tscn"),
}


onready var enemies = {
	"dummy": preload("res://entities/dummy/dummy.tscn"),
}