-- Animations Config

-- Curves
local curveSpeed = 3

hl.curve("smoothOut", { type = "bezier", points = { { 0.36, 0 }, { 0.66, -0.56 } } })
hl.curve("smoothIn", { type = "bezier", points = { { 0.34, 1.56 }, { 0.64, 1 } } })

hl.curve("snapOut", { type = "bezier", points = { { 0.15, 1.15 }, { 0.3, 1 } } })
hl.curve("snapIn", { type = "bezier", points = { { 0.7, 0 }, { 0.85, -0.15 } } })

hl.curve("wobble", { type = "spring", mass = 1, stiffness = 500, damping = 15 })

-- Animations
-- Windows
hl.animation({ leaf = "windows", enabled = true, speed = curveSpeed, bezier = "snapIn", style = "popin 5%" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = curveSpeed, bezier = "smoothIn", style = "popin 5%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = curveSpeed, bezier = "smoothOut", style = "popin 5%" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = curveSpeed, bezier = "smoothOut" })

-- Layers
hl.animation({ leaf = "layersIn", enabled = true, speed = curveSpeed, spring = "wobble" })
hl.animation({ leaf = "layersOut", enabled = true, speed = curveSpeed, spring = "wobble" })

-- Fades
hl.animation({ leaf = "fade", enabled = true, speed = curveSpeed, bezier = "smoothIn" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = curveSpeed, bezier = "smoothIn" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = curveSpeed, bezier = "smoothOut" })
hl.animation({ leaf = "fadeSwitch", enabled = true, speed = curveSpeed, bezier = "smoothIn" })
hl.animation({ leaf = "fadeShadow", enabled = true, speed = curveSpeed, bezier = "smoothIn" })
hl.animation({ leaf = "fadeDim", enabled = true, speed = curveSpeed, bezier = "smoothIn" })
hl.animation({ leaf = "fadeDpms", enabled = true, speed = curveSpeed, bezier = "smoothIn" })

-- Workspaces
--hl.animation({ leaf = "workspaces", enabled = true, speed = curveSpeed, spring = "wobble" })

function setWorkspaceSlideStyle(target)
	local current = hl.get_active_workspace()
	local currentId = (current and current.id) or tonumber(current and current.name) or 0
	local targetId = tonumber(target) or target

	local style = (targetId > currentId) and "slide top 100%" or "slide bottom 100%"

	hl.animation({
		leaf = "workspaces",
		enabled = true,
		speed = curveSpeed,
		spring = "wobble",
		style = style,
	})
end

hl.animation({
	leaf = "specialWorkspace",
	enabled = true,
	speed = curveSpeed,
	bezier = "smoothOut",
	style = "slidefadevert 40%",
})
