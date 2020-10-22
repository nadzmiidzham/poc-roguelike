class_name PlayerModel
extends Node


export (int) var max_hp := 100
export (int) var hp := 100
export (int) var atk := 1


func to_string():
	return """
		{
			max_hp: " + str(max_hp) + ",
			hp: " + str(hp) + ",
			atk: " + str(atk) + "
		}
		"""
