// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function Vector(_x = 0, _y = 0) constructor {
	x = _x
	y = _y
	
	static add = function(vec) {
		x += vec.x
		y += vec.y
		return self
	}
	
	static subtract = function(vec) {
		x -= vec.x
		y -= vec.y
		return self
	}
	
	static clone = function() {
		return new Vector(x, y)
	}
	
	static sqrLength = function() {
		return sqr(x) + sqr(y)
	}
	
	static length = function() {
		return sqrt(sqrLength())
	}
	
	/// 将当前矢量转换为单位矢量 但如果本身是0矢量则不操作
	static unitization = function() {
		if(x == 0 && y == 0) return self
		var len = self.length()
		x /= len
		y /= len
		return self
	}
	
	static multiply = function(m) {
		if(instanceof(m) == "Vector") {
			return new Vector(x * m.x, y * m.y)
		}
		x *= m
		y *= m
		return self
	}
	
	static dot = function(vec) {
		return x * vec.x + y * vec.y
	}
	
	static toAngle = function() {
		var theta = arctan2(-y, x)
		theta = (theta + pi * 2) % (pi * 2)
		return radtodeg(theta)
	}
	
	static toString = function() {
		return "[" + string(x) + ", " + string(y) + "]"
	}
	
	static createSymmetryVectory = function(vec) {
		var a1 = self.toAngle()
		var a2 = vec.toAngle()
		var tar = a2 * 2 - a1
		var r = createVectorFromAngle(tar)
		r.multiply(self.length())
		return r
	}
}

function createVectorFromAngle(angle) {
	angle = angle % 360
	angle = degtorad(angle)
	return new Vector(cos(angle), -1 * sin(angle))
}