import('EntityLoad')
import('GlobalVars')
import('Panels')

function init()
	sound.stop_music()
	loading_entities = true
	NewEntity(nil, "demo", "Scenario")
	loading_entities = false
	print_table(entities)
end

function update()
	
end

function render()
	graphics.begin_frame()
	graphics.set_camera(-400, -300, 400, 300)
	graphics.draw_box(-275, -375, -265, 375, 2, 0, 0, 0.4, 1)
--	graphics.draw_box(-275, -375, -265, 375 - loading_percent * 7.5, 0, 0.3, 0.3, 0.7, 1)
	graphics.end_frame()
end

function key( k )
	if k == "escape" then
		if mode_manager.query() ~= "MainMenu" then
			mode_manager.switch("MainMenu")
		end
	elseif k == " " then
		mode_manager.switch("Demo2")
	end
end

function clear_cache()
	entities = {}
	console_add("The entity cache has been cleared.")
end