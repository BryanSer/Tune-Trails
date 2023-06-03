/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();
current_get_string_id = undefined
global.objectManager.getOrCreate("edit_text_view_click_proc", function() { return false })


isPointInRotatedRectangle = function(vec1, length, width, rot, point, sx, sy) {
	rot = degtorad(rot)
    var alignedPoint = vec1.clone().subtract(point);

    var rotatedPoint = new Vector(
        alignedPoint.x * cos(rot) + alignedPoint.y * sin(rot),
        -alignedPoint.x * sin(rot) + alignedPoint.y * cos(rot)
    );

    if (0 <= rotatedPoint.x && rotatedPoint.x <= length * sx && 0 <= rotatedPoint.y && rotatedPoint.y <= width * sy) {
        return true;
    }

    return false;
}
