/// @description Insert description here
// You can write your code in this editor
if(!enable_input) return
if(!struct_exists(global.object_global_var, "edit_text_view_click_proc")){
	global.object_global_var.edit_text_view_click_proc = false
}
var maxX = x + width
var maxY = y +  height
if(mouse_x >= x && mouse_x <= maxX && mouse_y >= y && mouse_y <= maxY && !global.object_global_var.edit_text_view_click_proc){
	global.object_global_var.edit_text_view_click_proc = true
	current_get_string_id = get_string_async(hint, text)
	global.object_global_var.edit_text_view_click_proc = false
}