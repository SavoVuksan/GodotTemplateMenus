extends Node
#Loads options like volume and graphic options on game startup

var option_constants = preload("res://Scripts/options_constants.gd")
var config = ConfigFile.new()

# Loads settings from config file. Loads with standard values if settings not 
# existing
func load_settings():
	var err = config.load(OptionsConstants.config_file_name)
	
	if err != OK:
		return
	
	var sfx_bus_index = AudioServer.get_bus_index(OptionsConstants.sfx_bus_name)
	var music_bus_index = AudioServer.get_bus_index(OptionsConstants.music_bus_name)
	var sfx_volume = linear_to_db(config.get_value(OptionsConstants.section_name, OptionsConstants.sfx_volume_key_name, 1))
	var music_volume = linear_to_db(config.get_value(OptionsConstants.section_name, OptionsConstants.music_volume_key_name, 1))
	var fullscreen = config.get_value(OptionsConstants.section_name, OptionsConstants.fullscreen_key_name, false)
	var render_scale = config.get_value(OptionsConstants.section_name, OptionsConstants.render_scale_key, 1)
	var vsync = config.get_value(OptionsConstants.section_name, OptionsConstants.vsync_key, true)
	
	AudioServer.set_bus_volume_db(sfx_bus_index, sfx_volume)
	AudioServer.set_bus_volume_db(music_bus_index, music_volume)
	if fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	
	get_viewport().scaling_3d_scale = render_scale
	
	if vsync:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
	
func _ready():
	load_settings()
	pass
