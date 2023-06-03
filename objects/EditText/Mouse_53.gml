/// @description Insert description here
// You can write your code in this editor
if(!enable_input) return

logD(global.objectManager.edit_text_view_click_proc)


if(isPointInRotatedRectangle(new Vector(x, y), width, height, image_angle, new Vector(mouse_x, mouse_y), image_xscale, image_yscale) && !global.objectManager.edit_text_view_click_proc){
	global.objectManager.edit_text_view_click_proc = true
	current_get_string_id = get_string_async(hint, text)
	global.objectManager.edit_text_view_click_proc = false
}