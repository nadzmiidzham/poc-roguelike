class_name InteractPopup
extends Control


export (String) var title_label_text := ""

onready var title_label := $TitleLabel


func _ready():
	title_label.text = title_label_text
