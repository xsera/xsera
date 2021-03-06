import('GlobalVars')
import('PrintRecursive')
import('Console')
import('BoxDrawing')

SPLASH_SHIFT_LEFT = -140
SPLASH_SHIFT_RIGHT = 138
TOP_OF_SPLASH = -28
SPLASH_STRIDE = 26

local execs = {	{ xCoord = SPLASH_SHIFT_LEFT, yCoord = TOP_OF_SPLASH, length = SPLASH_SHIFT_RIGHT - SPLASH_SHIFT_LEFT, text = "Start New Game", justify = "left", boxColour = ClutColour(8, 6), textColour = ClutColour(13, 9), execute = nil, letter = "S" },
	{ xCoord = SPLASH_SHIFT_LEFT, yCoord = TOP_OF_SPLASH - 1 * SPLASH_STRIDE, length = SPLASH_SHIFT_RIGHT - SPLASH_SHIFT_LEFT, text = "Start Network Game", justify = "left", boxColour = ClutColour(5, 5), textColour = ClutColour(13, 9), execute = nil, letter = "N" },
	{ xCoord = SPLASH_SHIFT_LEFT, yCoord = TOP_OF_SPLASH - 2 * SPLASH_STRIDE, length = SPLASH_SHIFT_RIGHT - SPLASH_SHIFT_LEFT, text = "Replay Intro", justify = "left", boxColour = ClutColour(1, 8), textColour = ClutColour(13, 9), execute = nil, letter = "R" },
	{ xCoord = SPLASH_SHIFT_LEFT, yCoord = TOP_OF_SPLASH - 3 * SPLASH_STRIDE, length = SPLASH_SHIFT_RIGHT - SPLASH_SHIFT_LEFT, text = "Demo", justify = "left", boxColour = ClutColour(1, 6), textColour = ClutColour(13, 9), execute = nil, letter = "D" },
	{ xCoord = SPLASH_SHIFT_LEFT, yCoord = TOP_OF_SPLASH - 4 * SPLASH_STRIDE, length = SPLASH_SHIFT_RIGHT - SPLASH_SHIFT_LEFT, text = "Options", justify = "left", boxColour = ClutColour(12, 6), textColour = ClutColour(13, 9), execute = nil, letter = "O" },
	{ xCoord = SPLASH_SHIFT_LEFT, yCoord = TOP_OF_SPLASH - 5 * SPLASH_STRIDE, length = SPLASH_SHIFT_RIGHT - SPLASH_SHIFT_LEFT, text = "About Ares and Xsera", justify = "left", boxColour = ClutColour(1, 6), textColour = ClutColour(13, 9), execute = nil, letter = "A" },
	{ xCoord = SPLASH_SHIFT_LEFT, yCoord = TOP_OF_SPLASH - 6 * SPLASH_STRIDE, length = SPLASH_SHIFT_RIGHT - SPLASH_SHIFT_LEFT, text = "Xsera Main Menu", justify = "left", boxColour = ClutColour(9, 6), textColour = ClutColour(13, 9), execute = nil, letter = "M" },
	{ xCoord = SPLASH_SHIFT_LEFT, yCoord = TOP_OF_SPLASH - 7 * SPLASH_STRIDE, length = SPLASH_SHIFT_RIGHT - SPLASH_SHIFT_LEFT, text = "Quit", justify = "left", boxColour = ClutColour(8, 4), textColour = ClutColour(13, 9), execute = nil, letter = "Q" } }

function init()
	sound.stop_music()
	local num = 1
	graphics.set_camera(-320, -240, 320, 240)
--	graphics.set_camera(-480, -360, 480, 360)
end

function update()
end

function render()
	graphics.begin_frame()
    graphics.draw_image("Panels/MainTop", { x = 0, y = 118 }, { x = 640, y = 245 })
    graphics.draw_image("Panels/MainBottom", { x = 0, y = -227 }, { x = 640, y = 24 })
    graphics.draw_image("Panels/MainLeft", { x = -231, y = -110 }, { x = 178, y = 211 })
    graphics.draw_image("Panels/MainRight", { x = 230, y = -110 }, { x = 180, y = 211 })
	local num = 1
	while execs[num] ~= nil do
		SwitchBox(execs[num])
		num = num + 1
	end
	-- Error Printing
	if errNotice ~= nil then
		graphics.draw_text(errNotice.text, MAIN_FONT, "left", { x = -315, y = 225 }, 28)
		if errNotice.start + errNotice.duration < mode_manager.time() then
			errNotice = nil
		end
	end
	graphics.end_frame()
end

function keyup(k)
	if k == "s" then
		mode_manager.switch('Ares/Briefing')
	elseif k == "n" then
		sound.play('NaughtyBeep')
		LogError("This command currently has no code.", 10)
		local num = 1
		while execs[num] ~= nil do
			if execs[num].special == "click" then
				execs[num].special = nil
			end
			num = num + 1
		end
	elseif k == "r" then
		sound.play("NaughtyBeep")
		LogError("This command currently has no code.", 10)
		local num = 1
		while execs[num] ~= nil do
			if execs[num].special == "click" then
				execs[num].special = nil
			end
			num = num + 1
		end
	elseif k == "d" then
		sound.play("NaughtyBeep")
		LogError("This command currently has no code.", 10)
		local num = 1
		while execs[num] ~= nil do
			if execs[num].special == "click" then
				execs[num].special = nil
			end
			num = num + 1
		end
	elseif k == "m" then
		mode_manager.switch('Xsera/MainMenu')
	elseif k == "o" then
		mode_manager.switch('Ares/Options')
	elseif k == "a" then
		mode_manager.switch('Xsera/Credits')
	elseif k == "q" then
		os.exit()
	end
end

function key(k)
	if k == "s" then
		ChangeSpecial("S", "click", execs)
	elseif k == "n" then
		ChangeSpecial("N", "click", execs)
	elseif k == "r" then
		ChangeSpecial("R", "click", execs)
	elseif k == "d" then
		ChangeSpecial("D", "click", execs)
	elseif k == "m" then
		ChangeSpecial("M", "click", execs)
	elseif k == "o" then
		ChangeSpecial("O", "click", execs)
	elseif k == "a" then
		ChangeSpecial("A", "click", execs)
	elseif k == "q" then
		ChangeSpecial("Q", "click", execs)
	end
end