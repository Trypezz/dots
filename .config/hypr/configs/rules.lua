-- Rules and Rulesets Config

-- Start Terminal
hl.window_rule({
	name = "start-terminal",
	match = {
		class = "startTerm",
	},
	workspace = "1",
})

hl.window_rule({
	match = {
		class = "kitty",
	},
	tag = "+terminal",
})

-- Emergency Terminal
hl.window_rule({
	name = "emergency-terminal",
	match = {
		class = "eTerm",
	},
	float = true,
	center = true,
	size = "(monitor_w*0.45) (monitor_h*0.45)",
})

-- Notes
hl.window_rule({
	name = "notes",
	match = {
		class = "notes",
	},
	float = true,
	center = false,
	size = "(monitor_w*0.45) (monitor_h*0.45)",
})

-- Import Rulesets
-- Get current path, cause if working with modules this file is somewhere different
local script_path = debug.getinfo(1, "S").source:match("@?(.*/)") or "./"
local dir = script_path .. "rulesets"
local p = io.popen('ls -1 "' .. dir .. '" 2>/dev/null')

if not p then
	return
end

for filename in p:lines() do
	if filename:match("%.lua$") then
		local path = dir .. "/" .. filename
		local chunk, err = loadfile(path)
		if not chunk then
			io.stderr:write("load error: " .. err .. "\n")
		else
			local ok, runerr = pcall(chunk)
			if not ok then
				io.stderr:write("runtime error: " .. runerr .. "\n")
			end
		end
	end
end
p:close()
