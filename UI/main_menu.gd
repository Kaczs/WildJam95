extends Control

@onready var settings: TabContainer = $CenterContainer/Settings
@onready var main_menu: VBoxContainer = $CenterContainer/MainMenu
@onready var center_container: CenterContainer = $CenterContainer

var current_scene:Control

##Dict that stores witch nodes show be shown when Input UI_Back is pressed.
##The key is the current node and the value is the node to show.
var scene_back:Dictionary = {
	"MainMenu":main_menu,
	"Settings":main_menu,
}


func _ready() -> void:
	current_scene = main_menu


func _input(event: InputEvent) -> void:
	#When ui_back is pressed go to the previouse menu witch is stored in scene_back
	if event.is_action_pressed("ui_back"):
		var current_name:String = current_scene.name
		#if scene back has the current scenes name then we use scene_back to get the perevious scene
		if scene_back.has(current_name):
			change_node(scene_back[current_name])
		#if scene back does not have the current scenes name then we set everything to not visible then change scene to main menu
		else:
			for child in center_container.get_children():
				child.set_visable(false)
			change_node(main_menu)


#TODO make game
func _on_play_pressed() -> void:
	pass # Replace with function body.


func _on_settings_pressed() -> void:
	change_node(settings)


func _on_exit_pressed() -> void:
	get_tree().quit()


##Disables the visability of the current node then makes [param new_node] visible.
func change_node(new_node):
	current_scene.set_visible(false)
	current_scene = new_node
	current_scene.set_visible(true)
