class_name InteractPopup
extends Control


export (String) var interact_label_text := ""
export (String) var title_label_text := ""

onready var interact_label := $Texture/InteractLabel
onready var title_label := $TitleLabel


func _ready():
	interact_label.text = interact_label_text
	title_label.text = title_label_text
