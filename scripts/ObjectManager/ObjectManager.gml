// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function initObjectManager(){
	logD("initObjectManager")
	return {
		getOrCreate: function(key, createor){
			if(!struct_exists(self, key)) {
				struct_set(self, key, createor())
			}
			var value = struct_get(self, key)
			logD("getOrCreate key: {0}, value: {2}, objectManager: {1}", key, self, value)
			return value
		}
	}
}

global.objectManager = initObjectManager()
