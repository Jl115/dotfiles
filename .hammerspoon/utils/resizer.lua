local M = {}

--- Moves a focused window to a grid position and adjusts its height.
-- @param unit A frame table like {x=0, y=0, w=0.5, h=1} representing a grid position.
-- @param height_percentage A number between 0 and 1 (e.g., 0.9 for 90%).
function M.setWindowFrame(unit, height_percentage)
	local win = hs.window.focusedWindow()
	if not win then
		return
	end

	local screen = win:screen()
	local screen_frame = screen:frame()
	local final_h = screen_frame.h * height_percentage

	local final_y = screen_frame.y + screen_frame.h - final_h

	local new_frame = {
		x = screen_frame.x + (screen_frame.w * unit.x),
		y = final_y,
		w = screen_frame.w * unit.w,
		h = final_h,
	}

	win:setFrame(new_frame)
end

return M
