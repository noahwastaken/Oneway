local tabs = menu.Combo("Tabs", "Categories", {"Rage", "Visuals", "Helpers"}, 0, "Tooltip")
local DTModes = menu.Combo("Doubletap Exploits", "Modes", {"Default", "Fast", "Instant", "Max Speed"}, 0)
local DTCorrection = menu.Switch("Doubletap Exploits", "Disable DT Correction", false)
local DTRecharge = menu.Switch("Doubletap Exploits", "Instant Recharge", false)
local antiaimpresets = menu.Combo("Anti-Aim", "Presets", {"Disabled", "Matchmaking", "Deathmatch", "HvH", "Wingman"}, 0, "Anti-Aim presets")
local lowdelta = menu.Switch('Anti-Aim', "Low delta", false)
local legitaa = menu.Switch('Anti-Aim', "Legit AA", false)
local trashtalk = menu.Switch("General", "TrashTalk", false)
local JumpScout = menu.Switch('General', "Jumpscout", false)
local JumpScoutHC = menu.SliderInt('General', "Hitchance", 1,1,100)
local JumpScoutMD = menu.SliderInt('General', "Minimum damage", 1,1,130)
local LegsBreaker = menu.Switch('General', "Legs Breaker", false)
local hitsound = menu.Switch('General', "Hit Sound", false)
local Trail = menu.Switch('General', "Trails", false)
local TrailSize = menu.SliderInt('General', "Trails size", 1, 1, 10)
local TrailLength = menu.SliderInt('General', "Trails length", 1, 1, 100)
local TrailColor = menu.SwitchColor('General', "Trails colors", false, Color.new(1.0, 1.0, 1.0, 1.0), "Toggle RGB")
local manualIndicators = menu.Switch('General', "Manual indicators", false)
local manualcolors = menu.ColorEdit("General", "Manuals color", Color.new(1.0, 1.0, 1.0, 1.0))
local lbreaker = g_Config:FindVar("Aimbot", "Anti Aim", "Misc", "Leg Movement")
local CustomScope =  menu.SwitchColor('General', "Custom scope", false, Color.new(1.0, 1.0, 1.0, 1.0), "Scope color")
local ScopeOrigin = menu.SliderInt('General', 'Scope origin', 0, 0, 100)
local ScopeWidth = menu.SliderInt('General', 'Scope width', 0, 0, 100)
local displayNades = menu.Switch('General', "Grenade Helper", false)
local GHOnlyVisible = menu.Switch('Grenade Helper', "Only visible", false)
local GHSilentThrow = menu.Switch('Grenade Helper', "Silent throw", false, "Rage only")
local GHKeybind = menu.Switch('Grenade Helper', "Throw", false, "Grenade helper throw key")
local displayoneways = menu.Switch('General', "Oneway helper", false)
local OWOnlyVisible = menu.Switch('Oneway Helper', "Only visible", false)
local sorted = false
local autostrafed = 0
local logs = {}
local timeout = 0
local mathhypot = function(a,b)
    return math.sqrt(a*a+b*b)
end

local double_tap = g_Config:FindVar("Aimbot", "Ragebot", "Exploits", "Double Tap")
local screen_size = g_EngineClient:GetScreenSize() 
local cheat_username = cheat.GetCheatUserName()
local font = g_Render:InitFont("Verdana", 12)
local floor = math.floor
local last_time = 0.5
local font_size = 12
local fps_info = {}
local fake_dt_w = 0
local hz_io_w = 0
local delta = 0
local lag

--#region rgb line
local rgb_line = menu.Switch("General", "RGB Line", false, "Enable/Disable")
local line_size = menu.SliderInt("General", "RGB Line Size", 2, 1, 5, "Size")
local function rgb_line_draw()
	local screen = g_EngineClient:GetScreenSize()
	local vector1 = Vector2.new(0 , 0)
	local vector2 = Vector2.new(screen.x / 4 , line_size:GetInt())
	local vector3 = Vector2.new( screen.x / 4 , 0)
	local vector4 = Vector2.new(screen.x / 2 , line_size:GetInt())
	local vector5 = Vector2.new(screen.x / 2 , 0)
	local vector6 = Vector2.new(screen.x / 4 * 3 , line_size:GetInt())
	local vector7 = Vector2.new( screen.x / 4 * 3 , 0)
	local vector8 = Vector2.new(screen.x , line_size:GetInt())
	gametime = g_GlobalVars.realtime

	r = (math.floor(math.sin(g_GlobalVars.realtime * 1 + 10) * 127 + 128)) / 1000 * 3.92
	g = (math.floor(math.sin(g_GlobalVars.realtime * 1 + 20) * 127 + 128)) / 1000 * 3.92
	b = (math.floor(math.sin(g_GlobalVars.realtime * 1 + 30) * 127 + 128)) / 1000 * 3.92

	r1 = (math.floor(math.sin(g_GlobalVars.realtime * 1 + 40) * 127 + 128)) / 1000 * 3.92
	g1 = (math.floor(math.sin(g_GlobalVars.realtime * 1 + 50) * 127 + 128)) / 1000 * 3.92
	b1 = (math.floor(math.sin(g_GlobalVars.realtime * 1 + 60) * 127 + 128)) / 1000 * 3.92

	r2 = (math.floor(math.sin(g_GlobalVars.realtime * 1 + 70) * 127 + 128)) / 1000 * 3.92
	g2 = (math.floor(math.sin(g_GlobalVars.realtime * 1 + 80) * 127 + 128)) / 1000 * 3.92
	b2 = (math.floor(math.sin(g_GlobalVars.realtime * 1 + 90) * 127 + 128)) / 1000 * 3.92

	r3= (math.floor(math.sin(g_GlobalVars.realtime * 1 + 100) * 127 + 128)) / 1000 * 3.92
	g3= (math.floor(math.sin(g_GlobalVars.realtime * 1 + 110) * 127 + 128)) / 1000 * 3.92
	b3= (math.floor(math.sin(g_GlobalVars.realtime * 1 + 120) * 127 + 128)) / 1000 * 3.92
		
	r4 = (math.floor(math.sin(g_GlobalVars.realtime * 1 + 130) * 127 + 128)) / 1000 * 3.92
	g4 = (math.floor(math.sin(g_GlobalVars.realtime * 1 + 140) * 127 + 128)) / 1000 * 3.92
	b4 = (math.floor(math.sin(g_GlobalVars.realtime * 1 + 150) * 127 + 128)) / 1000 * 3.92

		

	local clr1 = Color.new(r,g,b ,100)
	local clr2 = Color.new(r1,g1, b1 ,100)
	local clr3 = Color.new(r2,g2,b2 ,100)
	local clr4 = Color.new(r3,g3,b3,100)
	local clr5 = Color.new(r4,g4,b4 ,100)


	if rgb_line:GetBool() then
		g_Render:GradientBoxFilled(vector1, vector2, clr1, clr2, clr1, clr2)
		g_Render:GradientBoxFilled(vector3, vector4, clr2, clr3, clr2, clr3)
		g_Render:GradientBoxFilled(vector5, vector6, clr3, clr4, clr3, clr4)
		g_Render:GradientBoxFilled(vector7, vector8, clr4, clr5, clr4, clr5)
	end
end
--#endregion


local function text_color(alpha)
    return Color.new(0.9, 0.9, 0.9, 0.95 * alpha)
end

local function color(r, g, b, a) return Color.new(r / 255, g / 255, b / 255, a / 255) end
local function in_box(mouse, x, y, x2, y2) return (mouse.x > x) and (mouse.y > y) and (mouse.x < x2) and (mouse.y < y2) end
local function clamp(val, min, max) if val > max then return max end if min > val then return min end return val end

local function move(x, y, w, h, slider_x, slider_y)
    local mouse = cheat.GetMousePos()
    if (cheat.IsKeyDown(0x1) and cheat.IsMenuVisible() and in_box(mouse, x, y, x + w, y + h)) then
        slider_x:SetInt(mouse.x - w / 2)
        slider_y:SetInt(mouse.y - 10)
    end
end

local function get_spectators()
    local spectators = {}
	local players = g_EntityList:GetPlayers()
	local local_player = g_EntityList:GetLocalPlayer()

	for i, spects in pairs(players) do
		if not spects:IsDormant() and spects:GetProp("m_iHealth") < 1 then
			local target = g_EntityList:GetPlayerFromHandle(spects:GetProp("m_hObserverTarget"))

			if target == local_player then
				table.insert(spectators, spects:GetName())
			end
		end
	end
    return spectators
end

local ui_windows = menu.MultiCombo("Visuals", "General", {"Watermark", "Spectators", "Keybinds", "Fake", "IO", "DT", "MS / HZ"}, 0)
local ui_themes = menu.Combo("Visuals", "Theme", {"Gradient line", "Static line", "Fade line"}, 0)
local ui_custom_cheat_name = menu.TextBox("Visuals", "Watermark cheat", 20, "")
local ui_custom_username = menu.TextBox("Visuals", "Watermark username", 20, "")
local ui_line_color = menu.ColorEdit("Visuals", "Line color", color(100, 100, 255, 255))
local ui_text_outline = menu.Switch("Visuals", "Text outline", true)
local ui_box_alpha = menu.SliderInt("Visuals", "Box alpha", 150, 0, 255)
local ui_keybinds_x = menu.SliderInt("Visuals", "keybinds x", 5, 0, screen_size.x)
local ui_keybinds_y = menu.SliderInt("Visuals", "keybinds y", math.floor(screen_size.y / 2), 0, screen_size.y)
local ui_spectators_x = menu.SliderInt("Visuals", "spectators x", 5, 0, screen_size.x)
local ui_spectators_y = menu.SliderInt("Visuals", "spectators y", math.floor(screen_size.y / 3), 0, screen_size.y)
local oldStatus = g_Config:FindVar("Visuals","World", "Hit", "Hit Sound"):GetBool()
hitsound:RegisterCallback(function() 
    if hitsound:GetBool() then
        oldStatus = g_Config:FindVar("Visuals","World", "Hit", "Hit Sound"):GetBool()
        g_Config:FindVar("Visuals","World", "Hit", "Hit Sound"):SetBool(false)
    else 
        g_Config:FindVar("Visuals","World", "Hit", "Hit Sound"):SetBool(oldStatus)
    end
end)
local get_theme = {
    [0] = function(x, y, w, col)
        g_Render:GradientBoxFilled(Vector2.new(x + w, y), Vector2.new(x + w / 2, y - 2), color(255, 234, 0, col:a()), color(255, 0, 238, col:a()), color(255, 234, 0, col:a()), color(255, 0, 238, col:a()))
        g_Render:GradientBoxFilled(Vector2.new(x, y), Vector2.new(x + w / 2, y - 2), color(0, 200, 255, col:a()), color(255, 0, 238, col:a()), color(0, 200, 255, col:a()), color(255, 0, 238, col:a()))
    end,

    [1] = function(x, y, w, col) 
        g_Render:BoxFilled(Vector2.new(x, y), Vector2.new(x + w, y - 2), col)
    end, 

    [2] = function(x, y, w, col, col2)
        g_Render:GradientBoxFilled(Vector2.new(x + w, y), Vector2.new(x + w / 2, y - 2), color(col:r(), col:g(), col:b(), col2), col, color(col:r(), col:g(), col:b(), col2), col)
        g_Render:GradientBoxFilled(Vector2.new(x, y), Vector2.new(x + w / 2, y - 2), color(col:r(), col:g(), col:b(), col2), col, color(col:r(), col:g(), col:b(), col2), col)
    end
}

local function get_box_alpha() return ui_box_alpha:GetInt() end
local function get_delta() return math.min(math.abs(antiaim.GetCurrentRealRotation() - antiaim.GetFakeRotation()) / 2, 60) end

local function get_local_ping()
    local ping 

    if g_EngineClient:IsConnected() == true then ping = math.floor(g_EngineClient:GetNetChannelInfo():GetLatency(0) * 1000) else ping = 0 end

    return ping
end

local function get_server_tick()
    local tick

    if g_EngineClient:IsConnected() == true then tick = math.floor(1.0 / g_GlobalVars.interval_per_tick) else tick = 0 end

    return tostring(tick)
end

local function get_custom_text_from_ui(text, ui_text)
    local results_text

    if ui_text:GetString() == "" then results_text = text else results_text = ui_text:GetString() end

    return tostring(results_text)
end

local function get_slowly_info()
    if g_GlobalVars.curtime - last_time > 0.5 then
        last_time = g_GlobalVars.curtime
        table.insert(fps_info, 1 / g_GlobalVars.frametime) 
        lag = g_ClientState.m_choked_commands 
        delta = get_delta()
    end
end

local function adaptive_color(val)
    if val < 40 then return { 255, 255, 255 } end
    if val < 100 then return { 255, 125, 95 } end

    return { 255, 60, 80 }
end

local function render_adaptive_box(type, x, y, name, alpha)
    local name_size = g_Render:CalcTextSize(name, font_size, font)
    local line = ui_line_color:GetColor()

    if type == "watermark" then 
        get_theme[ui_themes:GetInt()](x - name_size.x - 16, y, name_size.x + 6, Color.new(line:r(), line:g(), line:b(), 255 * alpha), 10 * alpha)
        g_Render:BoxFilled(Vector2.new(x - 10, y), Vector2.new(x - name_size.x - 16, y + 17), color(20, 20, 20, get_box_alpha() * alpha))
        g_Render:Text(name, Vector2.new(x - name_size.x - 12.5, y + 2), text_color(alpha), font_size, font, ui_text_outline:GetBool())
    end

    if type == "keybinds" then 
        get_theme[ui_themes:GetInt()](x, y, 150, Color.new(line:r(), line:g(), line:b(), 255 * alpha), 10 * alpha)
        g_Render:BoxFilled(Vector2.new(x, y), Vector2.new(x + 150, y + 17), color(20, 20, 20, get_box_alpha() * alpha))
        g_Render:Text(name, Vector2.new(x + 150 / 2 - name_size.x / 2, y + 2), text_color(alpha), font_size, font, ui_text_outline:GetBool())
    end
end

local function gradient_rect(x, y, w, h)
    g_Render:GradientBoxFilled(Vector2.new(x, y), Vector2.new(x + w, y - h), color(134, 175, 255, 255), color(134, 175, 255, 255), color(134, 175, 255, 0), color(134, 175, 255, 0))
end

local function gradient_background(x, y, w, h, color_1, color_2)
    g_Render:GradientBoxFilled(Vector2.new(x, y), Vector2.new(x + w / 2, y - h), color_2, color_1, color_2, color_1)
    g_Render:GradientBoxFilled(Vector2.new(x + w / 2, y), Vector2.new(x + w, y - h), color_1, color_2, color_1, color_2)
end

local function gradient_for_fake(x, y, w, h, color_1, color_2)
    g_Render:GradientBoxFilled(Vector2.new(x, y), Vector2.new(x - w, y - h / 2), color_2, color_2, color_1, color_1)
    g_Render:GradientBoxFilled(Vector2.new(x, y - h / 2), Vector2.new(x - w, y - h), color_1, color_1, color_2, color_2)
end

local function draw_fucking_box(x, y, w, text, style, line, line_color)
    local text_size = g_Render:CalcTextSize(text, 12, font) + 10 + w

    if style == 1 then
        gradient_background(x - text_size.x, y + 19, text_size.x, 19, color(17, 17, 17, 80), color(17, 17, 17, 10))
    end

    if style == 0 then
        g_Render:BoxFilled(Vector2.new(x - text_size.x, y), Vector2.new(x, y + 19), color(17, 17, 17, 100))
    end

    g_Render:Text(text, Vector2.new(x - text_size.x + 5, y + 3), text_color(1), 12, font, ui_text_outline:GetBool())

    if line and line_color == nil then return end

    if line == 0 then 
        gradient_background(x - text_size.x, y + 20, text_size.x, 1, color(line_color[1], line_color[2], line_color[3], 255), color(line_color[1], line_color[2], line_color[3], 0))
    end

    if line == 1 then 
        gradient_for_fake(x - text_size.x, y + 19, 2, 19, color(line_color[1], line_color[2], line_color[3], 255), color(line_color[1], line_color[2], line_color[3], 0))
    end
end

local function draw_watermark()
    local watermark_text = string.format("%s | %s | delay: %sms | %stick", get_custom_text_from_ui("neverlose", ui_custom_cheat_name), get_custom_text_from_ui(cheat_username, ui_custom_username), get_local_ping(), get_server_tick())

    render_adaptive_box("watermark", screen_size.x, 10, watermark_text, 1)
end

local function draw_fake()
    local fake_text = string.format("FAKE (%s�)", string.format("%.1f", delta))
    local fake_color = {255 - delta * 4, 15 + delta * 4, 0}

    draw_fucking_box(screen_size.x - fake_dt_w - 10, 32, 0, fake_text, 1, 1, fake_color)
end

local function draw_dt()
    local fl_text = string.format("FL: %s", lag)
    if double_tap:GetBool() then fl_text = fl_text .. " | SHIFTING" end

    local dt_text_size = g_Render:CalcTextSize(fl_text, 12, font)

    fake_dt_w = dt_text_size.x + 15

    draw_fucking_box(screen_size.x - 10, 32, 0, fl_text, 0)
end

local function draw_hz()
    local hz_text = string.format("%sms / 144hz", get_local_ping())

    local hz_text_size = g_Render:CalcTextSize(hz_text, 12, font)

    local get_adap_col = adaptive_color(get_local_ping())

    local frame_color = {get_adap_col[1], get_adap_col[2], get_adap_col[3]}

    hz_io_w = hz_text_size.x + 15

    draw_fucking_box(screen_size.x - 10, 57, 0, hz_text, 0, 0, frame_color)
end

local function draw_io()
    local cvar_fps_max = g_CVar:FindVar("fps_max"):GetInt()

    if #fps_info > 4 then table.remove(fps_info, 1) end

    draw_fucking_box(screen_size.x - hz_io_w - 10, 57, 25, "IO |", 0)

    if cvar_fps_max > 100 then fps_max = cvar_fps_max else fps_max = 100 end

    for i = 1, #fps_info do
        gradient_rect(screen_size.x - hz_io_w - 42 - i * 5 + 25, 72, 6, fps_info[i] / fps_max * 9)
    end
end

local keybinds_alpha = 0

local function draw_keybinds()
    local binds = cheat.GetBinds()
    local keybinds_next_line = 0

    local keybinds_x, keybinds_y = ui_keybinds_x:GetInt(), ui_keybinds_y:GetInt()

    local function render_binds(binds)
        if not binds:IsActive() then return end
        local bind_name = binds:GetName()
        local binds_state = string.format("[%s]", binds:GetValue())

        local binds_state_size = g_Render:CalcTextSize(binds_state, 12, font)

        g_Render:Text(bind_name, Vector2.new(keybinds_x + 1, keybinds_y + 21 + keybinds_next_line), text_color(1), 12, font, ui_text_outline:GetBool())
        g_Render:Text(binds_state, Vector2.new(keybinds_x + 149 - binds_state_size.x, keybinds_y + 21 + keybinds_next_line), text_color(1), 12, font, ui_text_outline:GetBool())

        keybinds_next_line = keybinds_next_line + 16
    end

    if #binds > 0 or cheat.IsMenuVisible() then 
        keybinds_alpha = clamp(keybinds_alpha + (1 / .15) * g_GlobalVars.frametime, 0, 1)
    else
        keybinds_alpha = clamp(keybinds_alpha - (1 / .15) * g_GlobalVars.frametime, 0, 1)
    end

    render_adaptive_box("keybinds", keybinds_x, keybinds_y, "keybinds", keybinds_alpha)

    for i = 1, #binds do 
        render_binds(binds[i])
    end

    move(keybinds_x, keybinds_y, 150, 25 + 15 * #binds, ui_keybinds_x, ui_keybinds_y)
end

local spectators_alpha = 0

local function draw_spectators()
    local spectators = get_spectators()
    local spectators_next_line = 0

    local spectators_x, spectators_y = ui_spectators_x:GetInt(), ui_spectators_y:GetInt()

    local function render_spectators(spectators_name)
        local spectators_state = "[watching]"
        local spectators_state_size = g_Render:CalcTextSize(spectators_state, 12, font)

        g_Render:Text(spectators_name, Vector2.new(spectators_x + 1, spectators_y + 21 + spectators_next_line), text_color(1), 12, font, ui_text_outline:GetBool())
        g_Render:Text(spectators_state, Vector2.new(spectators_x + 149 - spectators_state_size.x, spectators_y + 21 + spectators_next_line), text_color(1), 12, font, ui_text_outline:GetBool())
        spectators_next_line = spectators_next_line + 16
    end

    if #spectators > 0 or cheat.IsMenuVisible() then 
        spectators_alpha = clamp(spectators_alpha + (1 / .15) * g_GlobalVars.frametime, 0, 1)
    else
        spectators_alpha = clamp(spectators_alpha - (1 / .15) * g_GlobalVars.frametime, 0, 1)
    end

    render_adaptive_box("keybinds", spectators_x, spectators_y, "spectators", spectators_alpha)

    for i = 1, #spectators do
        render_spectators(spectators[i])
    end

    move(spectators_x, spectators_y, 150, 25 + 15 * #spectators, ui_spectators_x, ui_spectators_y)
end

local hitboxes = {
    'generic',
    'head',
    'chest',
    'stomach',
    'left arm',
    'right arm',
    'left leg',
    'right leg',
    'neck'
};
function Split(s, delimiter)
    result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    return result;
end
cheat.RegisterCallback('registered_shot', function(shot)
    local reason = shot.reason
    -- Miss reasons: 0. Hit 1. Resolver 2. Spread 3. Occlusion 4. Prediction error
    local entity = g_EntityList:GetClientEntity(shot.target_index)
    local Name = entity:GetPlayer():GetName()
    if reason == 0 then
        -- hit
        logs[#logs+1] = {('Hit ' .. Name .. ' for ' .. shot.damage .. ' in ' .. hitboxes[shot.hitgroup+1]), g_GlobalVars.tickcount + 300, 0}
        print('[Essentials.Lua] '.. 'Hit ' .. Name .. ' for ' .. shot.damage .. ' in ' .. hitboxes[shot.hitgroup+1])
    elseif reason == 1 then
        -- resolver
        logs[#logs+1] = {('Missed ' .. Name .. ' due to resolver'), g_GlobalVars.tickcount + 300, 0}
        print('[Essentials.Lua] '.. 'Missed ' .. Name .. ' due to resolver')
    elseif reason == 2 then
        -- spread
        logs[#logs+1] = {('Missed ' .. Name .. ' due to spread'), g_GlobalVars.tickcount + 300, 0}
        print('[Essentials.Lua] '.. 'Missed ' .. Name .. ' due to spread')
    elseif reason == 3 then
        -- Occlusion
        logs[#logs+1] = {('Missed ' .. Name .. ' due to occlusion'), g_GlobalVars.tickcount + 300, 0}
        print('[Essentials.Lua] '.. 'Missed ' .. Name .. ' due to occlusion')
    elseif reason == 4 then
        -- Prediction Error
        logs[#logs+1] = {('Missed ' .. Name .. ' due to prediction error'), g_GlobalVars.tickcount + 300, 0}
        print('[Essentials.Lua] '.. 'Missed ' .. Name .. ' due to prediction error')
    end
end)

local onewaylocations = {
    {"de_mirage", "Palace Entrance", "Fake duck + E", 15, {-32.827205657958984, -1747.707763671875, -116.18266296386719}, {-13.562880516052246, -80.47711944580078, 0}, "Oneway"},
    {"de_mirage", "Palace Entrace", "Crouch + E", 25, {146.87937927246094, -2078.0126953125, 9.615781784057617}, {-0.2739872932434082, -108.96994018554688, 0}, "Oneway"},
    {"de_mirage", "Sniper's Nest", "Crouch + E (manual)", 40, {-886.25830078125, -1317.399658203125, -120.41223907470703}, {-0.3445321321487427, -177.3930206298828, 0}, "Oneway"},
    {"de_mirage", "Cat Box", "Stand ", 10, {-691.8399658203125, -885.2897338867188, -182.1551055908203}, {-1.4627931118011475, 102.77088165283203, 0}, "Oneway"},
    {"de_mirage", "Connector", "Stand ", 1, {-758.4989013671875, -1321.30224609375, -108.56095123291016}, {10.404932975769043, 82.45069122314453, 0}, "Oneway"},
    {"de_mirage", "Cat", "Fake duck ", 10, {-1495.3671875, -1112.000732421875, -183.45028686523438}, {-2.77838134765625, 38.17058563232422, 0}, "Oneway"},
    {"de_mirage", "Apartments", "Fake duck ", 0, {-2336.7314453125, 766.5013427734375, -79.1664810180664}, {-5.943861484527588, -2.0283021926879883, 0}, "Oneway"},
    {"de_mirage", "Cat", "Fake duck ", 0, {-394.3824768066406, -796.3460693359375, -216.0263214111328}, {-5.173882484436035, 122.90838623046875, 0}, "Oneway"},
    {"de_mirage", "T Stairs", "Stand ", 25, {275.092529296875, 316.94354248046875, -201.4618377685547}, {0.7233693599700928, 11.497645378112793, 0}, "Oneway"},
    {"de_mirage", "Top Mid", "Stand ", 35, {219.89126586914062, 877.2789306640625, -76.8647232055664}, {2.8979110717773438, -90.38306427001953, 0}, "Oneway"},
    {"de_mirage", "House Stairs / Top Mid Connector", "Fake duck ", 32, {454.9155578613281, 852.4118041992188, -53.246543884277344}, {16.369403839111328, -44.87099838256836, 0}, "Oneway"},
    {"de_mirage", "Underpass Stairs", "Fake duck ", 10, {-1264.1064453125, 218.20901489257812, -120.45449829101562}, {12.757319450378418, 27.84868621826172, 0}, "Oneway"},
    {"de_mirage", "Underpass Stairs", "Stand ", 15, {-1124.922119140625, 310.01190185546875, -100.71343994140625}, {29.21480369567871, 42.90019226074219, 0}, "Wallbang"},
    {"de_mirage", "Market Entrace", "Fake duck ", 0, {-1705.237548828125, -1220.2938232421875, -207.29591369628906}, {-7.482339859008789, 79.5807113647461, 0}, "Oneway"},
    {"de_mirage", "Apartment Entrance", "Stand ", 12, {-374.2903137207031, 779.552978515625, -20.803316116333008}, {1.6386109590530396, -161.68849182128906, 0}, "Oneway"},
    {"de_mirage", "Underpass Stairs", "Crouch ", 12, {-1101.185791015625, 522.3583984375, -38.548126220703125}, {80.03816223144531, -51.8855094909668, 0}, "Oneway"},
    {"de_mirage", "Right Side Connector", "Stand ", 10, {-842.7730102539062, 32.43463134765625, -108.64161682128906}, {1.2841607332229614, -85.02303314208984, 0}, "Oneway"},
    {"de_mirage", "Palace Entrance", "Fake duck ", 0, {-811.739013671875, -1145.87060546875, -72.66464233398438}, {-2.2234721183776855, -50.907833099365234, 0}, "Oneway"},
    {"de_mirage", "CT Stairs", "Stand ", 20, {-1495.1767578125, -1588.8564453125, -201.6099395751953}, {-0.707923412322998, -79.56673431396484, 0}, "Oneway"},
    {"de_mirage", "CT Spawn", "Stand ", 1, {-1722.5516357421875, -680.75244140625, -108.86699676513672}, {3.074936866760254, -86.70063781738281, 0}, "Wallbang"},
    {"de_mirage", "Market Entrace", "Stand (AWP)", 10, {-2231.71142578125, 32.56330490112305, -108.5659408569336}, {-0.22803455591201782, -47.783348083496094, 0}, "Wallbang"},
    {"de_mirage", "A Ramp", "Fake duck ", 0, {-291.80877685546875, -2112.17333984375, -53.190345764160156}, {7.508554935455322, 48.7481803894043, 0}, "Oneway"},
    {"de_mirage", "Palace/A Ramp Connector", "Fake duck + E", 0, {1127.9307861328125, 228.2334747314453, -185.51644897460938}, {-1.6344425678253174, -89.02660369873047, 0}, "ESP Oneway"},
    {"de_mirage", "Apartments + House", "Fake duck + E", 0, {-477.98028564453125, 492.88311767578125, -99.00080871582031}, {-0.6445350646972656, 89.8587417602539, 0}, "Oneway"},
    {"de_mirage", "Ramp", "Crouch ", 0, {780.37841796875, -1550.7978515625, -60.35479736328125}, {18.644933700561523, -176.00025939941406, 0}, "Oneway"},
    {"de_mirage", "House exit", "Stand", 0, {-859.4331665039062, 614.7947387695312, -14.041431427001953}, {2.2666337490081787, 7.958107948303223, 0}, "Oneway"},
    {"de_mirage", "Apartment entrance", "Stand (AWP)", 0, {-1843.001220703125, 488.68048095703125, -101.81539916992188}, {-2.849693775177002, 3.4349939823150635, 0}, "Oneway"},
    {"de_mirage", "B Van", "Fake duck ", 0, {-2259.607421875, 677.5836791992188, 7.429899215698242}, {5.68641996383667, -71.17919158935547, 0}, "Oneway"},
    {"de_mirage", "Palace", "Stand (manual shoot/ESP) ", 0, {-1506.1005859375, -990.6868896484375, -149.39236450195312}, {-3.874444007873535, -38.0708122253418, 0}, "Wallbang"},
    {"de_mirage", "Top Mid", "Stand", 0, {-266.930573, -366.495056, -103.172424}, {1.882086, 19.124743, 0}, "Oneway"},
    {"de_mirage", "Balcony", "Stand ", 1, {462.96588134765625, -2084.01904296875, 18.9892520904541}, {1.6673067808151245, 177.59693908691406, 0}, "Wallbang"},
    {"de_dust2", "T Spawn", "Fake duck ", 0, {-1828.306884765625, -455.19976806640625, 141.17587280273438}, {-2.199988603591919, -17.8001766204834, 0}, "Oneway"},
    {"de_dust2", "Tunnels", "Fake duck + E", 0, {-2071.30908203125, 2895.8076171875, 82.59713745117188}, {0.7149654626846313, -83.99018859863281, 0}, "Oneway"},
    {"de_dust2", "Tunnels Exit", "Crouch ", 0, {-776.18408203125, 2555.6904296875, -25.649532318115234}, {-4.512523174285889, -147.3076629638672, 0}, "Wallbang"},
    {"de_dust2", "Mid/Cat", "Fake duck ", 0, {-210.51968383789062, 542.5650634765625, 47.2431755065918}, {5.387450218200684, 100.62740325927734, 0}, "Oneway"},
    {"de_dust2", "Long Doors / Blue", "Fake duck ", 25, {1299.95654296875, 620.3975219726562, -3.8381288051605225}, {1.5557122230529785, 150.635986328125, 0}, "Oneway"},
    {"de_dust2", "A Site / Long", "Fake duck ", 0, {1528.8955078125, 505.183837890625, -49.267723083496094}, {-3.854454517364502, 99.73228454589844, 0}, "Oneway"},
    {"de_dust2", "A Site", "Fake duck (Long Plant)", 0, {1570.482421875, 461.5287170410156, -63.220176696777344}, {-5.327244758605957, 99.6102294921875, 0}, "Oneway"},
    {"de_dust2", "B Doors", "Crouch ", 0, {16.597061157226562, 2311.9716796875, 17.10267448425293}, {-0.5667411088943481, -177.3401641845703, 0}, "Wallbang"},
    {"de_dust2", "Long Cross / Ramp", "Fake duck ", 0, {493.2771911621094, 2613.61572265625, 143.1537322998047}, {5.055543422698975, -37.76759338378906, 0}, "Oneway"},
    {"de_dust2", "Long Doors", "Stand ", 1, {1372.70068359375, 1358.381103515625, 50.24076843261719}, {-0.30388620495796204, -139.5752716064453, 0}, "Wallbang"},
    {"de_dust2", "Long Doors Box", "Stand ", 1, {530.4532470703125, 826.2880249023438, 62.459720611572266}, {0.7473396062850952, -50.05582046508789, 0}, "Wallbang"},
    {"de_dust2", "Outside Long House", "Stand ", 10, {554.1951293945312, 353.6593017578125, 69.35932159423828}, {2.23449444770813, -145.07130432128906, 0}, "Oneway"},
    {"de_dust2", "Top Mid", "Stand ", 10, {654.1134033203125, 297.8545227050781, 59.560081481933594}, {0.6505045294761658, -179.7573699951172, 0}, "Oneway"},
    {"de_dust2", "Lower Tunnels", "Stand ", 35, {-216.03515625, 1160.060791015625, 89.53584289550781}, {11.780013084411621, 153.25389099121094, 0}, "Wallbang"},
    {"de_dust2", "Cat", "Stand ", 10, {-874.2039794921875, 1464.575927734375, -53.34953308105469}, {-10.956621170043945, -24.002500534057617, 0}, "Oneway"},
    {"de_inferno", "library | risk", "Stand ", 0, {2491.488974609375, 1232.55009765625, 215.03000000000625}, {12.100088271331787, -170.5400896270752, 0}, "Oneway"},
    {"de_inferno", "barrels | risk", "Crouch ", 0, {2477.968974609375, -130.53009765625, 135.65000000000626}, {2.090088271331787, 168.6500896270752, 0}, "Oneway"},
    {"de_inferno", "box", "Fake duck ", 0, {1999.968974609375, 480.60009765625, 206.65000000000626}, {-10.090088271331787, -100.65008962707519, 0}, "Oneway"},
    {"de_inferno", "box2", "Fake duck ", 0, {2013.97, 701.99, 210.61}, {-0.28, 1.18, 0}, "Oneway"},
    {"de_inferno", "BigBox", "Fake duck ", 0, {2083.79, 182.85, 210.18}, {0.21, 76.14, 0}, "Oneway"},
    {"de_inferno", "Barrels2 | risk", "Fake duck+min dmg ", 0, {63.91, 2603.67, 206.03}, {2.33, 4.84, 0}, "Oneway"},
    {"de_inferno", "Docs", "Fake duck+min dmg ", 0, {753.09, 1871.93, 177.94}, {-2.13, 174.72, 0}, "Oneway"},
    {"de_inferno", "Window", "Fake duck", 0, {-5.32, 383.99, 230.03}, {3.58, 79.43, 0}, "Oneway"},
    {"de_inferno", "BigBox2", "Fake duck+min dmg (AWP)", 0, {2148.63, 301.6, 206.03}, {-13.03, -110.59, 0}, "Oneway"},
    {"de_overpass", "Barrels", "Stand ", 15, {-806.2734033203125, 392.8045227050781, 145.0300814819336}, {8.943388271331788, -67.0492896270752, 0}, "Oneway"},
    {"de_overpass", "Water", "Fake duck", 15, {-1169.75, 256, 76.78}, {0.97, -78.36, 0}, "Oneway"},
    {"de_overpass", "Window", "Stand ", 15, {-1672.8734033203125, 450.7745227050781, 353.0300814819336}, {6.843388271331787, -50.989289627075195, 0}, "Oneway"},
    {"de_overpass", "Kill window | risk", "Stand ", 15, {-416.0434033203125, -2467.324522705078, 267.0300814819336}, {-0.163388271331787, 113.53928962707519, 0}, "Oneway"},
    {"de_overpass", "Stairs", "Fake duck ", 15, {-628.59, -1168.31, 123.18}, {-0.34, 114.22, 0}, "Oneway"},
    {"de_overpass", "Wooden", "Stand | risk ", 15, {-1049.98, -302.36, 163.93}, {-0.14, -63.3, 0}, "Shooting"},
    {"de_overpass", "Cement", "Fake duck ", 15, {-1178.99, 171.99, 143.03}, {-12.23, 150.72, 0}, "Oneway"},
    {"de_cbble", "Outside", "Min dmg | risk (Scar) ", 15, {73.81, -1292.57, -70.09}, {-5.55, 77.47, 0}, "Oneway"},
    {"de_cbble", "Stairs", "Min dmg", 15, {668.03, -466.79, -0.86}, {-0.15, 147.68, 0}, "Oneway"},
    {"de_shortdust", "Car", "Fake Duck", 15, {70.52, 494.88, 46.3}, {-0.37, 98.23, 0}, "Oneway"},
    {"de_vertigo", "Box", "Fake Duck | risk", 15, {-2107.3, 954.03, 11790.03}, {5.45, -110.75, 0}, "Oneway"},
    {"de_vertigo", "Box2", "Fake Duck", 15, {-1435.92, 660.21, 11921.28}, {5.45, -110.75, 0}, "Oneway"},
    {"de_vertigo", "Box", "Stand | risk", 15, {-2113.13, 879.35, 11893.03}, {2.03, -67.31, 0}, "Oneway"},
    {"de_vertigo", "Container", "Min dmg | Stand", 15, {-1900.03, 684.36, 11840.03}, {-10.17, -19.12, 0}, "Oneway"},
    {"de_vertigo", "Container2", "Fake duck", 15, {-2342.9, 741.01, 11843.03}, {5.04, -95.87, 0}, "Oneway"},
    {"de_stmarc", "Bomb site", "Fake duck", 15, {-7918.297363, 6919.025879, 98.03125}, {0.161362, 0.903998, 0}, "Oneway"},
    {"de_stmarc", "CT-Start", "Fake duck", 15, {-6840.3720703125, 6924.4267578125, 136.4663543701172}, {1.393323, -179.350723, 0}, "Oneway"},
    {"de_stmarc", "Wallbang", "Fake duck", 15, {-7536.03125, 7608.307129, 96.03125}, {-0.48401, -36.291946, 0}, "Oneway"},
    {"de_stmarc", "CT-Start", "Fake duck", 15, {-6117.963379, 6421.532715, 221.126678}, {3.212008, 164.714813, 0}, "Oneway"},
    {"de_lake", "Garage", "Fake duck", 15, {4917.955566, -3268.020508, -98.08493}, {-0.696654, 177.950745, 0}, "Oneway"},
    {"de_lake", "T-Spawn", "Fake duck", 15, {2674.694824, -3722.520996, -32.425003}, {2.405347, 5.010656, 0}, "Oneway"},
    {"de_lake", "Bomb-site", "Fake duck", 15, {1652.807129, -4422.253418, -143.955399}, {-3.593326, 10.921947, 0}, "Oneway"},
    {"cs_italy", "Tunnel", "Fake duck", 15, {144.0148468017578, 348.98297119140625, -88.96875}, {0.1613140106201172, -55.74931716918945, 0}, "Oneway"},
    {"cs_italy", "Right Alley", "Fake duck", 15, {-431.9709167480469, -112.07582092285156, -88.96875}, {2.903980255126953, -52.03858947753906, 0}, "Oneway"},
    {"cs_italy", "Long Hall", "Fake duck", 15, {18.86300277709961, 2416.03125, 20.98790740966797}, {-0.806647777557373, -40.530582427978516, 0}, "Oneway"},
    {"de_nuke", "Outside", "Fake duck", 15, {3.446795701980591, -1662.1339111328125, 43.0312614440918}, {15.810659408569336, 1.4775171279907227, 0}, "Oneway"},
    {"de_nuke", "Ramp", "Fake duck", 15, {1356.9029541015625, -742.7432861328125, -602.7978515625}, {-0.9680168628692627, 144.7721710205078, 0}, "Oneway"},
    {"de_nuke", "Outside", "Fake duck", 15, {1413.1536865234375, -2430.9287109375, -417.742919921875}, {-1.129349708557129, 171.13609313964844, 0}, "Oneway"},
    {"de_train", "T Spawn", "Fake duck", 15, {1288.0654296875, 1706.8900146484375, -159.4558868408203}, {0.16135096549987793, -173.07870483398438, 0}, "Oneway"},
    {"de_train", "T Main", "Fake duck", 15, {-262.8990478515625, 487.631591796875, 35.01689910888672}, {20.65067481994629, 172.34555053710938, 0}, "Oneway"},
    {"de_train", "Ivy Tunnel", "Fake duck", 15, {653.9949951171875, 493.5329284667969, 34.03125190734863}, {15.48801040649414, 2.9309511184692383, 0}, "Oneway"},
    {"de_train", "Bombsite", "Fake duck", 15, {806.224609375, -463.09716796875, 103.03125}, {15.165338516235352, 118.57878112792969, 0}, "Oneway"},
    {"de_train", "Tunnel Two", "Fake duck", 15, {1969.5577392578125, -779.9430541992188, -214.94512939453125}, {-2.2586476802825928, 96.63731384277344, 0}, "Oneway"},
    {"de_anubis", "CT Side", "Fake duck", 15, {-582.8221435546875, 2328.042236328125, 31.949859619140625}, {-2.097200870513916, -91.29068756103516, 0}, "Oneway"},
    {"de_anubis", "Middle", "Fake duck", 15, {374.30450439453125, 1477.012451171875, 57.668325424194336}, {1.9360682964324951, -99.35801696777344, 0}, "Oneway"},
}
local locations = {
    {"de_inferno", {2146.013671875, 1815.412353515625, 192.03125}, {-51.20778274536133, 82.2809066772461, 0}, "molotov", "Wall", "Jump+Throw", 1},
    {"de_inferno", {1832.9774169921875, 1387.2230224609375, 224.03125}, {-24.11488151550293, -76.67398071289062, 0}, "molotov", "Box A", "Throw", 1},
    {"de_inferno", {1747.063232421875, 1164.5677490234375, 223.2921600341797}, {-39.75991439819336, -57.84412384033203, 0}, "molotov", "Plant", "Jump+Throw", 1},
    {"de_inferno", {1127.7274169921875, 434.03125, 171.98770141601562}, {-7.068625450134277, 58.008270263671875, 0}, "molotov", "Archade", "Jump+Half throw", 1},
    {"de_inferno", {2147.978271484375, 1225.638427734375, 236.13442993164062}, {3.9420006275177, -91.23828125, 0}, "molotov", "Under Balcony", "Jump+Throw", 1},
    {"de_inferno", {1389.8297119140625, -107.9889144897461, 194.03125}, {-8.408277702331542, 25.320009231567383, 0}, "molotov", "Box", "Run+Throw", 7},
    {"de_inferno", {1683.911376953125, 1114.0875244140625, 224.64810180664062}, {-1.5491523742675781, 60.929998779296874, 0}, "molotov", "CT Left", "Run+Throw", 15},
    {"de_inferno", {2100.735595703125, 165.94873046875, 206.03125}, {-8.737442970275879, 143.4633026123047, 0}, "molotov", "Onspot (Ctrl)", "Throw", 0},
    {"de_inferno", {1968.1119384765625, 493.1418762207031, 206.03125}, {-17.89667510986328, -116.5967025756836, 0}, "molotov", "Box (Ctrl)", "Throw", 0},
    {"de_inferno", {1828.4495849609375, 638.993896484375, 206.03125}, {-9.970830917358398, -58.62622833251953, 0}, "molotov", "Short (Ctrl)", "Throw", 0},
    {"de_inferno", {1841.034423828125, -182.4413299560547, 302.03125}, {-8.463659286499023, 0.08327874541282654, 0}, "molotov", "Pit (Ctrl)", "Throw", 1},
    {"de_inferno", {875.9984130859375, 2388.717529296875, 209.15281677246094}, {-15.088058471679688, 167.61131286621094, 0}, "molotov", "Boost", "Throw", 0},
    {"de_inferno", {363.1495666503906, 1729.6339111328125, 185.4627685546875}, {-42.11574172973633, 95.83378601074219, 0}, "molotov", "Fountain", "Run+Jump+Throw", 0},
    {"de_inferno", {1348, 180, 192.03}, {-6.06, -29.84, 0}, "molotov", "Graveyard", "Run+Jump+Throw", 0},
    {"de_inferno", {677.5061645507812, 1873.083251953125, 275.97381591796875}, {-24.77174987792969, 94.12499237060547, 0}, "molotov", "Back of coffins", "Run+Throw", 8},
    {"de_inferno", {463.9, 2016.76, 241.03}, {1.85, 89.72, 0}, "molotov", "Back of coffins", "Jump+Throw", 0},
    {"de_inferno", {929.793701171875, 3297.88427734375, 208.03125}, {-45.240116119384766, -131.6338348388672, 0}, "molotov", "B Plant", "Jump+Throw", 0},
    {"de_inferno", {1354.9896240234375, 562.964111328125, 194.08775329589844}, {-34.980167388916016, -1.4850000143051147, 0}, "molotov", "Site/Box", "Jump+Throw", 0},
    {"de_inferno", {2016.1488037109375, 1225.9681396484375, 238.09381103515625}, {-34.54010772705078, -64.21525573730469, 0}, "molotov", "Graveyard", "Run+Jump+Throw", 0},
    {"de_inferno", {2103.02734375, 1225.9996337890625, 238.03125}, {-32.284767150878906, -89.29568481445312, 0}, "molotov", "A Box", "Run+Jump+Throw", 0},
    {"de_inferno", {1956.4254150390625, 1225.9969482421875, 238.03125}, {-38.13465118408203, -87.4595278930664, 0}, "molotov", "A Box+Site", "Run+Jump+Throw", 0},
    {"de_inferno", {2088.603759765625, 1010.026123046875, 223.90396118164062}, {-2.529167413711548, 20.762910842895508, 0}, "molotov", "Library", "Run+Throw", 22},
    {"de_inferno", {2101.66455078125, 1170.7098388671875, 228.4114532470703}, {-16.804609298706055, -63.30951690673828, 0}, "molotov", "Pit", "Run+Throw", 22},
    {"de_inferno", {2349.379638671875, 568.1921997070312, 212.2619171142578}, {-37.12451934814453, -178.91851806640625, 0}, "molotov", "Mid", "Run+Jump+Throw", 0},
    {"de_inferno", {2058.737548828125, 1225.9610595703125, 238.09381103515625}, {-2.366106033325195, -90.5411148071289, 0}, "molotov", "Balcony", "Jump+Throw", 1},
    {"de_inferno", {1362.193115234375, 278.77166748046875, 192.34524536132812}, {-19.46942138671875, -47.9648551940918, 0}, "molotov", "A Box", "Run+Throw", 22},
    {"de_inferno", {1762.0330810546875, 1360.9228515625, 224.03125}, {-19.634239196777344, -54.91761779785156, 0}, "molotov", "Graveyard v2", "Throw", 0},
    {"de_inferno", {2088.603759765625, 1010.026123046875, 223.90396118164062}, {-2.529167413711548, 20.762910842895508, 0}, "molotov", "Library", "Run+Throw", 22},
    {"de_inferno", {430.74438476563, 1792.8693847656, 290.03125}, {-16.198610305786, 88.217079162598, 0}, "molotov", "Back of coffins", "Run+Throw", 1},
    {"de_inferno", {1971.43017578125, 1094.82421875, 220.17811584472656}, {-48.11808776855469, -88.9716796875, 0}, "molotov", "Right side", "Jump+Throw", 0},
    {"de_inferno", {1370.03125, 929.795166015625, 210.65403747558594}, {-15.146607398986816, 30.065826416015625, 0}, "molotov", "CT Spawn", "Run+Throw", 22},
    {"de_inferno", {1900.05712890625, 501.0020751953125, 224.09381103515625}, {-45.50659942626953, 50.22550582885742, 0}, "molotov", "Library", "Run+Jump+Throw", 0},
    {"de_inferno", {1289.9197998046875, 540.9373168945312, 185.51490783691406}, {-46.20145034790039, 54.244258880615234, 0}, "molotov", "Archade", "Run+Jump+Throw", 0},
    {"de_inferno", {1764.96875, -108.96875, 194.13592529296875}, {-27.57658576965332, 60.56570053100586, 0}, "molotov", "Under balcony", "Throw", 0},
    {"de_inferno", {339.9753723144531, 2027.8807373046875, 192.09381103515625}, {-48.52350616455078, 83.03205108642578, 0}, "molotov", "Sandwich", "Jump+Throw", 0},
    {"de_inferno", {442.907470703125, 2622.138916015625, 224.09381103515625}, {-49.4201774597168, -81.290771484375, 0}, "molotov", "Back molly", "Run+Jump+Throw", 0},
    {"de_inferno", {1733.21521, -44.736149, 194.06773376465}, {-12.087965965271, 43.120056152344, 0}, "molotov", "Onspot/Far corner", "Run+Throw", 2},
    {"de_inferno", {1517.967529296875, 681.1097412109375, 201.577392578125}, {-20.40003776550293, -176.8412322998047, 0}, "molotov", "Underpass", "Throw", 0},
    {"de_inferno", {1314.0313720703125, 829.7234497070312, 212.68206787109375}, {-27.21154022216797, 3.696570873260498, 0}, "molotov", "Spawn", "Jump+Throw", 0},
    {"de_inferno", {1965.0166015625, 1183.7078857421875, 225.56573486328125}, {-42.14789962768555, -91.34784698486328, 0}, "molotov", "Right side", "Jump+Throw", 0},
    {"de_inferno", {1768.0330810546875, 1269.1590576171875, 224.03125}, {-3.7859888076782227, -11.473220825195312, 0}, "molotov", "Libraly", "Run+Throw", 21},
    {"de_inferno", {2071.656982421875, 1221.7213134765625, 238.03125}, {-28.840972900390625, -107.22435760498047, 0}, "molotov", "Box", "Throw", 0},
    {"de_inferno", {2028.642578125, 479.9376525878906, 224.03125}, {-37.500423431396484, 86.58782958984375, 0}, "molotov", "Short", "Jump+Throw", 0},
    {"de_inferno", {2002.0897216796875, 2691.276123046875, 192.09381103515625}, {-24.14739990234375, 174.71231079101562, 0}, "molotov", "Fountain", "Run+Throw", 12},
    {"de_inferno", {927.6892700195312, 2171.890380859375, 204.03125}, {-11.469472885131836, 117.90215301513672, 0}, "molotov", "Coffins", "Run+Throw", 1},
    {"de_inferno", {875.9984130859375, 2388.717529296875, 209.15281677246094}, {-15.088058471679688, 167.61131286621094, 0}, "molotov", "Boost", "Throw", 0},
    {"de_inferno", {2060.159423828125, 1178.3782958984375, 227.755615234375}, {1.879959225654602, -54.997352600097656, 0}, "molotov", "Box", "Run+Jump+Throw", 0},
    {"de_inferno", {2055.896484375, 185.97694396972656, 224.03125}, {-20.230152130126953, 87.20265197753906, 0}, "molotov", "Long", "Throw", 0},
    {"de_inferno", {1315.357177734375, 320.9294128417969, 193.03125}, {-4.40474796295166, -47.41691207885742, 0}, "molotov", "A box", "Run+Jump+Throw", 0},
    {"de_inferno", {2607.96923828125, 1422.933349609375, 224.03125}, {-4.136423587799072, -118.7625961303711, 0}, "molotov", "A box", "Run+Throw", 30},
    {"de_inferno", {2486.996826171875, 953.5765380859375, 225.39120483398438}, {-22.910964965820312, -142.81121826171875, 0}, "molotov", "A box", "Run+Throw", 3},
    {"de_inferno", {1796.3748779296875, -360.8190002441406, 320.03125}, {0.32776308059692383, 63.58148956298828, 0}, "molotov", "One-way", "Run+Throw", 1},
    {"de_inferno", {-285.39, 850.77, 70.95}, {-12.13, -148.8, 0}, "molotov", "One-way", "Throw", 1},
    {"de_anubis", {850.0313, 627.0505, -128.9688}, {-26.03795, 90.84998, 0}, "molotov", "Canal Heaven Minor", "Throw", 0},
    {"de_cbble", {-3325.397, -37.7071, 34.03125}, {-29.11675, -42.65284, 0}, "molotov", "Fakeduck", "Throw", 1},
    {"de_cbble", {-3253.736328125, -404.54010009765625, 90.36087036132812}, {-17.26286506652832, -25.509010314941406, 0}, "molotov", "Fakeduck", "Throw", 1},
    {"de_cbble", {-2500.2626953125, 360.7279968261719, -175.96875}, {-1.4078673124313354, -65.94874572753906, 0}, "molotov", "Door", "Run Jump+Throw", 15},
    {"de_cbble", {-2457.185546875, 386.46575927734375, -175.96875}, {-1.9899286031723022, -73.64030456542969, 0}, "molotov", "Fakeduck", "Run+Jump+Throw", 15},
    {"de_cbble", {-2352.347900390625, 402.14862060546875, -175.96875}, {-0.16432109475135803, -87.94781494140625, 0}, "molotov", "Plant", "Run+Jump+Throw", 15},
    {"de_cbble", {-41.03447341918945, -16.018699645996094, 32.03125}, {-51.7022705078125, -112.57310485839844, 0}, "molotov", "Onshot spot / Rock", "Run+Jump+Throw", 20},
    {"de_cbble", {-211.70458984375, -462.06207275390625, 26.136920928955078}, {-12.59825325012207, -59.866249084472656, 0}, "molotov", "Chicken Coop", "Throw", 1},
    {"de_cbble", {418.25445556640625, -291.0088195800781, -15.969482421875}, {-11.940940856933594, -141.7146453857422, 0}, "molotov", "Rock", "Throw", 0},
    {"de_cbble", {-158.22752380371094, -16.013084411621094, 32.03125}, {-33.66744613647461, -48.10280990600586, 0}, "molotov", "Drop", "Throw", 0},
    {"de_cbble", {212.24295043945312, -120.43531036376953, 45.717777252197266}, {-7.2488813400268555, -68.04000854492188, 0}, "molotov", "Chicken Coop", "Run+Throw", 22},
    {"de_cbble", {271.10662841796875, -199.01580810546875, 50.6855354309082}, {-6.255178928375244, -97.36959075927734, 0}, "molotov", "Fountain", "Throw", 1},
    {"de_cbble", {54.487701416016, -108.96550750732, 31.6855354309082}, {4.35141799449921, -29.683708572388, 0}, "molotov", "Fountain", "Run+Jump+Throw", 0},
    {"de_cbble", {-303.96893310546875, -16.031368255615234, 32.03125}, {-2.577958822250366, -34.6016731262207, 0}, "molotov", "Corner / Drop", "Jump+Throw", 0},
    {"de_cbble", {-134.8046112060547, -477.54022216796875, 32.03125}, {-22.98744010925293, -61.4238052368164, 0}, "molotov", "Fountain", "Half throw", 1},
    {"de_cbble", {-3325.3974609375, -37.70710372924805, 34.03125}, {-29.116748809814453, -42.652835845947266, 0}, "molotov", "A ramp", "Throw", 0},
    {"de_cbble", {-296.96868896484375, -618.466552734375, 0.03125}, {-5.412281036376953, 28.672893524169922, 0}, "molotov", "Long", "Run+Throw", 0},
    {"de_cbble", {-121.03929138183594, -520.0784301757812, 32.03125}, {-60.54490280151367, 116.79296112060547, 0}, "molotov", "Long", "Jump+Throw", 0},
    {"de_cbble", {263.8317565917969, -227.96875, 50.0172233581543}, {-6.73521089553833, -94.15193176269531, 0}, "molotov", "Fountain", "Throw", 0},
    {"de_cbble", {470.54266357421875, -96.39266967773438, 64.03125}, {-11.429889678955078, -136.1748809814453, 0}, "molotov", "Spot", "Run+Throw", 4},
    {"de_cbble", {-78.07276916503906, -359.82354736328125, 32.34855651855469}, {-6.536237716674805, -65.1264419555664, 0}, "molotov", "Fountain", "Throw", 0},
    {"de_cbble", {47.968746185302734, -16.031248092651367, 40.82012176513672}, {-31.56991958618164, -124.61907958984375, 0}, "molotov", "Drop", "Throw", 0},
    {"de_cbble", {632.5053100585938, -43.6341438293457, 64.03125}, {-0.15501952171325684, -149.0502471923828, 0}, "molotov", "pmolotov", "Jump+Throw", 0},
    {"de_cbble", {523.110107421875, -378.8696594238281, 97.04801940917969}, {-3.6841986179351807, -152.3155975341797, 0}, "molotov", "Rock", "Throw", 0},
    {"de_cbble", {417.5230407714844, -245.27734375, 96.62545776367188}, {-0.604919970035553, -144.09478759765625, 0}, "molotov", "Rock", "Throw", 0},
    {"de_cbble", {-977.6757202148438, -421.443603515625, 32.03125}, {-3.4649972915649414, -37.63951110839844, 0}, "molotov", "Drop", "Run+Throw", 5},
    {"de_cbble", {-756.2769775390625, -690.8958129882812, 32.03125}, {-35.475032806396484, 2.815243721008301, 0}, "molotov", "Fountain", "Run+Throw", 15},
    {"de_cbble", {685.4472045898438, -1.4913617372512817, 64.03125}, {-25.564985275268555, -146.84031677246094, 0}, "molotov", "One-way", "Run+Throw", 1},
    {"de_cbble", {-191.02610778808594, -399.6893005371094, 37.84439468383789}, {-13.795077323913574, -79.57482147216797, 0}, "molotov", "Fast-Fountan", "Run+Throw", 1},
    {"de_cbble", {488.8741760253906, -993.6104736328125, -38.028717041015625}, {-15.784880638122559, 152.2181396484375, 0}, "molotov", "Drop", "Run+Throw", 11},
    {"de_cbble", {-814.425048828125, -810.9334106445312, 32.03125}, {-9.156630516052246, 36.04106140136719, 0}, "molotov", "Rock", "Run+Throw", 40},
    {"de_cbble", {-90.51810455322266, -239.96875, 32.03125}, {-18.97529411315918, 92.15987396240234, 0}, "molotov", "Drop", "Run+Jump+Throw", 0},
    {"de_cbble", {277.2549133300781, -80.73084259033203, 51.13441848754883}, {-15.785367965698242, -94.66912841796875, 0}, "molotov", "Drop", "Run+Throw", 17},
    {"de_cbble", {416.2643737792969, -55.143890380859375, 64.4034652709961}, {-13.695815086364746, -122.13880157470703, 0}, "molotov", "Rock", "Run+Throw", 10},
    {"de_cbble", {-67.44760131835938, -378.5363464355469, 32.09381103515625}, {-18.30468894958496, -87.59717559814453, 0}, "molotov", "Fountain", "Run+Throw", 13},
    {"de_cbble", {104.91864776611328, -931.0748901367188, 12.359916687011719}, {-28.488767623901367, 118.79454803466797, 0}, "molotov", "Nader ", "Run+Throw", 4},
    {"de_cbble", {-859.6728515625, -361.4102783203125, 229.03125}, {21.912416458129883, -58.593292236328125, 0}, "molotov", "Push", "Throw", 0},
    {"de_cbble", {-914.97265625, -414.41497802734375, 72.03125}, {0.9579959511756897, -44.63691711425781, 0}, "molotov", "Drop [NEAR]", "Run+Throw", 7},
    {"de_overpass", {-572.3495483398438, -1111.22509765625, 113.6233901977539}, {2.0440171718597413, 102.41517852783203, 0}, "molotov", "Column", "Jump+Throw", 1},
    {"de_overpass", {-1283.046875, -49.718772888183594, 205.03125}, {-17.692794799804688, -61.63851547241211, 0}, "molotov", "Stairs", "Throw", 1},
    {"de_overpass", {-497.445556640625, -1152.6827392578125, 120.62655639648438}, {-24.202425003051758, 104.0164566040039, 0}, "molotov", "Barrels", "Run+Throw", 1},
    {"de_overpass", {-1437.5657958984375, -831.1069946289062, 95.86343383789062}, {-23.06824493408203, 56.96048355102539, 0}, "molotov", "Fakeduck one-way", "Throw", 1},
    {"de_overpass", {-1113.0211181640625, -638.95947265625, 154.62704467773438}, {-2.4265174865722656, 88.95486450195312, 0}, "molotov", "Water", "Jump+Half throw", 1},
    {"de_overpass", {-3520.640869140625, -300.6399230957031, 586.267333984375}, {-12.154999732971191, -106.21949768066406, 0}, "molotov", "Rock", "Throw", 1},
    {"de_overpass", {-1141.4085693359375, 157.20999145507812, 144.03125}, {-24.383459091186523, 152.04100036621094, 0}, "molotov", "Heaven (Ctrl)", "Throw", 1},
    {"de_overpass", {-1943.509155, 486.048767, 320.03125}, {-0.499636, 4.777925, 0}, "molotov", "Plant / Bags", "Run+Throw", 10},
    {"de_overpass", {-868.6688842773438, -554.2891235351562, 160.03125}, {-28.22175407409668, 107.87091064453125, 0}, "molotov", "Water", "Throw", 1},
    {"de_overpass", {-1291.8780517578125, -894.5955200195312, 74.5079116821289}, {-24.202457427978516, 73.71977233886719, 0}, "molotov", "Column", "Throw", 1},
    {"de_overpass", {-481.5085754394531, -528.2068481445312, 75.55261993408203}, {-8.179642677307129, 107.55441284179688, 0}, "molotov", "Column", "Run+Throw", 22},
    {"de_overpass", {-1399.9913330078125, -139.9641571044922, 64.03125}, {-44.40797424316406, 12.441910743713379, 0}, "molotov", "Stoune", "Throw", 1},
    {"de_overpass", {-1840.3201904296875, 1027.419677734375, 544.03125}, {0.5991190075874329, -27.256139755249023, 0}, "molotov", "Barrels", "Throw", 1},
    {"de_overpass", {-2351.97, -305.94, 455.12}, {-5.47, 79.27, 0}, "molotov", "Fakeduck", "Jump+Throw", 1},
    {"de_overpass", {-3118.36, -2196.17, 533.03}, {-35.77, 132.76, 0}, "molotov", "Rock", "Jump+Throw", 0},
    {"de_overpass", {-1058.0670166015625, -614.3963623046875, 160.03125}, {-11.882340431213379, 85.58399963378906, 0}, "molotov", "Water", "Throw", 0},
    {"de_overpass", {-431.083984375, -1551.96875, 208.03125}, {-18.816823959350586, 101.29425048828125, 0}, "molotov", "Barrels", "Run+Throw", 34},
    {"de_overpass", {-1275.1700439453125, -967.4072265625, 69.54157257080078}, {-23.194683074951172, 81.81474304199219, 0}, "molotov", "Water", "Throw", 1},
    {"de_overpass", {-864.8922119140625, -583.9449462890625, 160.03125}, {-12.365560531616211, 88.21858978271484, 0}, "molotov", "Barrels", "Throw", 1},
    {"de_overpass", {-1565.90380859375, -1085.5133056640625, 64.03125}, {-26.96200942993164, 65.58547973632812, 0}, "molotov", "Barrels", "Run+Throw", 22},
    {"de_overpass", {-1276.89990234375, 481.6439514160156, 99.29470825195312}, {-1.6839944124221802, -40.52040481567383, 0}, "molotov", "Long", "Run+Throw", 22},
    {"de_overpass", {-2079.580322265625, 558.7537841796875, 588.5204467773438}, {-58.783111572265625, -139.71771240234375, 0}, "molotov", "Fakeduck", "Jump+Throw", 0},
    {"de_overpass", {-856.03125, -638.96875, 160.09381103515625}, {2.931612968444824, 128.65623474121094, 0}, "molotov", "Heaven", "Run+Jump+Throw", 0},
    {"de_overpass", {-258.62713623046875, -1085.50732421875, 79.9764404296875}, {-30.743484497070312, 152.96783447265625, 0}, "molotov", "Short", "Run+Throw", 18},
    {"de_overpass", {-3264.019287109375, 162.6830291748047, 576.2027587890625}, {-15.415439414978026, 32.65627212524414, 0}, "molotov", "Fakeduck", "Run+Throw", 0},
    {"de_overpass", {-2474.96875, -1987.7607421875, 578.5694580078125}, {-13.23123550415039, 82.03817749023438, 0}, "molotov", "Toilet", "Throw", 0},
    {"de_overpass", {-3261.715087890625, 278.5001220703125, 559.061279296875}, {-21.940736770629883, 13.571399688720703, 0}, "molotov", "Car", "Throw", 0},
    {"de_overpass", {-768.15313720703, 80.262344360352, 135.407666015625}, {-8.491834640503, -138.96389770508, 0}, "molotov", "Under-Water", "Run+Throw", 7},
    {"de_overpass", {-1037.2846679688, -638.74468994141, 160.03125}, {-15.649391174316, 74.50463104248, 0}, "molotov", "Barrels", "Throw", 0},
    {"de_overpass", {-1293.7613525390625, -1078.581298828125, 64.03125}, {-23.324857711791992, 93.77328491210938, 0}, "molotov", "Under-Water", "Throw", 0},
    {"de_overpass", {-2441.76806640625, 95.25958251953125, 472.5286865234375}, {-16.650772857666016, 66.34442291259766, 0}, "molotov", "Fakeduck (Ctrl)", "Throw", 0},
    {"de_overpass", {-611.7730102539062, -1120.4915771484375, 122.72051239013672}, {2.627079010009766, 109.64917907714845, 0}, "molotov", "Water", "Jump+Throw", 0},
    {"de_overpass", {-3192.387451171875, 229.8459014892578, 562.8496704101562}, {2.711792755126953, -98.61564636230469, 0}, "molotov", "ROCK", "Run+Jump+Throw", 0},
    {"de_overpass", {-2100.6826171875, 430.564208984375, 168.03125}, {-31.1096248626709, 59.785770416259766, 0}, "molotov", "Up Heaven", "Throw", 1},
    {"de_overpass", {-1568.907958984375, -801.8662109375, 200.03125}, {-11.274955749511719, 68.9798812866211, 0}, "molotov", "water", "Throw", 1},
    {"de_overpass", {-555.1334228515625, -1045.6644287109375, 90.62112426757812}, {-2.151278495788574, 116.653076171875, 0}, "molotov", "Water", "Jump+Throw", 0},
    {"de_overpass", {-430.97479248046875, -1933.31689453125, 209.09381103515625}, {-23.884199142456055, 103.16865539550781, 0}, "molotov", "One-way", "Run+Throw", 4},
    {"de_overpass", {-519.7714233398438, -422.4078674316406, 71.05879974365234}, {-20.35335350036621, 104.29834747314453, 0}, "molotov", "barrels", "Throw", 1},
    {"de_overpass", {-1093.5, -535.65, 158.95}, {-10.88, -107.46, 0}, "molotov", "Under-Water", "Run+Jump+Throw", 4},
    {"de_overpass", {-455.64, 384.61, 91.26}, {-25.04, -149.05, 0}, "molotov", "Barrels", "Throw", 3},
    {"de_overpass", {-2302.07, 55.02, 540.03}, {-53.8, 63.6, 0}, "molotov", "Truck", "Jump+Throw", 22},
    {"de_overpass", {-2087.02, 677.44, 320.03}, {4.4, -28.24, 0}, "molotov", "Plant", "Run+Throw", 5},
    {"de_overpass", {-1744.02, 1233.48, 417.83}, {-17.78, -140.39, 0}, "molotov", "Plant", "Throw", 22},
    {"de_overpass", {-2052.37, 1248.41, 420.03}, {-20.64, -87.12, 0}, "molotov", "Plant", "Throw", 22},
    {"de_overpass", {-2212.88, 450.48, 544.03}, {-11.59, 51.82, 0}, "molotov", "Fakeduck", "Throw", 22},
    {"de_overpass", {-2749.68, -1758.59, 536.03}, {18.12, 46.52, 0}, "molotov", "Fakeduck", "Jump+Throw", 22},
    {"de_overpass", {-1241.18, -172.76, 164.59}, {-42.6, 87.1, 0}, "molotov", "Water", "Throw", 1},
    {"de_overpass", {-398.23, 355.61, 90.97}, {-14.01, -158.23, 0}, "molotov", "Water", "Throw", 1},
    {"de_overpass", {-1869.04, -19.03, 192.03}, {-28.71650505065918, 62.48297882080078, 0}, "molotov", "Heaven", "Throw", 2},
    {"de_overpass", {-2413.51, 35.92, 466.82}, {-19.02, 89.45, 0}, "molotov", "Left Fakeduck (Ctrl)", "Throw", 1},
    {"de_overpass", {-2017.49, 712.84, 302.03}, {-6.61, -41.1, 0}, "molotov", "Right Plant (Ctrl)", "Throw", 1},
    {"de_overpass", {-1228.18, 294.12, 83.39}, {-52.68, -84.72, 0}, "molotov", "Back Side", "Throw", 1},
    {"de_safehouse", {1931.003, 90.58, 486.03}, {5.98, 148.01, 0}, "molotov", "Car (Ctrl)", "Throw", 1},
    {"de_safehouse", {970.78, 119.42, 305.46}, {-26.36, -0.15, 0}, "molotov", "Plant (Ctrl)", "Throw", 1},
    {"de_safehouse", {2023.56, 340.85, 429.07}, {-8.38, -112.82, 0}, "molotov", "Garage (Ctrl)", "Throw", 0},
    {"de_safehouse", {2350.07, 130.8, 774.83}, {0.96, 179.65, 0}, "molotov", "Fakeduck", "Throw", 0},
    {"de_safehouse", {2383.5, 255.85, 796.18}, {9.43, 168.69, 0}, "molotov", "Car", "Throw", 0},
    {"de_safehouse", {1990.64, 185.97, 486.03}, {0.92, -178.16, 0}, "molotov", "Fakeduck (Ctrl)", "Throw", 0},
    {"de_shortdust", {-318.39, 634.1, 28.09}, {-18.18, -35.98, 0}, "molotov", "Right Barrels", "Run+Throw", 7},
    {"de_shortdust", {-880.750244140625, 950.0850830078125, 99.03125}, {-14.542377471923828, -35.758758544921875, 0}, "molotov", "Car", "Run+Throw", 4},
    {"de_shortdust", {-1247.96875, 1154.4630126953125, -121.49449157714844}, {-32.16046142578125, -30.957191467285156, 0}, "molotov", "pit holder", "Run+Throw", 0},
    {"de_shortdust", {654.0101928710938, 1008.4571533203125, 96.03125}, {-9.028057098388672, -120.85869598388672, 0}, "molotov", "Barrels", "Run+Throw", 1},
    {"de_shortdust", {-1279.95751953125, 1039.959716796875, -106.33393859863281}, {-28.097429275512695, -18.630277633666992, 0}, "molotov", "One-way-Car", "Run+Throw", 2},
    {"de_shortdust", {-309.7664794921875, 1931.7659912109375, 96.09381103515625}, {-5.443653583526611, -45.43484878540039, 0}, "molotov", "box", "Run+Throw", 22},
    {"de_shortdust", {-391.27145385742, 786.81726074219, 100.03125}, {-21.001636505127, -53.710342407227, 0}, "molotov", "Fakeduck-ct", "Throw", 0},
    {"de_shortdust", {-223.39918518066, 531.02197265625, 47.09381103515625}, {-13.178301811218, 22.96457862854, 0}, "molotov", "Tunnel", "Run+Throw", 3},
    {"de_shortdust", {-176.642471, 1805.493286, 96.09381103515625}, {-6.5653779029846, -45.643031311035, 0}, "molotov", "Tunnel", "Run+Throw", 4},
    {"de_shortdust", {-1303.968384, 1095.969116, 95.09381103515625}, {1.756760025024, -36.840308380127, 0}, "molotov", "Fakeduck-ct Safe", "Run+Jump+Throw", 4},
    {"de_shortdust", {-1152.62744140625, 851.336669921875, -118.4097900390625}, {-3.942361354827881, -14.705856323242188, 0}, "molotov", "Car", "Jump+Throw", 0},
    {"de_shortdust", {-322.5305480957031, 558.5027465820312, 28.732650756835938}, {-9.251864433288574, 49.09822463989258, 0}, "molotov", "Under Tunnel", "Run+Throw", 13},
    {"de_shortdust", {-313.6225280761719, 599.0184326171875, 29.653831481933594}, {-8.828033447265625, 47.2617073059082, 0}, "molotov", "Box Tunnel", "Run+Throw", 22},
    {"de_shortdust", {647.1802978515625, 934.906005859375, 96.09381103515625}, {-19.280649185180664, -142.6157684326172, 0}, "molotov", "Car", "Throw", 0},
    {"de_shortdust", {-470.57244873046875, 1398.5103759765625, 96.03125}, {-4.154214859008789, -15.444559097290039, 0}, "molotov", "Box Tunnel ", "Run+Throw", 5},
    {"de_shortdust", {-429.04443359375, 1454.96875, 96.03125}, {-10.298568725585938, -15.79753303527832, 0}, "molotov", "Tunnel", "Run+Throw", 1},
    {"de_shortdust", {686.9838256835938, 948.6428833007812, 96.03125}, {-6.56814432144165, -151.6712646484375, 0}, "molotov", "Fakeduck", "Throw", 0},
    {"de_shortdust", {686.96875, 1009.4090576171875, 96.03125}, {-11.4992036819458, -123.99596405029297, 0}, "molotov", "Fakeduck CT", "Run+Throw", 18},
    {"de_shortdust", {686.9826049804688, 962.6719360351562, 96.02374267578125}, {-12.712480545043945, -143.78585815429688, 0}, "molotov", "Long", "Run+Throw", 1},
    {"de_shortdust", {686.96875, 892.0845336914062, 96.03125}, {-11.659896850585938, -146.19418334960938, 0}, "molotov", "Car", "Throw", 0},
    {"de_shortdust", {640.96875, 958.4212036132812, 96.03125}, {-26.51002311706543, -104.77488708496094, 0}, "molotov", "Fakeduck", "Throw", 0},
    {"de_shortdust", {-1211.3536376953125, 1002.5739135742188, -117.77061462402344}, {-0.4110558032989502, -23.807748794555664, 0}, "molotov", "Pit", "Jump+Throw", 0},
    {"de_shortdust", {-1155.4046630859375, 940.4202880859375, -120.10832214355469}, {-1.6117432117462158, -23.225543975830078, 0}, "molotov", "Pit", "Jump+Throw", 0},
    {"de_shortdust", {-159.11851501464844, 1002.268798828125, 108.12178039550781}, {-4.648420333862305, 33.95532989501953, 0}, "molotov", "Tunnel", "Run+Throw", 4},
    {"de_shortdust", {421.2156677246094, 1170.03125, 96.03125}, {-4.577783584594727, 165.55421447753906, 0}, "molotov", "Short", "Run+Throw", 10},
    {"de_shortdust", {348.1866149902344, 1325.9559326171875, 96.03125}, {1.707880973815918, -131.73133850097656, 0}, "molotov", "Long", "Run+Throw", 13},
    {"de_train", {98.16, -146.35, -155.97}, {-29.14, -10.62, 0}, "molotov", "site", "Run+Throw", 22},
    {"de_train", {-337.395263671875, 306.5303955078125, -151.96875}, {-29.86281967163086, -36.48215103149414, 0}, "molotov", "site", "Run+Throw", 22},
    {"de_train", {89.01020812988281, 418.96875, -151.96875}, {-31.59599494934082, -50.71765899658203, 0}, "molotov", "heaven", "Throw", 0},
    {"de_train", {869.979736328125, -271.7411804199219, -151.96875}, {-22.132932662963867, 150.2006072998047, 0}, "molotov", "mein ", "Run+Throw", 19},
    {"de_train", {1294.4680175781, 400.02404785156, -151.96875}, {-9.8842000961304, 175.49682617188, 0}, "molotov", "fiveseven-spot", "Throw", 0},
    {"de_train", {-648.96697998047, 615.21185302734, -151.96875}, {0.20607188344002, -30.658504486084, 0}, "molotov", "A-site", "Jump+Throw", 0},
    {"de_train", {1180.5014648438, -196.05508422852, -151.96875}, {-32.183605194092, -167.6908416748, 0}, "molotov", "Sniper-Nest", "Throw", 0},
    {"de_train", {170.15757751464844, 470.3016357421875, -151.90618896484375}, {-36.68, -70.6205062866211, 0}, "molotov", "hae-site", "Run+Throw", 0},
    {"de_train", {1262.4796142578125, 1029.0819091796875, -159.90618896484375}, {-3.794797897338867, -66.76533508300781, 0}, "molotov", "One-way", "Run+Throw", 35},
    {"de_train", {1248.0311279296875, 856.9890747070312, -159.90618896484375}, {-4.509838104248047, -50.735443115234375, 0}, "molotov", "One-way", "Run+Throw", 10},
    {"de_train", {576.4512329101562, 731.98095703125, -147.96875}, {-45.705020904541016, -44.76034927368164, 0}, "molotov", "site peek", "Run+Throw", 7},
    {"de_train", {688.3097534179688, 731.9714965820312, -147.96875}, {-47.74012756347656, -56.260772705078125, 0}, "molotov", "site", "Run+Throw", 15},
    {"de_train", {1257.0516357421875, 508.098876953125, -155.96875}, {-16.115062713623047, -158.59100341796875, 0}, "molotov", "site", "Run+Throw", 5},
    {"de_train", {751.7616577148438, 54.0520133972168, -66.11911010742188}, {22.385005950927734, -161.5861053466797, 0}, "molotov", "site parralel", "Jump+Throw", 0},
    {"de_train", {375.10772705078125, -78.9344482421875, -70.05873107910156}, {20.845001220703125, 19.80341148376465, 0}, "molotov", "site parralel", "Jump+Throw", 0},
    {"de_train", {1068.968505859375, 573.0103759765625, -151.96875}, {-27.33500099182129, -118.16236114501953, 0}, "molotov", "Sniper nest", "Run+Throw", 5},
    {"de_train", {-406.1392822265625, 393.33056640625, -151.96875}, {-28.98451042175293, -32.039833068847656, 0}, "molotov", "heaven", "Run+Throw", 7},
    {"de_train", {-278.4272155761719, 89.1151351928711, -151.96875}, {-26.28946304321289, -21.58980941772461, 0}, "molotov", "heaven", "Run+Throw", 1},
    {"de_train", {-346.7936706542969, 45.328765869140625, -151.96875}, {-14.794461250305176, -0.6348090171813965, 0}, "molotov", "site", "Throw", 0},
    {"de_train", {-315.5035095214844, 47.997982025146484, -151.96875}, {-21.88947296142578, 2.060190439224243, 0}, "molotov", "site back", "Run+Throw", 5},
    {"de_train", {-479.96875, 670.9773559570312, -151.96875}, {-4.399404525756836, -30.829843521118164, 0}, "molotov", "site", "Jump+Throw", 0},
    {"de_train", {-647.96875, -416.84796142578125, -151.96875}, {-14.629300117492676, 25.041597366333008, 0}, "molotov", "fiveseven spot", "Run+Throw", 5},
    {"de_train", {-647.9734497070312, -396.8062744140625, -151.96875}, {-17.544336318969727, 19.925994873046875, 0}, "molotov", "site", "Run+Throw", 5},
    {"de_train", {1480.82080078125, -858.7484130859375, -255.96875}, {-22.659631729125977, -166.228515625, 0}, "molotov", "site", "Run+Throw", 24},
    {"de_train", {-1069.27392578125, -958.5025634765625, 8.03125}, {-5.820511341094971, -11.896439552307129, 0}, "molotov", "site", "Throw", 0},
    {"de_train", {768.14, 731.06, -147.97}, {-1.74, -90.79, 0}, "molotov", "Heaven", "Jump+Throw", 1},
    {"de_train", {538.37, -553.87, -160.12}, {5.87, 98.59, 0}, "molotov", "Heaven", "Run+Jump+Throw", 1},
    {"de_train", {-193.87, 678.52, -151.97}, {-5.49, -48.59, 0}, "molotov", "Heaven", "Jump+Throw", 1},
    {"de_mirage", {-693.7974853515625, 556.2852783203125, -19.687843322753906}, {-60.46517562866211, -99.08094787597656, 0}, "molotov", "Short", "Throw", 1},
    {"de_mirage", {1158.568603515625, 282.9714660644531, -186.31707763671875}, {0.1555109024047852, 135.70457458496094, 0}, "molotov", "Onshot spot", "Run+Jump+Throw", 45},
    {"de_mirage", {-1020.7056884765625, 314.19940185546875, -321.96875}, {-4.811652183532715, 22.65178680419922, 0}, "molotov", "Fakeduck (Ctrl)", "Jump+Throw", 1},
    {"de_mirage", {-1563.8817138671875, 221.76905822753906, -104.12745666503906}, {-21.324501037597656, 150.4175262451172, 0}, "molotov", "Car", "Throw", 1},
    {"de_mirage", {-2173.391357421875, 236.70388793945312, -95.96875}, {-13.937911987304688, 125.8508071899414, 0}, "molotov", "Car", "Throw", 1},
    {"de_mirage", {-1045.7613525390625, 508.0062255859375, -15.96875}, {-14.872919082641602, 27.208328247070312, 0}, "molotov", "Fakeduck", "Throw", 1},
    {"de_mirage", {-1121.2449951171875, -1310.456298828125, -106.54885864257812}, {-18.229463577270508, -43.727142333984375, 0}, "molotov", "One-way site", "Throw", 0},
    {"de_mirage", {1148.4251708984375, 457.6883239746094, -199.9276123046875}, {-18.067354202270508, -84.90458679199219, 0}, "molotov", "Palace A", "Run+Throw", 33},
    {"de_mirage", {660.7953491210938, -1128.0538330078125, -63.96875}, {0.714964747428894, -136.20022583007812, 0}, "molotov", "Box 1-Way 2", "Jump+Throw", 0},
    {"de_mirage", {-1943.2867431640625, 765.7467041015625, 16.03125}, {-1.156121921539307, -89.85923767089844, 0}, "molotov", "Kitchen", "Run+Throw", 1},
    {"de_mirage", {-2152.4736328125, 788.3026733398438, -63.96875}, {-14.831171989440918, -6.505409240722656, 0}, "molotov", "Ups B", "Throw", 0},
    {"de_mirage", {-988.4798583984375, -463.10052490234375, -240.414794921875}, {-32.62140655517578, -116.92143249511719, 0}, "molotov", "A To B", "Half throw", 0},
    {"de_mirage", {-1004.96, 18.84, -303.97}, {-26.09, 115.39, 0}, "molotov", "Short", "Throw", 0},
    {"de_mirage", {-1177.5926513671875, -1174.515380859375, -103.96875}, {-2.802222967147827, 82.6501693725586, 0}, "molotov", "Under window", "Run+Throw", 1},
    {"de_mirage", {-921.87, -482.21, 15.91}, {-17.39, -155.61, 0}, "molotov", "Fakeduck", "Throw", 0},
    {"de_mirage", {497.6351318359375, -1570.1383056640625, -196.78262329101562}, {-25.29862403869629, 178.2367401123047, 0}, "molotov", "Stairs", "Throw", 0},
    {"de_mirage", {-543.8424682617188, -1309.03125, -95.96875}, {-11.039438247680664, -74.42620086669922, 0}, "molotov", "One-way site", "Throw", 0},
    {"de_mirage", {-1119.972412109375, -1526.9805908203125, -92.08175659179688}, {-17.373607635498047, 0.02280529960989952, 0}, "molotov", "Ramp", "Throw", 0},
    {"de_mirage", {-1180.7381591796875, 679.6217651367188, -15.96875}, {-9.351309776306152, 174.55308532714844, 0}, "molotov", "Car", "Throw", 0},
    {"de_mirage", {-36.230712890625, 821.3238525390625, -71.96875}, {-8.639360427856445, -150.7427215576172, 0}, "molotov", "Under", "Run+Throw", 5},
    {"de_mirage", {-1044.3841552734375, -2518.940185546875, -103.96875}, {-12.823919296264648, 38.4881477355957, 0}, "molotov", "Rush a", "Run+Throw", 5},
    {"de_mirage", {-1017.2653198242188, -276.7893371582031, -303.96875}, {-27.152263641357422, -102.46926879882812, 0}, "molotov", "Secret", "Throw", 0},
    {"de_mirage", {-813.2587280273438, -1342.4200439453125, -103.96875}, {-25.164628982543945, -92.21912384033203, 0}, "molotov", "Boost", "Throw", 0},
    {"de_mirage", {-821.17, -684.64, -205.67}, {-15.46, -49.4, 0}, "molotov", "One-way", "Run+Throw", 16},
    {"de_mirage", {-517.51, -1433.03, -36.35}, {-1.62, -71.12, 0}, "molotov", "Fakeduck (Ctrl)", "Throw", 15},
    {"de_mirage", {-1688.51, -668.03, -103.97}, {-7.07, 122.44, 0}, "molotov", "B plant", "Run+Throw", 12},
    {"de_mirage", {-824.93, 352.03, -267.26}, {-45.34, 107.97, 0}, "molotov", "Push", "Throw", 12},
    {"de_mirage", {-1132, 657.84, -15.97}, {-2.57, -23.21, 0}, "molotov", "One-way", "Run+Throw", 23},
    {"de_mirage", {-1512.7239990234375, -2347.41748046875, -180.6666259765625}, {-10.286823272705078, 1.1564241647720337, 0}, "molotov", "A Plant", "Run+Throw", 22},
    {"de_mirage", {362.7731018066406, -1711.981689453125, -129.35638427734375}, {-12.263968467712402, 123.63943481445312, 0}, "molotov", "Fakeduck", "Run+Throw", 26},
    {"de_mirage", {637.1300048828125, -1442.285888671875, -199.96875}, {-11.592479705810547, -131.1429901123047, 0}, "molotov", " Near pit", "Run+Throw", 10},
    {"de_mirage", {-25.793062210083008, -1891.432861328125, 24.96875}, {2.6190600395202637, 71.7715835571289, 0}, "molotov", "One-way ramp", "Run+Jump+Throw", 0},
    {"de_mirage", {18.04, -2226.97, 24.03}, {-3.5, 14.1, 0}, "molotov", "A box", "Run+Throw", 10},
    {"de_mirage", {942.4389038085938, -1240.2662353515625, -44.96875}, {-18.37839698791504, -165.95553588867188, 0}, "molotov", "Stairs", "Run+Throw", 0},
    {"de_mirage", {-1037.25390625, -155.898681640625, -303.96875}, {-10.188270568847656, -76.55209350585938, 0}, "molotov", "Short", "Run+Throw", 18},
    {"de_mirage", {351.62335205078125, -141.22793579101562, -101.96875}, {-16.597803115844727, -152.40158081054688, 0}, "molotov", "Window", "Run+Throw", 28},
    {"de_mirage", {-401.9287109375, -1587.27294921875, 24.03125}, {-17.93248748779297, 2.9161977767944336, 0}, "molotov", "Ramp One-way", "Throw", 0},
    {"de_mirage", {-1020.6661376953125, -341.7388916015625, -301.097900390625}, {-22.474211502075196, -102.71636199951172, 0}, "molotov", "Up ladder", "Run+Jump+Throw", 0},
    {"de_mirage", {-1177.55, 216.4, -106.44}, {-12.65, 150.63, 0}, "molotov", "Car", "Run+Throw", 8},
    {"de_mirage", {-38.82, -1554.13, -103.97}, {-37.32, 164.18, 0}, "molotov", "Stairs", "Throw", 8},
    {"de_mirage", {-30.73310661315918, 771.1280517578125, -71.96875}, {-25.506772994995117, -172.29470825195312, 0}, "molotov", "One-way", "Throw", 1},
    {"de_mirage", {-552.7010498046875, 353.0328063964844, -133.77085876464844}, {-21.332910537719727, 47.070621490478516, 0}, "molotov", "Push", "Throw", 1},
    {"de_mirage", {16.54195785522461, -1746.114501953125, -103.96875}, {-17.274980545043945, 158.73365783691406, 0}, "molotov", "Jungle", "Run+Throw", -4},
    {"de_mirage", {-666.8212890625, -962.607421875, -151.96875}, {-29.4, 71.57565307617188, 0}, "molotov", "Chair", "Run+Throw", 25},
    {"de_mirage", {-784.009033203125, -736.09716796875, -200.07284545898438}, {-21.142772674560547, -46.71687698364258, 0}, "molotov", "Fakeduck", "Throw", 1},
    {"de_mirage", {-1359.4407958984375, 318.7206115722656, -103.96875}, {-21.374574661254883, 140.3015899658203, 0}, "molotov", "Plant", "Throw", 1},
    {"de_mirage", {-2067.44970703125, -516.6715698242188, -103.96875}, {-10.954521656036377, 53.701255798339844, 0}, "molotov", "Left Plant", "Run+Throw", 17},
    {"de_mirage", {327.7995300292969, 232.4734344482422, -198.32464599609375}, {-9.896465301513672, 51.033721923828125, 0}, "molotov", "Stairs", "Throw", 1},
    {"de_mirage", {-475.64129638671875, -1759.2484130859375, -111.99240112304688}, {-8.490743160247803, 115.3733139038086, 0}, "molotov", "Fakeduck", "Throw", 1},
    {"de_mirage", {-709.6861572265625, -1250.7174072265625, -103.96875}, {-20.562904357910156, -51.9279670715332, 0}, "molotov", "Palace", "Run+Throw", 8},
    {"de_mirage", {-1168.4720458984375, -828.07861328125, -103.96875}, {5.8858113288879395, -134.01956176757812, 0}, "molotov", "Right Fakeduck", "Throw", 1},
    {"de_mirage", {87.81536865234375, -2170.2021484375, 28.03125}, {-5.83894681930542, -177.85362243652344, 0}, "molotov", "One-way", "Throw", 1},
    {"de_mirage", {-521.0642700195312, -652.4973754882812, -209.87774658203125}, {-15.719079971313477, -118.91386413574219, 0}, "molotov", "One-way", "Throw", 1},
    {"de_mirage", {-512.8159790039062, -702.5648193359375, -203.21414184570312}, {-11.777090072631836, -137.81825256347656, 0}, "molotov", "Box Fakeduck", "Throw", 1},
    {"de_mirage", {-850.1651000976562, -187.16909790039062, -104.1795654296875}, {-16.414674758911133, -36.14527893066406, 0}, "molotov", "Rip ESP Box", "Run+Throw", 8},
    {"de_mirage", {1237.33349609375, -1471.9530029296875, -103.96875}, {-20.588510513305664, 66.1076431274414, 0}, "molotov", "Fakeduck", "Throw", 1},
    {"de_aztec", {-687.3937, -790.2736, -312.3039}, {-20.45292, 113.4226, 0}, "molotov", "here Stone", "Run+Throw", 4},
    {"de_aztec", {226.29455566406, -490.97604370117, -160.30386352539}, {-16.746335983276, -131.89080810547, 0}, "molotov", "Door-Fakelag-off", "Run+Throw", 25},
    {"de_aztec", {-701.8319702148438, -327.07470703125, -159.96875}, {-9.834869, 162.928897, 0}, "molotov", "Stone", "Run+Throw", 19},
    {"de_aztec", {-921.8599, -619.3037, -287.097}, {-30.81156, 99.24021, 0}, "molotov", "Courtyard Stone", "Throw", 0},
    {"de_aztec", {-431.9633, -592.4977, -469.6862}, {-38.78868, -88.07673, 0}, "molotov", "here gen", "Throw", 0},
    {"de_aztec", {-714.9734, -486.3677, -440.7693}, {-31.66595, -71.80219, 0}, "molotov", "here gen2", "Run+Throw", 5},
    {"de_aztec", {271.4703, -633.5151, -159.9688}, {-26.70402, -123.5265, 0}, "molotov", "here gen box", "Throw", 0},
    {"de_aztec_HT", {-687.3937, -790.2736, -312.3039}, {-20.45292, 113.4226, 0}, "molotov", "here Stone", "Run+Throw", 4},
    {"de_aztec_HT", {226.29455566406, -490.97604370117, -160.30386352539}, {-16.746335983276, -131.89080810547, 0}, "molotov", "Door-Fakelag-off", "Run+Throw", 25},
    {"de_aztec_HT", {-701.8319702148438, -327.07470703125, -159.96875}, {-9.834869, 162.928897, 0}, "molotov", "Stone", "Run+Throw", 19},
    {"de_aztec_HT", {-921.8599, -619.3037, -287.097}, {-30.81156, 99.24021, 0}, "molotov", "Courtyard Stone", "Throw", 0},
    {"de_aztec_HT", {-431.9633, -592.4977, -469.6862}, {-38.78868, -88.07673, 0}, "molotov", "here gen", "Throw", 0},
    {"de_aztec_HT", {-714.9734, -486.3677, -440.7693}, {-31.66595, -71.80219, 0}, "molotov", "here gen2", "Run+Throw", 5},
    {"de_aztec_HT", {271.4703, -633.5151, -159.9688}, {-26.70402, -123.5265, 0}, "molotov", "here gen box", "Throw", 0},
    {"de_vertigo", {-2499.424316, 198.583847, 11808.03125}, {-25.92325, 13.955859, 0}, "molotov", "Fakeduck", "Run+Throw", 1},
    {"de_vertigo", {-1103.9910888671875, -1199.6715087890625, 11840.03125}, {-18.987712860107422, 37.351383209228516, 0}, "molotov", "Fakeduck Plant", "Throw", 1},
    {"de_vertigo", {-1129.093505859375, -1149.8385009765625, 11840.03125}, {-23.6352481842041, 33.55615997314453, 0}, "molotov", "Fakeduck A", "Throw", 1},
    {"de_vertigo", {-920.7857666015625, -859.4613647460938, 11712.03125}, {-61.772682189941406, 158.11988830566406, 0}, "molotov", "Fakeduck", "Throw", 1},
    {"de_vertigo", {-2275.249, -16.98516, 11616.03}, {-5.800075, 114.0871, 0}, "molotov", "Box", "Jump+Throw", 1},
    {"de_vertigo", {-2197.573486328125, -246.98292541503906, 11680.03125}, {-23.90870475769043, 98.81021118164062, 0}, "molotov", "Big box", "Throw", 1},
    {"de_vertigo", {-2003.7171630859375, 86.54362487792969, 11616.03125}, {-20.28949737548828, 172.20169067382812, 0}, "molotov", "Fakeduck", "Throw", 1},
    {"de_vertigo", {-1834.6168212891, -180.30085754395, 11840.637695313}, {-15.746797561646, 59.094627380371, 0}, "molotov", "Fakeduck", "Throw", 0},
    {"de_vertigo", {-1433.408203125, 972.87274169922, 11840.637695313}, {-8.855263710022, -134.87399291992, 0}, "molotov", "Back of B", "Run+Throw", 35},
    {"de_vertigo", {-1380.7994384766, 963.830078125, 11840.637695313}, {-20.658113479614, -145.78451538086, 0}, "molotov", "Boxes left", "Run+Throw", 7},
    {"de_vertigo", {-2032.29833984375, -578.7349243164062, 11840.03125}, {-22.08106803894043, 62.26222610473633, 0}, "molotov", "Fakeduck", "Throw", 0},
    {"de_vertigo", {-2238.3466796875, -129.43667602539062, 11664.2529296875}, {-32.043540954589844, 85.63555908203125, 0}, "molotov", "One-way", "Throw", 0},
    {"de_vertigo", {-2176.254638671875, -89.63109588623047, 11644.3505859375}, {-19.465839385986328, 119.63224029541016, 0}, "molotov", "One-way", "Throw", 0},
    {"de_vertigo", {-861.5975952148438, 608.5064086914062, 11937.03125}, {-7.697720050811768, 178.1377716064453, 0}, "molotov", "doublebox One-way", "Run+Throw", 1},
    {"de_vertigo", {-942.3855590820312, 612.1253662109375, 11937.03125}, {-11.476728057861328, 165.9965362548828, 0}, "molotov", "Plant One-way", "Throw", 0},
    {"de_vertigo", {-906.01318359375, 880.4174194335938, 11840.03125}, {3.299903154373169, -178.98963928222656, 0}, "molotov", "One-way Fakeduck", "Jump+Throw", 0},
    {"de_vertigo", {-883.3912353515625, 909.4985961914062, 11840.03125}, {-20.680198669433594, -173.6763916015625, 0}, "molotov", "rip esp", "Throw", 0},
    {"de_vertigo", {-1318.0853271484375, 925.5330200195312, 11840.03125}, {-19.140216827392578, -151.266845703125, 0}, "molotov", "One-way box", "Run+Throw", 2},
    {"de_vertigo", {-690.03125, 749.7133178710938, 11840.03125}, {-21.94536781311035, -177.77491760253906, 0}, "molotov", "One-way box", "Run+Throw", 3},
    {"de_vertigo", {-1736.9305419921875, 19.96878433227539, 11840.03125}, {-16.280818939208984, 143.52105712890625, 0}, "molotov", "Help", "Throw", 0},
    {"de_vertigo", {-1872.680419921875, -293.5762023925781, 11863.03125}, {-17.578643798828125, 107.56988525390625, 0}, "molotov", "Plant", "Throw", 0},
    {"de_vertigo", {-1394.7640380859375, 505.41705322265625, 11937.53125}, {-7.476424217224121, 144.80140686035156, 0}, "molotov", "One-way", "Throw", 0},
    {"de_vertigo", {-1394.0198974609375, 436.88507080078125, 11908.7626953125}, {-13.587570190429688, 131.32247924804688, 0}, "molotov", "boxes", "Run+Throw", 15},
    {"de_vertigo", {-2045.626953125, 20.763994216918945, 11932.03125}, {-4.454883575439453, 93.34927368164062, 0}, "molotov", "One-way", "Throw", 0},
    {"de_vertigo", {-1645.826171875, -237.026611328125, 11840.03125}, {-19.638751983642578, 125.47172546386719, 0}, "molotov", "Help", "Throw", 0},
    {"de_vertigo", {-2228.63623046875, -53.98468017578125, 11626.51953125}, {-42.35946273803711, 119.77262878417969, 0}, "molotov", "Boxes", "Run+Throw", 5},
    {"de_vertigo", {-603.66, -1305.6, 11729.47}, {-12.52, 50.59, 0}, "molotov", "Site/Box", "Run+Throw", 5},
    {"de_vertigo", {-721.0631103515625, -1510.9549560546875, 11840.03125}, {-15.390941619873047, 67.38682556152344, 0}, "molotov", "Site/Box", "Throw", 1},
    {"de_vertigo", {-642.6594848632812, -218.68661499023438, 11840.03125}, {-2.2028162479400635, -34.08245849609375, 0}, "molotov", "Site/Box", "Run+Throw", 15},
    {"de_vertigo", {-599.8272705078125, -272.8127746582031, 11840.03125}, {-6.171840171813965, -145.65429931640625, 0}, "molotov", "Site/Box", "Run+Jump+Throw", 1},
    {"de_vertigo", {-756.033935546875, -1373.169921875, 11840.03125}, {-23.419721603393555, 56.30609130859375, 0}, "molotov", "Right box", "Throw", 1},
    {"de_vertigo", {-2172.8388671875, 341.4638366699219, 11840.03125}, {-40.38908386230469, 74.04590606689453, 0}, "molotov", "Plant", "Throw", 1},
    {"de_vertigo", {-1699.87744140625, 733.7057495117188, 11840.03125}, {-11.92576789855957, -154.3043212890625, 0}, "molotov", "Box", "Throw", 1},
    {"de_vertigo", {-1726.212890625, 745.75830078125, 11840.03125}, {-29.664573669433594, 136.47911071777344, 0}, "molotov", "Right box", "Throw", 1},
    {"de_vertigo", {-679.866455078125, -880.7555541992188, 11680.212890625}, {-41.98105239868164, 166.39613342285156, 0}, "molotov", "One-way", "Throw", 1},
    {"de_bank", {-346.9277038574219, -792.7151489257812, 252.03125}, {-5.524115562438965, 32.12298583984375, 0}, "molotov", "Left Car", "Run+Throw", 5},
    {"de_bank", {598.5147705078125, -1510.0496826171875, 37.965576171875}, {-16.8439998626709, 51.15850067138672, 0}, "molotov", "FBI Car", "Run+Throw", 1},
    {"de_bank", {277.0028076171875, 881.566650390625, 38.356143951416016}, {3.1394081115722656, -62.233131408691406, 0}, "molotov", "Car", "Jump+Throw", 1},
    {"de_bank", {1168.05810546875, 194.44639587402344, 32.69050598144531}, {-11.722753524780273, -163.23936462402344, 0}, "molotov", "Plant", "Run+Throw", 22},
    {"de_bank", {74.84297943115234, -977.2576904296875, 22.03125}, {-16.477994918823242, 36.598533630371094, 0}, "molotov", "Car", "Throw", 0},
    {"de_bank", {277.0028076171875, 881.566650390625, 38.356143951416016}, {3.1394081115722656, -62.233131408691406, 0}, "molotov", "Car", "Jump+Throw", 0},
    {"de_bank", {995.7448120117188, -436.04388427734375, 36.75340270996094}, {-21.986146926879883, 174.04270935058594, 0}, "molotov", "Up", "Run+Throw", 10},
    {"de_bank", {1112.8892822265625, -286.76483154296875, 36.92109680175781}, {-10.756773948669434, 179.4832763671875, 0}, "molotov", "Plant", "Run+Throw", 22},
    {"de_bank", {-261.69, -902.47, 252.03}, {1.19, 23.28, 0}, "molotov", "Car", "Run+Throw", 0},
    {"de_bank", {-551.46, -245.79, 212.21}, {-1.4, -3.51, 0}, "molotov", "Car", "Run+Throw", 13},
    {"de_bank", {-500.65, -396.25, 252.21}, {-1.43, 2.26, 0}, "molotov", "Car", "Run+Throw", 1},
    {"de_bank", {-520.72, -584.29, 252.21}, {9.01, 2.08, 0}, "molotov", "FBI Car", "Run+Jump+Throw", 101},
    {"de_bank", {-124.02, -777.67, 252.03}, {-7.32, -9.79, 0}, "molotov", "Trash", "Run+Throw", 22},
    {"de_bank", {628.84, -335.07, 34.45}, {6.91, -34.84, 0}, "molotov", "Trash", "Run+Jump+Throw", 2},
    {"de_bank", {135.03, 962.44, 37.51}, {1.95, -45.67, 0}, "molotov", "FBI Car", "Run+Jump+Throw", 22},
    {"de_bank", {1196.36, -1959.98, 78.14}, {-14.98, 47.08, 0}, "molotov", "Trash", "Throw", 22},
    {"de_bank", {-314.03, -646.42, 252.03}, {-6.81, 10.55, 0}, "molotov", "Car", "Throw", 1},
    {"de_bank", {1464, -1760.03, 77.05}, {-16.04, 87.57, 0}, "molotov", "FBI Car", "Throw", 22},
    {"de_bank", {355.9413146972656, -1841.24560546875, 34.018917083740234}, {-20.64751625061035, 27.488651275634766, 0}, "molotov", "Trash", "Run+Throw", 10},
    {"de_bank", {-650.1, -281.32, 207.09}, {-8.62, 10.27, 0}, "molotov", "Left Car", "Run+Throw", 7},
    {"de_bank", {-486.15, -672.81, 252.03}, {-6.42, 28.27, 0}, "molotov", "Left Car", "Run+Throw", 3},
    {"de_bank", {1225.23, -369.31, 37.03}, {-16.81, -87.14, 0}, "molotov", "FBI Car", "Throw", 22},
    {"de_bank", {620.12, -269.31, 16.28}, {-16.23, -14.21, 0}, "molotov", "FBI Car", "Throw", 22},
    {"de_bank", {37.374549865722656, -849.1690673828125, 303.03125}, {14.260663986206055, 21.467700958251953, 0}, "molotov", "FBI Car", "Jump+Throw", 22},
    {"de_bank", {-239.20236206054688, -31.951797485351562, 34.04359436035156}, {-19.014131546020508, 38.98760986328125, 0}, "molotov", "Truck", "Throw", 1},
    {"de_bank", {-551.97998046875, -213.84259033203125, 211.43389892578125}, {-14.244617462158203, -8.159796714782715, 0}, "molotov", "FBI Car", "Run+Throw", 25},
    {"de_bank", {-459.2567138671875, -244.92599487304688, 207.03125}, {-14.376518249511719, 46.40787124633789, 0}, "molotov", "Truck", "Throw", 1},
    {"de_tulip", {5584.031, 5028.294, 48.03125}, {-19.29864, -90.35034, 0}, "molotov", "Fish", "Throw", 1},
    {"de_tulip", {6283.4453125, 4458.3481445313, -56.88412475586}, {3.2317614555359, -135.34457397461, 0}, "molotov", "Boost", "Run+Jump+Throw", 22},
    {"de_tulip", {6249.771484375, 3081.824951171875, -63.96875}, {-20.02602195739746, -136.83094482421876, 0}, "molotov", "Fountain", "Run+Throw", 5},
    {"de_tulip", {6050.414, 2933.359, -0.96875}, {9.878396, -135.0642, 0}, "molotov", "Fountain", "Run+Jump+Throw", 6},
    {"de_tulip", {6283.4453125, 4458.3481445313, -56.48412475586}, {3.2317614555359, -135.34457397461, 0}, "molotov", "Boost", "Run+Jump+Throw", 22},
    {"de_tulip", {5893.810546875, 2735.4509277344, 0.46875}, {-3.670895195007, 126.01389648438, 0}, "molotov", "boost", "Throw", 0},
    {"de_tulip", {6050.4140625, 2933.3586425781, 0.46875}, {9.8783960342407, -135.06419372559, 0}, "molotov", "car", "Run+Jump+Throw", 0},
    {"de_tulip", {6249.771484375, 3081.824951171875, -63.96875}, {-20.02602195739746, -136.83094482421876, 0}, "molotov", "Fountain", "Run+Throw", 5},
    {"de_tulip", {6096.97265625, 2913.6115722656, 0.46875}, {0.94903161525726, -135.95407104492, 0}, "molotov", "Fakeduck", "Run+Jump+Throw", 0},
    {"de_tulip", {6874.513672, 2407.673584, 0.46875}, {9.8890829086304, 175.40585327148, 0}, "molotov", "Fakeduck", "Run+Jump+Throw", 0},
    {"de_tulip", {5702.73, 3317.66, 0.03}, {-21.68, 151.19, 0}, "molotov", "Fakeduck", "Throw", 22},
    {"de_tulip_HT", {6283.4453125, 4458.3481445313, -56.48412475586}, {3.2317614555359, -135.34457397461, 0}, "molotov", "Boost", "Run+Jump+Throw", 22},
    {"de_tulip_HT", {5893.810546875, 2735.4509277344, 0.46875}, {-3.670895195007, 126.01389648438, 0}, "molotov", "boost", "Throw", 0},
    {"de_tulip_HT", {6050.4140625, 2933.3586425781, 0.46875}, {9.8783960342407, -135.06419372559, 0}, "molotov", "car", "Run+Jump+Throw", 0},
    {"de_tulip_HT", {6249.771484375, 3081.824951171875, -63.96875}, {-20.02602195739746, -136.83094482421876, 0}, "molotov", "Fountain", "Run+Throw", 5},
    {"de_tulip_HT", {6096.97265625, 2913.6115722656, 0.46875}, {0.94903161525726, -135.95407104492, 0}, "molotov", "Fakeduck", "Run+Jump+Throw", 0},
    {"de_tulip_HT", {6874.513672, 2407.673584, 0.46875}, {9.8890829086304, 175.40585327148, 0}, "molotov", "Fakeduck", "Run+Jump+Throw", 0},
    {"cs_agency", {-1124.0197753906, -258.64184570313, 576.03125}, {-10.705142021179, 59.04243850708, 0}, "molotov", "Table", "Run+Throw", 1},
    {"cs_agency", {-879.290222, -257.425018, 601.870605}, {-3.9801921844482, 103.2504196167, 0}, "molotov", "Utility room", "Run+Throw", 1},
    {"cs_agency", {-1190.766602, 194.278305, 384.03125}, {-28.321235656738, 82.861663818359, 0}, "molotov", "Far corridor", "Run+Throw", 1},
    {"cs_agency", {-897.191, -254.848, 613.2833}, {-3.980192, 103.2504, 0}, "molotov", "Office Utility[1]", "Run+Throw", 1},
    {"cs_agency", {-1194.072, 251.3711, 383.0313}, {-32.32124, 82.86166, 0}, "molotov", "Main Hall FCorridor[2]", "Run+Throw", 1},
    {"cs_agency", {-956.8182, 240.0701, 383.0313}, {-28.48137, 47.25394, 0}, "molotov", "Main Hall Front_Hall[1]", "Run+Throw", 3},
    {"cs_agency", {-879.2902, -257.425, 601.8706}, {-3.980192, 103.2504, 0}, "molotov", "here Utility[2]", "Run+Throw", 1},
    {"cs_office", {983.9835205078125, -331.8383483886719, -95.96875}, {-7.202581882476807, -149.14889526367188, 0}, "molotov", "Fakeduck", "Throw", 1},
    {"cs_office", {-497.5635681152344, -538.58984375, -202.99795532226562}, {-18.72443962097168, 7.40939474105835, 0}, "molotov", "Boxes", "Throw", 0},
    {"cs_office", {1177.619140625, -903.1005859375, -95.96875}, {3.5127573013305664, 141.0026092529297, 0}, "molotov", "One-way", "Throw", 1},
    {"cs_office", {1013.5485229492, -667.89953613281, -95.96875}, {-4.2577028274536, 97.964347839355, 0}, "molotov", "Trash", "Run+Throw", 32},
    {"cs_office", {1044.3316650391, 1039.96484375, -95.96875}, {-5.8989114761353, -13.769506454468, 0}, "molotov", "Sofa", "Throw", 0},
    {"cs_office", {949.54443359375, -254.63844299316406, -95.96875}, {-5.518391132354736, 40.15314483642578, 0}, "molotov", "Paper", "Run+Throw", 5},
    {"cs_office", {1708.98, 762.15, -95.97}, {1.23, 117.5, 0}, "molotov", "Long", "Throw", 5},
    {"cs_office", {1534.95, 922.02, -95.97}, {-5.38, -147.18, 0}, "molotov", "Sofa", "Run+Throw", 5},
    {"cs_office", {-103.35, -1084.66, -159.97}, {-12.54, 69.74, 0}, "molotov", "Barrels", "Run+Throw", 9},
    {"cs_office", {-832.45, -67.78, -303.97}, {-3.64, 43.53, 0}, "molotov", "Barrels", "Throw", 9},
    {"cs_office", {-17.43520164489746, -823.5162963867188, -151.96875}, {-14.316509246826172, 67.68290710449219, 0}, "molotov", "Barrels", "Throw", 1},
    {"cs_office", {787.82, -494.36, -95.97}, {-4.91, -49.45, 0}, "molotov", "Fakeduck", "Throw", 9},
    {"cs_office", {-840.97, 537.1, -303.97}, {-2.82, -33.22, 0}, "molotov", "Barrels", "Throw", 9},
    {"de_cache", {90.618309020996, 257.1057434082, 1677.09375}, {-29.98804473877, 124.62944030762, 0}, "molotov", "Fakeduck barrels", "Run+Throw", 21},
    {"de_cache", {806.5239868164062, -1246.503662109375, 1677.1964111328125}, {-23.699928283691406, 177.82098388671875, 0}, "molotov", "Fakeduck", "Throw", 0},
    {"de_cache", {-120.183487, 424.871674, 1677.09375}, {-24.213342, 4.959707, 0}, "molotov", "Boost down", "Throw", 0},
    {"de_cache", {-198.205246, 418.773346, 1677.09375}, {-24.513342, 5.459707, 0}, "molotov", "Boost up", "Throw", 0},
    {"de_cache", {-982.153381, 971.216309, 1739.83606}, {-18.033867, 41.925247, 0}, "molotov", "Squeaky", "Run+Throw", 11},
    {"de_cache", {605.2061157226562, -148.96875, 1756.1883544921875}, {-6.214809131622315, 135.8157196044922, 0}, "molotov", "White Box", "Throw", 0},
    {"de_cache", {4.893680572509766, -103.95784759521484, 1683.6702880859375}, {-28.058530807495117, 40.2496223449707, 0}, "molotov", "Boost", "Throw", 0},
    {"de_cache", {592.7044677734375, 515.6970825195312, 1677.03125}, {-18.722537994384766, -162.96670532226562, 0}, "molotov", "Rip ESP", "Run+Throw", 2},
    {"de_cache", {397.38348388671875, -327.3841857910156, 1678.03125}, {-10.7865083694458, -120.9734680175781, 0}, "molotov", "Fakeduck", "Run+Throw", 22},
    {"de_cache", {931.7955322265625, 612.8370361328125, 1885.9783935546875}, {-5.694046020507813, -163.06387329101562, 0}, "molotov", "Rip ESP", "Run+Throw", 8},
    {"de_cache", {57.78672409057617, 453.6738586425781, 1821.3572998046875}, {-19.456786422729493, 157.21087646484375, 0}, "molotov", "Car", "Throw", 0},
    {"de_cache", {1346.924, 958.7413, 1682.076}, {-1.003187, -135.7633, 0}, "molotov", "Long A", "Run+Jump+Throw", 11},
    {"de_cache", {65.04829, 280.8761, 1676.031}, {-24.31287, 123.8963, 0}, "molotov", "Middle Bombsite A (Fakeduck)", "Run+Throw", 14},
    {"de_cache", {-19.68075, 1914.706, 1751.031}, {-20.45679, -134.7262, 0}, "molotov", "Bombsite A Car", "Throw", 0},
    {"de_cache", {345.0677, 2149.559, 1752.031}, {-16.39992, -141.7267, 0}, "molotov", "Squeaky Car", "Run+Throw", 9},
    {"de_cache", {290.8178, 2100.353, 1752.031}, {-16.61995, -141.4516, 0}, "molotov", "Squeaky Box", "Throw", 1},
    {"de_cache", {360.4409, 2256.083, 1752.031}, {-6.826884, -121.3858, 0}, "molotov", "Squeaky A Ramp", "Run+Throw", 2},
    {"de_cache", {17.71885, 204.4575, 1677.031}, {-17.84531, 101.8341, 0}, "molotov", "Middle Bombsite A", "Run+Throw", 1},
    {"de_dust", {449.7195739746094, 828.2278442382812, 192.03125}, {-11.689563751220703, -11.68131160736084, 0}, "molotov", "Plant", "Run+Throw", 11},
    {"de_dust", {-757.6260375976562, 302.7524108886719, 96.03125}, {-20.982454299926758, -22.44451141357422, 0}, "molotov", "Box", "Throw", 0},
    {"de_dust", {483.620483, 870.224365, 191.03125}, {-14.982905, -91.878998, 0}, "molotov", "One-way", "Throw", 1},
    {"de_dust", {-885.1317, 953.9477, 99.03125}, {-15.12765, -38.53125, 0}, "molotov", "Barrels", "Throw", 1},
    {"de_dust", {1200.56, 1261.914, 96.03125}, {-12.62973, -26.63422, 0}, "molotov", "Fakeduck", "Run+Throw", 21},
    {"de_dust", {-906.5054, 979.5095, 98.03125}, {3.58836, -42.97837, 0}, "molotov", "Underpass CT-Fakeduck", "Run+Jump+Throw", 11},
    {"de_dust", {369.6191, -74.73279, 191.0313}, {8.399137, 18.47449, 0}, "molotov", "Back A Plant", "Run+Jump+Throw", 13},
    {"de_dust", {450.9553, 855.6304, 191.0313}, {-14.20162, -12.89362, 0}, "molotov", "Back Boxes-FL-OFF", "Run+Throw", 11},
    {"de_dust", {536.7808, 812.845, 191.0313}, {-41.13742, -93.49163, 0}, "molotov", "Back CT-Fakeduck", "Run+Throw", 1},
    {"de_dust", {686.9686889648438, 948.8836669921875, 96.03125}, {-24.881982803344727, -103.4276123046875, 0}, "molotov", "Box", "Throw", 1},
    {"de_dust", {301.23, 91.79, 71.81}, {-7.65, -163.59, 0}, "molotov", "Box", "Run+Throw", 1},
    {"de_dust", {-767.71, 232.45, 96.03}, {-23.51, -16.01, 0}, "molotov", "Box", "Throw", 1},
    {"de_nuke", {1112.7235107421875, -1040.381591796875, -703.96875}, {-4.346846580505371, 138.84170532226562, 0}, "molotov", "Fakeduck", "Run+Throw", 6},
    {"de_nuke", {669.3499755859375, -454.39459228515625, -657.0711059570312}, {-13.946136474609375, -19.27132797241211, 0}, "molotov", "Window", "Throw", 0},
    {"de_nuke", {423.6324462890625, 83.42068481445312, -575.96875}, {-3.743135929107666, -78.56092834472656, 0}, "molotov", "Doors", "Run+Throw", 12},
    {"de_nuke", {830.4251708984375, 95.98638916015625, -575.96875}, {-3.8035197257995605, -95.6500015258789, 0}, "molotov", "Plant", "Run+Throw", 5},
    {"de_nuke", {340.0143737792969, -1279.52587890625, -568.96875}, {6.339123725891113, 29.01650619506836, 0}, "molotov", "Doors", "Throw", 0},
    {"de_nuke", {704.1917724609375, -383.9068298339844, -625.6384887695312}, {8.271063804626465, -65.2789306640625, 0}, "molotov", "Doors", "Throw", 0},
    {"de_nuke", {1391.96875, -847.1563110351562, -671.39990234375}, {-11.772736549377441, 128.69210815429688, 0}, "molotov", "Unpush", "Throw", 0},
    {"de_nuke", {1421.437744140625, -1023.9622802734375, -703.96875}, {7.063614845275879, 114.44749450683594, 0}, "molotov", "Unpush", "Jump+Throw", 0},
    {"de_nuke", {1172.644775390625, -998.387939453125, -703.96875}, {-17.266681671142578, 44.596221923828125, 0}, "molotov", "Window", "Run+Throw", 1},
    {"de_nuke", {1154.814697265625, -1562.8680419921875, -351.96905517578125}, {4.467591285705566, -152.53076171875, 0}, "molotov", "Unpush", "Jump+Throw", 0},
    {"de_nuke", {1190.7249755859375, -1437.3753662109375, -351.96893310546875}, {-9.961530685424805, -115.03914642333984, 0}, "molotov", "Unpush", "Throw", 0},
    {"de_nuke", {1701.3985595703125, -1680.9354248046875, -351.96875}, {-3.1894125938415527, -144.9203643798828, 0}, "molotov", "Unpush", "Run+Throw", 5},
    {"de_nuke", {920.4970092773438, -1684.970947265625, -575.96875}, {-42.97067642211914, 88.98300170898438, 0}, "molotov", "Street", "Throw", 0},
    {"de_nuke", {778.8310546875, 57.4388427734375, -575.96875}, {-2.9582581520080566, -70.77649688720703, 0}, "molotov", "Window", "Run+Throw", 1},
    {"de_nuke", {1170.2197265625, -373.0448303222656, -575.96875}, {-1.44895601272583, -127.94245147705078, 0}, "molotov", "Plant", "Throw", 0},
    {"de_nuke", {704.4215087890625, -1684.9541015625, -575.96875}, {-41.57283020019531, 91.83717346191406, 0}, "molotov", "Up", "Throw", 0},
    {"de_nuke", {275.50244140625, 102.67391967773438, -351.96875}, {-26.729900360107422, -26.36233139038086, 0}, "molotov", "Nine", "Throw", 0},
    {"de_nuke", {1537.1435546875, -2435.978271484375, -495.96875}, {-25.054765701293945, 167.4576873779297, 0}, "molotov", "Street", "Run+Throw", 15},
    {"de_nuke", {749.9557495117188, 555.6788940429688, -426.6836242675781}, {-16.96478843688965, -135.30873107910156, 0}, "molotov", "Unpush", "Throw", 0},
    {"de_nuke", {1170.2578125, -552.0615234375, -575.96875}, {12.074569702148438, -47.52925109863281, 0}, "molotov", "Push doors", "Throw", 0},
    {"de_nuke", {408.6708984375, -72.99930572509766, -575.96875}, {-4.165727138519287, -33.579708099365234, 0}, "molotov", "Window", "Run+Throw", 1},
    {"de_nuke", {-278.1017761230469, -1946.4239501953125, -351.96875}, {-8.622940063476562, 0.03145921230316162, 0}, "molotov", "Garage", "Run+Throw", 15},
    {"de_nuke", {1290.805908203125, -592.1639404296875, -575.96875}, {-6.258520030975342, 149.50087890625, 0}, "molotov", "Ramp", "Run+Throw", 36},
    {"de_nuke", {-233.80966186523438, -1855.2774658203125, -351.96875}, {-13.58386516571045, -21.278404235839844, 0}, "molotov", "Down", "Run+Throw", 10},
    {"de_nuke", {365.55682373046875, -1279.7076416015625, -351.96875}, {-1.5697088241577148, -41.00993347167969, 0}, "molotov", "Street", "Run+Throw", 10},
    {"de_nuke", {1112.7235107421875, -1040.381591796875, -703.96875}, {-4.346846580505371, 138.84170532226562, 0}, "molotov", "Fakeduck", "Run+Throw", 6},
    {"de_nuke", {214.55079650878906, -150.10813903808594, -351.96875}, {-2.4148716926574707, 74.17098999023438, 0}, "molotov", "Down", "Run+Throw", 5},
    {"de_nuke", {1243.17333984375, -327.4957275390625, -63.96875}, {-4.407177925109863, -158.623291015625, 0}, "molotov", "Plant A", "Run+Throw", 1},
    {"de_nuke", {427.16314697265625, -801.5758056640625, -327.96875}, {-30.669401168823242, 33.358970642089844, 0}, "molotov", "Up", "Throw", 0},
    {"de_nuke", {-74.26110076904297, -896.716552734375, -27.96875}, {-15.696985244750977, 32.88661575317383, 0}, "molotov", "Plant up", "Throw", 0},
    {"de_nuke", {-136.034912109375, -1682.4996337890625, 19.64365005493164}, {6.339146614074707, -26.825654983520508, 0}, "molotov", "Down", "Run+Throw", 5},
    {"de_nuke", {-116.86628723144531, -1599.2562255859375, 22.578399658203125}, {2.173407793045044, -11.973926544189453, 0}, "molotov", "Garage", "Run+Throw", 1},
    {"de_nuke", {-172.30587768555, -1193.8751220703, -90.906189}, {0.6968215322495, 31.411325515747, 0}, "molotov", "Heaven", "Jump+Throw", 0},
    {"cs_italy", {-1026.6380615234375, 848.04248046875, -86.92919921875}, {-30.767988204956055, 56.64377975463867, 0}, "molotov", "door", "Throw", 1},
    {"cs_italy", {-292.3274230957031, 1978.3468017578125, 64.03125}, {-2.1315019130706787, -59.44070053100586, 0}, "molotov", "Box", "Throw", 1},
    {"cs_italy", {81.78328704833984, 2001.384765625, 64.03125}, {-2.6925160884857178, -116.10157775878906, 0}, "molotov", "Box", "Throw", 1},
    {"cs_italy", {-607.8867797851562, 1582.7076416015625, 56.03125}, {-18.724380493164062, -123.52500915527344, 0}, "molotov", "Boost", "Throw", 0},
    {"cs_italy", {-179.82374572753906, 2446.033203125, 108.03125}, {-13.91278076171875, -130.42408752441406, 0}, "molotov", "Push", "Throw", 2},
    {"cs_italy", {32.905662536621094, 2416.8134765625, 26.170696258544922}, {-20.05764389038086, -141.74081420898438, 0}, "molotov", "Push", "Throw", 2},
    {"cs_italy", {-33.21971893310547, 1187.2340087890625, -96.09356689453125}, {-20.637380599975586, 87.47865295410156, 0}, "molotov", "Fakeduck", "Run+Throw", 2},
    {"cs_italy", {-977.1937255859375, -985.0501708984375, -87.96875}, {-42.08626937866211, -89.54734802246094, 0}, "molotov", "Rip ESP", "Run+Jump+Throw", 22},
    {"cs_italy", {-26.13906478881836, 1246.0318603515625, -87.96875}, {-29.158992767333984, 112.97683715820312, 0}, "molotov", "Most", "Throw", 1},
    {"cs_italy", {-910.2120361328125, 1253.7633056640625, 72.06330871582031}, {-22.956024169921875, -94.54740905761719, 0}, "molotov", "Under Most", "Throw", 1},
    {"cs_italy", {-504.59613037109375, 1182.6982421875, 8.03}, {9.854912757873535, 114.59285736083984, 0}, "molotov", "Push", "Run+Jump+Throw", 19},
    {"cs_italy", {-1149.801025390625, -35.84446334838867, -87.96875}, {-29.564712524414062, 87.94178009033203, 0}, "molotov", "Boost", "Throw", 1},
    {"cs_italy", {-819.4080810546875, 1231.4410400390625, 64.09381103515625}, {-5.175500154495239, 63.53955764770508, 0}, "molotov", "Wine Cellar", "Run+Throw", 35},
    {"cs_italy", {-1519.96875, 417.61517333984375, 72.03125}, {4.70923900604248, 55.570396423339844, 0}, "molotov", "T spawn", "Run+Jump+Throw", 1},
    {"cs_italy", {855.8480834960938, 1609.6368408203125, 30.028339385986328}, {-4.243151664733887, 129.0799835205078, 0}, "molotov", "Fakeduck", "Run+Throw", 10},
    {"cs_italy", {-911.98, 1644.48, 72.62}, {-17.51, 43.11, 0}, "molotov", "Fakeduck", "Throw", 0},
    {"cs_italy", {183.69, 744.51, -99.1}, {7.61, -32.11, 0}, "molotov", "Trash", "Run+Jump+Throw", 1},
    {"cs_italy", {116.71, 660.02, -87.43}, {-17.49, 142.58, 0}, "molotov", "Boost", "Run+Jump+Throw", 15},
    {"cs_italy", {-608.34, 1998.58, 64.03}, {-18.12, -120.87, 0}, "molotov", "push", "Run+Throw", 15},
    {"cs_italy", {798.97, 499.41, -95.97}, {-16.37, -143.38, 0}, "molotov", "Trash", "Throw", 15},
    {"cs_italy", {150.69, -155.84, -87.97}, {12.98, 48.14, 0}, "molotov", "Trash", "Run+Jump+Throw", 1},
    {"cs_italy", {-108.16, -447.63, -87.97}, {-5.17, 149.94, 0}, "molotov", "Trash", "Throw", 1},
    {"cs_italy", {-505.26, 761.79, 72.03}, {-12.68, -148.71, 0}, "molotov", "Boost (Right)", "Throw", 1},
    {"cs_italy", {409.24, 848, -43.97}, {-27.89, -178.26, 0}, "molotov", "Boost", "Run+Throw", 4},
    {"de_stmarc", {-7432.7119140625, 6160.15380859375, 96.03125}, {-9.40779972076416, 148.60362243652344, 0}, "molotov", "Car", "Run+Throw", 5},
    {"de_stmarc", {-7012.4375, 7153.63330078125, 96.4420394897461}, {9.307753562927246, -164.7715301513672, 0}, "molotov", "Car", "Jump+Throw", 1},
    {"de_stmarc", {-6744.01220703125, 6986.52783203125, 95.34407806396484}, {-13.33202075958252, -171.40199279785156, 0}, "molotov", "Box", "Run+Throw", 5},
    {"de_stmarc", {-6500.384765625, 6932.28759765625, 94.30015563964844}, {-14.539483070373535, -178.58981323242188, 0}, "molotov", "Ice", "Run+Throw", 10},
    {"de_stmarc", {-6984.9501953125, 6454.2783203125, 96.61927795410156}, {-23.89728546142578, 151.62222290039062, 0}, "molotov", "Car", "Throw", 1},
    {"de_stmarc", {-7998.14892578125, 6865.51953125, 96.03125}, {-16.196417808532715, 1.1712183952331543, 0}, "molotov", "plant Fakeduck", "Throw", 0},
    {"de_stmarc", {-6841.109863, 6921.820801, 116.466354}, {-15.496530532836914, -176.56068420410156, 0}, "molotov", "car", "Throw", 0},
    {"de_stmarc", {-5934.5244140625, 7054.48291015625, 96.03125}, {-17.985076904296875, -175.65931701660156, 0}, "molotov", "car", "Run+Throw", 30},
    {"de_stmarc", {-8209.56640625, 6785.77294921875, 106.74014282226562}, {-16.665021896362305, 7.159177303314209, 0}, "molotov", "car2", "Run+Throw", 49},
    {"de_stmarc", {-7331.71, 7098.49, 98.03}, {-44.06, 3.38, 0}, "molotov", "Plant One-way", "Throw", 22},
    {"de_stmarc", {-7049.81, 6161.04, 97.88}, {-12.06, 109.35, 0}, "molotov", "Trash", "Run+Throw", 8},
    {"de_stmarc", {-6981.05, 6522.05, 102.03}, {-23, 158.98, 0}, "molotov", "Car", "Throw", 22},
    {"de_swamp", {1412.7794189453125, 1236.0802001953125, -129.96875}, {-9.495403289794922, -118.20913696289062, 0}, "molotov", "Fakeduck", "Jump+Throw", 0},
    {"de_swamp", {720.6209106445312, 571.2969360351562, 96.03125}, {-3.66080379486084, 14.446796417236328, 0}, "molotov", "Fakeduck", "Throw", 0},
    {"de_swamp", {626.040771484375, 609.466796875, 96.03125}, {-4.7476043701171875, 4.608391761779785, 0}, "molotov", "Fakeduck", "Throw", 0},
    {"de_swamp", {828.02685546875, 539.9716186523438, 96.03125}, {-3.4320127964019775, -32.80043411254883, 0}, "molotov", "Fakeduck", "Run+Throw", 16},
    {"de_swamp", {1296.0079345703125, 1744.6375732421875, -83.96875}, {-20.313735961914062, -81.7369384765625, 0}, "molotov", "Fakeduck", "Throw", 0},
    {"de_swamp", {1996.0721435546875, 1211.9263916015625, -127.96875}, {-12.439162254333496, -109.55437469482422, 0}, "molotov", "Fakeduck", "Run+Throw", 2},
    {"de_swamp", {1964.805908203125, 1020.0928955078125, -127.96875}, {-23.6501522064209, -115.77957916259766, 0}, "molotov", "Fakeduck", "Run+Throw", 1},
    {"de_swamp", {1296.0079345703125, 1744.6375732421875, -83.96875}, {-20.313735961914062, -81.7369384765625, 0}, "molotov", "Fakeduck", "Throw", 0},
    {"de_swamp", {720.6209106445312, 571.2969360351562, 96.03125}, {-3.66080379486084, 14.446796417236328, 0}, "molotov", "Fakeduck", "Throw", 0},
    {"de_swamp", {1148.28662109375, 1085.9786376953125, 32.03125}, {-9.9935302734375, -74.61306762695312, 0}, "molotov", "Box", "Run+Throw", 11},
    {"de_swamp", {2053.7431640625, 1137.454833984375, -47.96875}, {2.598069429397583, -140.50698852539062, 0}, "molotov", "Dancepool + Bool", "Jump+Throw", 0},
    {"de_swamp", {2151.03857421875, 1214.326171875, -125.44709777832031}, {-12.533712387084961, -141.8653564453125, 0}, "molotov", "Fakeduck", "Run+Jump+Throw", 55},
    {"de_swamp", {1425.9840087890625, 1181.757568359375, -129.96875}, {-37.78413391113281, -116.3520278930664, 0}, "molotov", "Box", "Throw", 0},
    {"de_swamp", {1790.1407470703125, 873.8352661132812, -127.96875}, {-16.374744415283203, -92.61316680908203, 0}, "molotov", "Back", "Run+Throw", 1},
    {"de_swamp", {1296.0079345703125, 1744.6375732421875, -83.96875}, {-20.313735961914062, -81.7369384765625, 0}, "molotov", "Fakeduck", "Throw", 0},
    {"de_swamp", {626.040771484375, 609.466796875, 96.03125}, {-4.7476043701171875, 4.608391761779785, 0}, "molotov", "Fakeduck", "Throw", 0},
    {"de_swamp", {828.02685546875, 539.9716186523438, 96.03125}, {-3.4320127964019775, -32.80043411254883, 0}, "molotov", "Fakeduck", "Run+Throw", 16},
    {"de_shortnuke", {423.6324462890625, 83.42068481445312, -575.96875}, {-3.743135929107666, -78.56092834472656, 0}, "molotov", "Doors", "Run+Throw", 12},
    {"de_shortnuke", {1172.644775390625, -998.387939453125, -703.96875}, {-17.266681671142578, 44.596221923828125, 0}, "molotov", "Window", "Run+Throw", 1},
    {"de_shortnuke", {1112.7235107421875, -1040.381591796875, -703.96875}, {-4.346846580505371, 138.84170532226562, 0}, "molotov", "Fakeduck", "Run+Throw", 6},
    {"de_shortnuke", {778.8310546875, 57.4388427734375, -575.96875}, {-2.9582581520080566, -70.77649688720703, 0}, "molotov", "Window", "Run+Throw", 1},
    {"de_shortnuke", {669.3499755859375, -454.39459228515625, -657.0711059570312}, {-13.946136474609375, -19.27132797241211, 0}, "molotov", "Window", "Throw", 0},
    {"de_shortnuke", {830.4251708984375, 95.98638916015625, -575.96875}, {-3.8035197257995605, -95.6500015258789, 0}, "molotov", "Plant", "Run+Throw", 5},
    {"de_shortnuke", {1152.6251220703125, -374.2468566894531, -593.96875}, {-6.492698669433594, -126.16282653808594, 0}, "molotov", "Plant (Ctrl)", "Throw", 0},
    {"de_shortnuke", {624.5315551757812, -1358.5023193359375, -703.96875}, {-21.197410583496094, 102.46884155273438, 0}, "molotov", "push", "Run+Throw", 3},
    {"de_shortnuke", {498.69366455078125, 78.31049346923828, -575.96875}, {-7.230602741241455, -106.215576171875, 0}, "molotov", "plant", "Run+Throw", 15},
    {"de_shortnuke", {1290.805908203125, -592.1639404296875, -575.96875}, {-6.258520030975342, 149.50087890625, 0}, "molotov", "Ramp fakelag-off", "Run+Throw", 36},
    {"de_shortnuke", {1391.97, -741.64, -619.06}, {-3.25, 152.51, 0}, "molotov", "Fakeduck (Ctrl)", "Throw", 36},
    {"de_shortnuke", {354.79, -708.28, -703.97}, {-21.5, 48.05, 0}, "molotov", "CT Spawn", "Throw", 1},
    {"de_dust2_old", {345.026855, 394.215454, 80.864014}, {-70.903008, 0.100315, 0}, "molotov", "Box", "Jump+Throw", 0},
    {"de_dust2_old", {-117.45, 1329.9, 64.03}, {-8.84, 139.89, 0}, "molotov", "Best Molotov (CT)", "Run+Throw", 32},
    {"de_dust2_old", {286.83, 1770.94, 160.03}, {-12.88, 51.86, 0}, "molotov", "Barrels", "Run+Throw", 39},
    {"de_dust2_old", {-142.32, 2138.42, -60.49}, {-2.44, -137.23, 0}, "molotov", "Short", "Run+Jump+Throw", 0},
    {"de_dust2_old", {-923.82, 2458.64, 52.13}, {-25.48, -128.55, 0}, "molotov", "Car", "Throw", 0},
    {"de_dust2_old", {-1448.61, 2593.7, 171.03}, {12.09, -20.08, 0}, "molotov", "Boost", "Jump+Throw", 0},
    {"de_dust2_old", {-1672.27, 2572.69, 195.4}, {-2.24, -16.69, 0}, "molotov", "Boost", "Run+Throw", 8},
    {"de_dust2_old", {-1242.59, 2560.78, 114.26}, {-35.71, 116.83, 0}, "molotov", "Left-Box", "Throw", 0},
    {"de_dust2_old", {-1214.34, 2533.24, 111.13}, {-31.55, 122.06, 0}, "molotov", "Right-Box", "Throw", 0},
    {"de_dust2_old", {-1144.12, 2596.78, 105.43}, {-12.41, 158.8, 0}, "molotov", "Fakeduck", "Throw", 0},
    {"de_dust2_old", {119.8, 1377.74, 64.03}, {-16.51, 55.12, 0}, "molotov", "Fakeduck", "Throw", 0},
    {"de_dust2_old", {-272.03, 1776, -63.07}, {1.56, 159.59, 0}, "molotov", "CT", "Jump+Throw", 0},
    {"de_dust2_old", {-447.5, 1704.06, -62.74}, {2.42, 62.08, 0}, "molotov", "Spawn", "Run+Throw", 2},
    {"de_dust2_old", {272.04, 1670.59, 97.76}, {-14.96, 58.24, 0}, "molotov", "A-Box", "Run+Throw", 40},
    {"de_dust2_old_bc", {345.026855, 394.215454, 80.864014}, {-70.903008, 0.100315, 0}, "molotov", "Box", "Jump+Throw", 0},
    {"de_dust2_old_bc", {-117.45, 1329.9, 64.03}, {-8.84, 139.89, 0}, "molotov", "Best Molotov (CT)", "Run+Throw", 32},
    {"de_dust2_old_bc", {286.83, 1770.94, 160.03}, {-12.88, 51.86, 0}, "molotov", "Barrels", "Run+Throw", 39},
    {"de_dust2_old_bc", {-142.32, 2138.42, -60.49}, {-2.44, -137.23, 0}, "molotov", "Short", "Run+Jump+Throw", 0},
    {"de_dust2_old_bc", {-923.82, 2458.64, 52.13}, {-25.48, -128.55, 0}, "molotov", "Car", "Throw", 0},
    {"de_dust2_old_bc", {-1448.61, 2593.7, 171.03}, {12.09, -20.08, 0}, "molotov", "Boost", "Jump+Throw", 0},
    {"de_dust2_old_bc", {-1672.27, 2572.69, 195.4}, {-2.24, -16.69, 0}, "molotov", "Boost", "Run+Throw", 8},
    {"de_dust2_old_bc", {-1242.59, 2560.78, 114.26}, {-35.71, 116.83, 0}, "molotov", "Left-Box", "Throw", 0},
    {"de_dust2_old_bc", {-1214.34, 2533.24, 111.13}, {-31.55, 122.06, 0}, "molotov", "Right-Box", "Throw", 0},
    {"de_dust2_old_bc", {-1144.12, 2596.78, 105.43}, {-12.41, 158.8, 0}, "molotov", "Fakeduck", "Throw", 0},
    {"de_dust2_old_bc", {119.8, 1377.74, 64.03}, {-16.51, 55.12, 0}, "molotov", "Fakeduck", "Throw", 0},
    {"de_dust2_old_bc", {-272.03, 1776, -63.07}, {1.56, 159.59, 0}, "molotov", "CT", "Jump+Throw", 0},
    {"de_dust2_old_bc", {-447.5, 1704.06, -62.74}, {2.42, 62.08, 0}, "molotov", "Spawn", "Run+Throw", 2},
    {"de_dust2_old_bc", {272.04, 1670.59, 97.76}, {-14.96, 58.24, 0}, "molotov", "A-Box", "Run+Throw", 40},
    {"de_dust2_old_1", {345.026855, 394.215454, 80.864014}, {-70.903008, 0.100315, 0}, "molotov", "Box", "Jump+Throw", 0},
    {"de_dust2_old_1", {-117.45, 1329.9, 64.03}, {-8.84, 139.89, 0}, "molotov", "Best Molotov (CT)", "Run+Throw", 32},
    {"de_dust2_old_1", {286.83, 1770.94, 160.03}, {-12.88, 51.86, 0}, "molotov", "Barrels", "Run+Throw", 39},
    {"de_dust2_old_1", {-142.32, 2138.42, -60.49}, {-2.44, -137.23, 0}, "molotov", "Short", "Run+Jump+Throw", 0},
    {"de_dust2_old_1", {-923.82, 2458.64, 52.13}, {-25.48, -128.55, 0}, "molotov", "Car", "Throw", 0},
    {"de_dust2_old_1", {-1448.61, 2593.7, 171.03}, {12.09, -20.08, 0}, "molotov", "Boost", "Jump+Throw", 0},
    {"de_dust2_old_1", {-1672.27, 2572.69, 195.4}, {-2.24, -16.69, 0}, "molotov", "Boost", "Run+Throw", 8},
    {"de_dust2_old_1", {-1242.59, 2560.78, 114.26}, {-35.71, 116.83, 0}, "molotov", "Left-Box", "Throw", 0},
    {"de_dust2_old_1", {-1214.34, 2533.24, 111.13}, {-31.55, 122.06, 0}, "molotov", "Right-Box", "Throw", 0},
    {"de_dust2_old_1", {-1144.12, 2596.78, 105.43}, {-12.41, 158.8, 0}, "molotov", "Fakeduck", "Throw", 0},
    {"de_dust2_old_1", {119.8, 1377.74, 64.03}, {-16.51, 55.12, 0}, "molotov", "Fakeduck", "Throw", 0},
    {"de_dust2_old_1", {-272.03, 1776, -63.07}, {1.56, 159.59, 0}, "molotov", "CT", "Jump+Throw", 0},
    {"de_dust2_old_1", {-447.5, 1704.06, -62.74}, {2.42, 62.08, 0}, "molotov", "Spawn", "Run+Throw", 2},
    {"de_dust2_old_1", {272.04, 1670.59, 97.76}, {-14.96, 58.24, 0}, "molotov", "A-Box", "Run+Throw", 40},
    {"de_dust2_old_ht", {345.026855, 394.215454, 80.864014}, {-70.903008, 0.100315, 0}, "molotov", "Box", "Jump+Throw", 0},
    {"de_dust2_old_ht", {-117.45, 1329.9, 64.03}, {-8.84, 139.89, 0}, "molotov", "Best Molotov (CT)", "Run+Throw", 32},
    {"de_dust2_old_ht", {286.83, 1770.94, 160.03}, {-12.88, 51.86, 0}, "molotov", "Barrels", "Run+Throw", 39},
    {"de_dust2_old_ht", {-142.32, 2138.42, -60.49}, {-2.44, -137.23, 0}, "molotov", "Short", "Run+Jump+Throw", 0},
    {"de_dust2_old_ht", {-923.82, 2458.64, 52.13}, {-25.48, -128.55, 0}, "molotov", "Car", "Throw", 0},
    {"de_dust2_old_ht", {-1448.61, 2593.7, 171.03}, {12.09, -20.08, 0}, "molotov", "Boost", "Jump+Throw", 0},
    {"de_dust2_old_ht", {-1672.27, 2572.69, 195.4}, {-2.24, -16.69, 0}, "molotov", "Boost", "Run+Throw", 8},
    {"de_dust2_old_ht", {-1242.59, 2560.78, 114.26}, {-35.71, 116.83, 0}, "molotov", "Left-Box", "Throw", 0},
    {"de_dust2_old_ht", {-1214.34, 2533.24, 111.13}, {-31.55, 122.06, 0}, "molotov", "Right-Box", "Throw", 0},
    {"de_dust2_old_ht", {-1144.12, 2596.78, 105.43}, {-12.41, 158.8, 0}, "molotov", "Fakeduck", "Throw", 0},
    {"de_dust2_old_ht", {119.8, 1377.74, 64.03}, {-16.51, 55.12, 0}, "molotov", "Fakeduck", "Throw", 0},
    {"de_dust2_old_ht", {-272.03, 1776, -63.07}, {1.56, 159.59, 0}, "molotov", "CT", "Jump+Throw", 0},
    {"de_dust2_old_ht", {-447.5, 1704.06, -62.74}, {2.42, 62.08, 0}, "molotov", "Spawn", "Run+Throw", 2},
    {"de_dust2_old_ht", {272.04, 1670.59, 97.76}, {-14.96, 58.24, 0}, "molotov", "A-Box", "Run+Throw", 40},
    {"de_dust2_old_uwu", {345.026855, 394.215454, 80.864014}, {-70.903008, 0.100315, 0}, "molotov", "Box", "Jump+Throw", 0},
    {"de_dust2_old_uwu", {-117.45, 1329.9, 64.03}, {-8.84, 139.89, 0}, "molotov", "Best Molotov (CT)", "Run+Throw", 32},
    {"de_dust2_old_uwu", {286.83, 1770.94, 160.03}, {-12.88, 51.86, 0}, "molotov", "Barrels", "Run+Throw", 39},
    {"de_dust2_old_uwu", {-142.32, 2138.42, -60.49}, {-2.44, -137.23, 0}, "molotov", "Short", "Run+Jump+Throw", 0},
    {"de_dust2_old_uwu", {-923.82, 2458.64, 52.13}, {-25.48, -128.55, 0}, "molotov", "Car", "Throw", 0},
    {"de_dust2_old_uwu", {-1448.61, 2593.7, 171.03}, {12.09, -20.08, 0}, "molotov", "Boost", "Jump+Throw", 0},
    {"de_dust2_old_uwu", {-1672.27, 2572.69, 195.4}, {-2.24, -16.69, 0}, "molotov", "Boost", "Run+Throw", 8},
    {"de_dust2_old_uwu", {-1242.59, 2560.78, 114.26}, {-35.71, 116.83, 0}, "molotov", "Left-Box", "Throw", 0},
    {"de_dust2_old_uwu", {-1214.34, 2533.24, 111.13}, {-31.55, 122.06, 0}, "molotov", "Right-Box", "Throw", 0},
    {"de_dust2_old_uwu", {-1144.12, 2596.78, 105.43}, {-12.41, 158.8, 0}, "molotov", "Fakeduck", "Throw", 0},
    {"de_dust2_old_uwu", {119.8, 1377.74, 64.03}, {-16.51, 55.12, 0}, "molotov", "Fakeduck", "Throw", 0},
    {"de_dust2_old_uwu", {-272.03, 1776, -63.07}, {1.56, 159.59, 0}, "molotov", "CT", "Jump+Throw", 0},
    {"de_dust2_old_uwu", {-447.5, 1704.06, -62.74}, {2.42, 62.08, 0}, "molotov", "Spawn", "Run+Throw", 2},
    {"de_dust2_old_uwu", {272.04, 1670.59, 97.76}, {-14.96, 58.24, 0}, "molotov", "A-Box", "Run+Throw", 40},
    {"de_dust2_se++", {345.026855, 394.215454, 80.864014}, {-70.903008, 0.100315, 0}, "molotov", "Box", "Jump+Throw", 0},
    {"de_dust2_se++", {-117.45, 1329.9, 64.03}, {-8.84, 139.89, 0}, "molotov", "Best Molotov (CT)", "Run+Throw", 32},
    {"de_dust2_se++", {286.83, 1770.94, 160.03}, {-12.88, 51.86, 0}, "molotov", "Barrels", "Run+Throw", 39},
    {"de_dust2_se++", {-142.32, 2138.42, -60.49}, {-2.44, -137.23, 0}, "molotov", "Short", "Run+Jump+Throw", 0},
    {"de_dust2_se++", {-923.82, 2458.64, 52.13}, {-25.48, -128.55, 0}, "molotov", "Car", "Throw", 0},
    {"de_dust2_se++", {-1448.61, 2593.7, 171.03}, {12.09, -20.08, 0}, "molotov", "Boost", "Jump+Throw", 0},
    {"de_dust2_se++", {-1672.27, 2572.69, 195.4}, {-2.24, -16.69, 0}, "molotov", "Boost", "Run+Throw", 8},
    {"de_dust2_se++", {-1242.59, 2560.78, 114.26}, {-35.71, 116.83, 0}, "molotov", "Left-Box", "Throw", 0},
    {"de_dust2_se++", {-1214.34, 2533.24, 111.13}, {-31.55, 122.06, 0}, "molotov", "Right-Box", "Throw", 0},
    {"de_dust2_se++", {-1144.12, 2596.78, 105.43}, {-12.41, 158.8, 0}, "molotov", "Fakeduck", "Throw", 0},
    {"de_dust2_se++", {119.8, 1377.74, 64.03}, {-16.51, 55.12, 0}, "molotov", "Fakeduck", "Throw", 0},
    {"de_dust2_se++", {-272.03, 1776, -63.07}, {1.56, 159.59, 0}, "molotov", "CT", "Jump+Throw", 0},
    {"de_dust2_se++", {-447.5, 1704.06, -62.74}, {2.42, 62.08, 0}, "molotov", "Spawn", "Run+Throw", 2},
    {"de_dust2_se++", {272.04, 1670.59, 97.76}, {-14.96, 58.24, 0}, "molotov", "A-Box", "Run+Throw", 40},
    {"de_dust2_se", {345.026855, 394.215454, 80.864014}, {-70.903008, 0.100315, 0}, "molotov", "Box", "Jump+Throw", 0},
    {"de_dust2_se", {-117.45, 1329.9, 64.03}, {-8.84, 139.89, 0}, "molotov", "Best Molotov (CT)", "Run+Throw", 32},
    {"de_dust2_se", {286.83, 1770.94, 160.03}, {-12.88, 51.86, 0}, "molotov", "Barrels", "Run+Throw", 39},
    {"de_dust2_se", {-142.32, 2138.42, -60.49}, {-2.44, -137.23, 0}, "molotov", "Short", "Run+Jump+Throw", 0},
    {"de_dust2_se", {-923.82, 2458.64, 52.13}, {-25.48, -128.55, 0}, "molotov", "Car", "Throw", 0},
    {"de_dust2_se", {-1448.61, 2593.7, 171.03}, {12.09, -20.08, 0}, "molotov", "Boost", "Jump+Throw", 0},
    {"de_dust2_se", {-1672.27, 2572.69, 195.4}, {-2.24, -16.69, 0}, "molotov", "Boost", "Run+Throw", 8},
    {"de_dust2_se", {-1242.59, 2560.78, 114.26}, {-35.71, 116.83, 0}, "molotov", "Left-Box", "Throw", 0},
    {"de_dust2_se", {-1214.34, 2533.24, 111.13}, {-31.55, 122.06, 0}, "molotov", "Right-Box", "Throw", 0},
    {"de_dust2_se", {-1144.12, 2596.78, 105.43}, {-12.41, 158.8, 0}, "molotov", "Fakeduck", "Throw", 0},
    {"de_dust2_se", {119.8, 1377.74, 64.03}, {-16.51, 55.12, 0}, "molotov", "Fakeduck", "Throw", 0},
    {"de_dust2_se", {-272.03, 1776, -63.07}, {1.56, 159.59, 0}, "molotov", "CT", "Jump+Throw", 0},
    {"de_dust2_se", {-447.5, 1704.06, -62.74}, {2.42, 62.08, 0}, "molotov", "Spawn", "Run+Throw", 2},
    {"de_dust2_se", {272.04, 1670.59, 97.76}, {-14.96, 58.24, 0}, "molotov", "A-Box", "Run+Throw", 40},
    {"de_dust2_old_up", {345.026855, 394.215454, 80.864014}, {-70.903008, 0.100315, 0}, "molotov", "Box", "Jump+Throw", 0},
    {"de_dust2_old_up", {-117.45, 1329.9, 64.03}, {-8.84, 139.89, 0}, "molotov", "Best Molotov (CT)", "Run+Throw", 32},
    {"de_dust2_old_up", {286.83, 1770.94, 160.03}, {-12.88, 51.86, 0}, "molotov", "Barrels", "Run+Throw", 39},
    {"de_dust2_old_up", {-142.32, 2138.42, -60.49}, {-2.44, -137.23, 0}, "molotov", "Short", "Run+Jump+Throw", 0},
    {"de_dust2_old_up", {-923.82, 2458.64, 52.13}, {-25.48, -128.55, 0}, "molotov", "Car", "Throw", 0},
    {"de_dust2_old_up", {-1448.61, 2593.7, 171.03}, {12.09, -20.08, 0}, "molotov", "Boost", "Jump+Throw", 0},
    {"de_dust2_old_up", {-1672.27, 2572.69, 195.4}, {-2.24, -16.69, 0}, "molotov", "Boost", "Run+Throw", 8},
    {"de_dust2_old_up", {-1242.59, 2560.78, 114.26}, {-35.71, 116.83, 0}, "molotov", "Left-Box", "Throw", 0},
    {"de_dust2_old_up", {-1214.34, 2533.24, 111.13}, {-31.55, 122.06, 0}, "molotov", "Right-Box", "Throw", 0},
    {"de_dust2_old_up", {-1144.12, 2596.78, 105.43}, {-12.41, 158.8, 0}, "molotov", "Fakeduck", "Throw", 0},
    {"de_dust2_old_up", {119.8, 1377.74, 64.03}, {-16.51, 55.12, 0}, "molotov", "Fakeduck", "Throw", 0},
    {"de_dust2_old_up", {-272.03, 1776, -63.07}, {1.56, 159.59, 0}, "molotov", "CT", "Jump+Throw", 0},
    {"de_dust2_old_up", {-447.5, 1704.06, -62.74}, {2.42, 62.08, 0}, "molotov", "Spawn", "Run+Throw", 2},
    {"de_dust2_old_up", {272.04, 1670.59, 97.76}, {-14.96, 58.24, 0}, "molotov", "A-Box", "Run+Throw", 40},
    {"de_dust2_old_mrx", {345.026855, 394.215454, 80.864014}, {-70.903008, 0.100315, 0}, "molotov", "Box", "Jump+Throw", 0},
    {"de_dust2_old_mrx", {-117.45, 1329.9, 64.03}, {-8.84, 139.89, 0}, "molotov", "Best Molotov (CT)", "Run+Throw", 32},
    {"de_dust2_old_mrx", {286.83, 1770.94, 160.03}, {-12.88, 51.86, 0}, "molotov", "Barrels", "Run+Throw", 39},
    {"de_dust2_old_mrx", {-142.32, 2138.42, -60.49}, {-2.44, -137.23, 0}, "molotov", "Short", "Run+Jump+Throw", 0},
    {"de_dust2_old_mrx", {-923.82, 2458.64, 52.13}, {-25.48, -128.55, 0}, "molotov", "Car", "Throw", 0},
    {"de_dust2_old_mrx", {-1448.61, 2593.7, 171.03}, {12.09, -20.08, 0}, "molotov", "Boost", "Jump+Throw", 0},
    {"de_dust2_old_mrx", {-1672.27, 2572.69, 195.4}, {-2.24, -16.69, 0}, "molotov", "Boost", "Run+Throw", 8},
    {"de_dust2_old_mrx", {-1242.59, 2560.78, 114.26}, {-35.71, 116.83, 0}, "molotov", "Left-Box", "Throw", 0},
    {"de_dust2_old_mrx", {-1214.34, 2533.24, 111.13}, {-31.55, 122.06, 0}, "molotov", "Right-Box", "Throw", 0},
    {"de_dust2_old_mrx", {-1144.12, 2596.78, 105.43}, {-12.41, 158.8, 0}, "molotov", "Fakeduck", "Throw", 0},
    {"de_dust2_old_mrx", {119.8, 1377.74, 64.03}, {-16.51, 55.12, 0}, "molotov", "Fakeduck", "Throw", 0},
    {"de_dust2_old_mrx", {-272.03, 1776, -63.07}, {1.56, 159.59, 0}, "molotov", "CT", "Jump+Throw", 0},
    {"de_dust2_old_mrx", {-447.5, 1704.06, -62.74}, {2.42, 62.08, 0}, "molotov", "Spawn", "Run+Throw", 2},
    {"de_dust2_old_mrx", {272.04, 1670.59, 97.76}, {-14.96, 58.24, 0}, "molotov", "A-Box", "Run+Throw", 40},
    {"de_dust2_old_otp", {345.026855, 394.215454, 80.864014}, {-70.903008, 0.100315, 0}, "molotov", "Box", "Jump+Throw", 0},
    {"de_dust2_old_otp", {-117.45, 1329.9, 64.03}, {-8.84, 139.89, 0}, "molotov", "Best Molotov (CT)", "Run+Throw", 32},
    {"de_dust2_old_otp", {286.83, 1770.94, 160.03}, {-12.88, 51.86, 0}, "molotov", "Barrels", "Run+Throw", 39},
    {"de_dust2_old_otp", {-142.32, 2138.42, -60.49}, {-2.44, -137.23, 0}, "molotov", "Short", "Run+Jump+Throw", 0},
    {"de_dust2_old_otp", {-923.82, 2458.64, 52.13}, {-25.48, -128.55, 0}, "molotov", "Car", "Throw", 0},
    {"de_dust2_old_otp", {-1448.61, 2593.7, 171.03}, {12.09, -20.08, 0}, "molotov", "Boost", "Jump+Throw", 0},
    {"de_dust2_old_otp", {-1672.27, 2572.69, 195.4}, {-2.24, -16.69, 0}, "molotov", "Boost", "Run+Throw", 8},
    {"de_dust2_old_otp", {-1242.59, 2560.78, 114.26}, {-35.71, 116.83, 0}, "molotov", "Left-Box", "Throw", 0},
    {"de_dust2_old_otp", {-1214.34, 2533.24, 111.13}, {-31.55, 122.06, 0}, "molotov", "Right-Box", "Throw", 0},
    {"de_dust2_old_otp", {-1144.12, 2596.78, 105.43}, {-12.41, 158.8, 0}, "molotov", "Fakeduck", "Throw", 0},
    {"de_dust2_old_otp", {119.8, 1377.74, 64.03}, {-16.51, 55.12, 0}, "molotov", "Fakeduck", "Throw", 0},
    {"de_dust2_old_otp", {-272.03, 1776, -63.07}, {1.56, 159.59, 0}, "molotov", "CT", "Jump+Throw", 0},
    {"de_dust2_old_otp", {-447.5, 1704.06, -62.74}, {2.42, 62.08, 0}, "molotov", "Spawn", "Run+Throw", 2},
    {"de_dust2_old_otp", {272.04, 1670.59, 97.76}, {-14.96, 58.24, 0}, "molotov", "A-Box", "Run+Throw", 40},
    {"de_dust2", {-99.97807312011719, 1333.609130859375, 64.79857635498047}, {10.182931804656983, 139.0959930419922, 0}, "molotov", "CT Spawn", "Run+Jump+Throw", 0},
    {"de_dust2", {311.253173828125, 1778.836669921875, 160.03125}, {-16.13386344909668, 55.09999084472656, 0}, "molotov", "Barrels", "Run+Throw", 22},
    {"de_dust2", {-95.617844, 2204.954102, -63.07182312011719}, {-1.8532280921936035, -138.43365478515625, 0}, "molotov", "Short", "Run+Jump+Throw", 0},
    {"de_dust2", {408.355713, 2325.712646, -55.273231506347656}, {-10.712742805480957, -40.69916534423828, 0}, "molotov", "A Plant", "Run+Jump+Throw", 0},
    {"de_dust2", {-840.8713989257812, 2544.03564453125, 23.03125}, {-14.557376861572266, -143.66795043945314, 0}, "molotov", "Car", "Run+Throw", 12},
    {"de_dust2", {-1214.33, 2533.26, 117.84}, {-19.9, 125.9, 0}, "molotov", "Left-Box", "Throw", 0},
    {"de_dust2", {-1273.98, 2575.98, 134.4}, {-7.35, 15.83, 0}, "molotov", "Right-Box", "Jump+Throw", 0},
    {"de_dust2", {-1448.61, 2593.7, 174.5}, {12.09, -20.08, 0}, "molotov", "Boost", "Jump+Throw", 1},
    {"de_dust2", {-1672.27, 2517.69, 198.03}, {-2.75, -16.1, 0}, "molotov", "Boost", "Run+Throw", -1},
    {"de_dust2", {-1154.56, 2621.78, 131.9}, {-4.36, 163.35, 0}, "molotov", "Fakeduck", "Throw", 1},
    {"de_dust2", {-276.03, 1772, -37.51}, {1.56, 159.59, 0}, "molotov", "CT", "Jump+Throw", 0},
    {"de_dust2", {-416.08, 1773.33, -62.65}, {0.31, 64.63, 0}, "molotov", "Spawn", "Throw", 2},
    {"de_dust2", {130.58, 1334.05, 65.08}, {-20.66, 57.77, 0}, "molotov", "Fakeduck", "Throw", 2},
    {"de_dust2", {-1189.37, 2567.91, 122.97}, {-24.77, -113.88, 0}, "molotov", "Car", "Throw", 2},
    {"de_dust2", {650.23, 794.2, 64.41}, {-5.62, -2.32, 0}, "molotov", "Pit (Fakeduck)", "Throw", 2},
    {"de_dust2", {273.03, 1672.07, 103.51}, {-13.41, 58.34, 0}, "molotov", "A-Box", "Run+Throw", 44},
    {"cs_assault", {5036.02734375, 4690.833984375, -767.96875}, {-20.95513343811035, -28.72373390197754, 0}, "molotov", "car", "Run+Throw", 22},
    {"cs_assault", {5028.47265625, 4481.09423828125, -543.96875}, {-7.425126075744629, -53.23324966430664, 0}, "molotov", "barrels2", "Run+Throw", 10},
    {"cs_assault", {4894.19189453125, 4566.52294921875, -543.96875}, {-8.365882873535156, -29.65663719177246, 0}, "molotov", "car2", "Throw", 0},
    {"cs_assault", {5862.80712890625, 4365.2265625, -809.96875}, {-51.01493835449219, -86.1195297241211, 0}, "molotov", "car3", "Throw", 0},
    {"cs_assault", {4896.8408203125, 4498.37060546875, -543.923583984375}, {-9.984526634216309, -14.29495620727539, 0}, "molotov", "wheels", "Throw", 0},
    {"cs_assault", {5036.84228515625, 4759.4921875, -767.96875}, {-5.995270729064941, -51.4561767578125, 0}, "molotov", "barrels", "Jump+Throw", 0},
    {"cs_assault", {5028.03125, 4449.1005859375, -543.96875}, {-2.959981918334961, -43.094295501708984, 0}, "molotov", "car4", "Throw", 0},
    {"cs_assault", {5801.7763671875, 4481.7666015625, -809.96875}, {-31.94497299194336, -90.0638427734375, 0}, "molotov", "barrels3", "Throw", 0},
    {"cs_assault", {5037.9375, 4631.5087890625, -780.2044677734375}, {-19.91009521484375, -17.069568634033203, 0}, "molotov", "wheels2", "Run+Throw", 12},
    {"cs_assault", {5028.03125, 4649.01806640625, -543.96875}, {-16.609716415405273, -49.919883728027344, 0}, "molotov", "barrels5", "Throw", 0},
    {"cs_assault", {4949.74951171875, 4339.04638671875, -800.8780517578125}, {-15.124885559082031, 53.455238342285156, 0}, "molotov", "One-way", "Run+Throw", 7},
    {"cs_assault", {5058.2724609375, 4640.20703125, -778.0131225585938}, {-22.978965759277344, -21.99321174621582, 0}, "molotov", "car5", "Run+Throw", 15},
    {"gd_rialto", {602.3978881835938, 542.1378173828125, 251.8489990234375}, {-33.02888870239258, -145.00625610351562, 0}, "molotov", "One-way", "Run+Throw", 1},
    {"gd_rialto", {96.45825958251953, 1395.0413818359375, 104.03125}, {-44.70249557495117, -101.7649154663086, 0}, "molotov", "One-way", "Run+Throw", 12},
    {"gd_rialto", {291.205810546875, 743.9689331054688, 160.03125}, {-44.015689849853516, -123.7383041381836, 0}, "molotov", "One-way", "Throw", 0},
    {"gd_rialto", {-150.63319396972656, 746.4841918945312, 160.03125}, {-48.34162902832031, -98.88065338134766, 0}, "molotov", "One-way", "Throw", 0},
    {"gd_rialto", {-225.0385284423828, 43.242218017578125, 288.03125}, {-51.835357666015625, -7.485260963439941, 0}, "molotov", "One-way", "Run+Throw", 1},
    {"gd_rialto", {423.952392578125, 108.00133514404297, 288.03125}, {-6.867362976074219, -162.24012756347656, 0}, "molotov", "Plant", "Throw", 0},
    {"gd_rialto", {286.641845703125, -745.9822998046875, 160.03125}, {-42.98603439331055, 125.2676773071289, 0}, "molotov", "One-way", "Throw", 0},
    {"gd_rialto", {-267.4080505371094, -751.9440307617188, 160.03125}, {-47.37066101074219, 88.18794250488281, 0}, "molotov", "One-way", "Throw", 0},
    {"gd_rialto", {234.99375915527344, 7.205482006072998, 288.03125}, {-51.04185485839844, -178.90574645996094, 0}, "molotov", "Roof", "Run+Throw", 1},
    {"gd_rialto", {428.23681640625, 1301.126708984375, 104.03125}, {-14.41128921508789, -78.90320587158203, 0}, "molotov", "Spawn", "Run+Throw", 40},
    {"gd_rialto", {390.07269287109375, -444.25128173828125, 213.9654083251953}, {-7.888189315795898, 137.41482543945312, 0}, "molotov", "Plant", "Run+Throw", 2},
    {"gd_rialto", {-204.06932067871094, -63.39451217651367, 593.85986328125}, {22.325172424316406, 2.7596023082733154, 0}, "molotov", "Plant", "Run+Throw", 6},
    {"gd_rialto", {248.8062286376953, 0.4104073643684387, 619.03125}, {31.320512771606445, -179.70718383789062, 0}, "molotov", "Plant", "Run+Throw", 7},
    {"gd_rialto", {-657.360107421875, 709.5709838867188, 160.03125}, {-41.26045227050781, -41.000579833984375, 0}, "molotov", "Roof", "Run+Throw", 3},
    {"gd_rialto", {172.48260498046875, -725.0706787109375, 160.03125}, {-24.849159240722656, 119.72855377197266, 0}, "molotov", "Side Fakeduck", "Throw", 0},
    {"de_guard", {-692.8543701171875, 391.3226318359375, -77.99998474121094}, {2.5849757194519043, -67.51493835449219, 0}, "molotov", "Plant", "Jump+Throw", 1},
    {"de_guard", {842.8583374023438, 471.80535888671875, 72.03125}, {-16.83013153076172, -106.45503234863281, 0}, "molotov", "Fakeduck [Box]", "Run+Throw", 10},
    {"de_guard", {653.6270751953125, 1228.1781005859375, -30.757530212402344}, {-11.595149040222168, -147.82315063476562, 0}, "molotov", "Fakeduck (Spawn)", "Throw", 1},
    {"de_guard", {-271.1070556640625, 178.76589965820312, 54.50410461425781}, {-12.375020027160645, -77.69019317626953, 0}, "molotov", "Car", "Throw", 1},
    {"de_guard", {-612.5061645507812, -334.0557861328125, -143.96875}, {0.6240843534469604, -66.20125579833984, 0}, "molotov", "Fakeduck", "Jump+Throw", 1},
    {"de_guard", {407.64471435546875, -1579.36474609375, -111.96875}, {-10.09751033782959, 121.81580352783203, 0}, "molotov", "Box", "Throw", 1},
    {"de_guard", {367.96, -256.45, 72.03}, {-4.17, -100.6, 0}, "molotov", "Truck", "Run+Throw", 15},
    {"de_guard", {620.61, -51.94, 65.25}, {10.17, -107.54, 0}, "molotov", "Short One-way", "Run+Jump+Throw", 2},
    {"de_guard", {-273.15, 307.99, 34.03}, {-14.03, -79.61, 0}, "molotov", "Truck", "Throw", 22},
    {"de_guard", {757.32, 25.99, 228.03}, {-34.2, -68.27, 0}, "molotov", "Short One-way", "Throw", 22},
    {"de_ancient", {918.6610717773438, -859.9689331054688, 88.99400329589844}, {-24.231401443481445, 108.65946197509766, 0}, "molotov", "Plant", "Throw", 1},
    {"de_ancient", {1047.2535400390625, 909.5084838867188, 171.48068237304688}, {-24.47502899169922, -127.22012329101562, 0}, "molotov", "Plant", "Throw", 0},
    {"de_ancient", {382.6202087402344, 850.716796875, 172.0924072265625}, {-66.21998596191406, -31.594993591308594, 0}, "molotov", "Ugol", "Jump+Throw", 0},
    {"de_ancient", {-356.81378173828125, 1184.400390625, 123.97457122802734}, {-17.819990158081055, -23.75994873046875, 0}, "molotov", "Spawn", "Run+Throw", 5},
    {"de_elysion", {4.930483341217041, 210.71778869628906, 9728.03125}, {-13.057673454284668, 20.758615493774414, 0}, "molotov", "Fakeduck", "Throw", 0},
    {"de_elysion", {-547.260986328125, 261.3359680175781, 9778.03125}, {-15.422633171081543, -19.861459732055664, 0}, "molotov", "Fakeduck", "Run+Throw", 33},
    {"de_elysion", {-466.66107177734375, 222.0797119140625, 9792.03125}, {-13.607635498046875, -18.98151206970215, 0}, "molotov", "Fakeduck", "Run+Throw", 13},
    {"de_elysion", {560.5816650390625, -366.5264587402344, 9664.03125}, {-10.89001178741455, 53.94506072998047, 0}, "molotov", "Fakeduck", "Run+Throw", 10},
    {"de_elysion", {-156.3833770751953, -524.0132446289062, 9692.2021484375}, {-23.92527961730957, 47.18010711669922, 0}, "molotov", "Fakeduck", "Throw", 0},
    {"de_elysion", {-128.24, 42.03, 9728.03}, {9.12, 29.77, 0}, "molotov", "Fakeduck", "Jump+Throw", 0},
    {"de_elysion", {-492.785888671875, 34.872276306152344, 9728.03125}, {-17.710033416748047, 9.535080909729004, 0}, "molotov", "Fakeduck", "Throw", 0},
    {"de_elysion", {-206.46873474121094, -580.8521728515625, 9678.431640625}, {-23.81517219543457, 46.49517822265625, 0}, "molotov", "Fakeduck", "Throw", 0},
    {"de_elysion", {774.86, -654.34, 9663.53}, {6.26, 56, 0}, "molotov", "One-way", "Run+Jump+Throw", 0},
    {"de_elysion", {740.078125, -689.2947387695312, 9663.53125}, {-18.81000518798828, 54.20489501953125, 0}, "molotov", "One-way", "Run+Throw", 15},
    {"de_inferno", {1841.0511474609375, -183.21658325195312, 302.03125}, {7.030681610107422, -3.5883283615112305, 0}, "high explosive grenade", "Pit (Ctrl)", "Throw", 0},
    {"de_inferno", {1389.8297119140625, -107.9889144897461, 194.03125}, {-8.408277702331542, 25.320009231567383, 0}, "high explosive grenade", "Box", "Run+Throw", 9},
    {"de_inferno", {1683.911376953125, 1114.0875244140625, 224.64810180664062}, {-1.5491523742675781, 60.929998779296874, 0}, "high explosive grenade", "CT Left", "Run+Throw", 15},
    {"de_inferno", {2100.735595703125, 165.94873046875, 206.03125}, {-8.737442970275879, 143.4633026123047, 0}, "high explosive grenade", "Onspot (Ctrl)", "Throw", 0},
    {"de_inferno", {1968.1119384765625, 493.1418762207031, 206.03125}, {-17.89667510986328, -116.5967025756836, 0}, "high explosive grenade", "Box (Ctrl)", "Throw", 0},
    {"de_inferno", {1828.4495849609375, 638.993896484375, 206.03125}, {-9.970830917358398, -58.62622833251953, 0}, "high explosive grenade", "Short (Ctrl)", "Throw", 0},
    {"de_inferno", {2037.94384765625, 1109.1815185546875, 220.62876892089844}, {-16.537595558166505, -37.23824005126953, 0}, "high explosive grenade", "Onspot-91HP", "Run+Throw", 33},
    {"de_inferno", {442.907470703125, 2622.138916015625, 224.09381103515625}, {-49.4201774597168, -81.290771484375, 0}, "high explosive grenade", "Back he", "Run+Jump+Throw", 0},
    {"de_inferno", {1813.5391845703, 35.910182952881, 192.06773376465}, {-11.584044456482, 44.004806518555, 0}, "high explosive grenade", "Onspot", "Throw", 0},
    {"de_inferno", {1733.21521, -44.736149, 194.06773376465}, {-12.087965965271, 43.120056152344, 0}, "high explosive grenade", "Onspot/Far corner", "Run+Throw", 10},
    {"de_inferno", {1643.802490234375, 1214.0023193359375, 225.2711944580078}, {12.230835247039796, -125.15312042236329, 0}, "high explosive grenade", "Mid", "Run+Jump+Throw", 0},
    {"de_inferno", {2093.8408203125, 1172.5773925781, 228.03125}, {-4.4503602981567, -63.264456176758, 0}, "high explosive grenade", "Graveyard", "Run+Throw", 1},
    {"de_inferno", {1768.0330810546875, 1269.1590576171875, 224.03125}, {-3.7859888076782227, -11.473220825195312, 0}, "high explosive grenade", "Libraly", "Run+Throw", 21},
    {"de_inferno", {2071.656982421875, 1221.7213134765625, 238.03125}, {-28.840972900390625, -107.22435760498047, 0}, "high explosive grenade", "Box", "Throw", 0},
    {"de_inferno", {2018.282958984375, 433.5984802246094, 286.03125}, {-12.200143814086914, 86.68245697021484, 0}, "high explosive grenade", "Long", "Throw", 0},
    {"de_inferno", {-285.39, 850.77, 70.95}, {-12.13, -148.8, 0}, "high explosive grenade", "One-way", "Throw", 1},
    {"de_cbble", {-2500.2626953125, 360.7279968261719, -175.96875}, {-1.4078673124313354, -65.94874572753906, 0}, "high explosive grenade", "Door", "Run Jump+Throw", 15},
    {"de_cbble", {263.0181884765625, -227.67698669433594, 49.937835693359375}, {-6.340320587158203, -93.85490417480469, 0}, "high explosive grenade", "Fountain", "Throw", 1},
    {"de_cbble", {281.586548, -76.822685, 51.6855354309082}, {-8.5429327201843, -94.529113769531, 0}, "high explosive grenade", "Fountain fakelag-off", "Throw", 1},
    {"de_cbble", {-89.87822723388672, -366.96051025390625, 33.002105712890625}, {-4.125046157836914, -64.24164581298828, 0}, "high explosive grenade", "FOUNTAIN", "Throw", 0},
    {"de_cbble", {315.4703063964844, -973.8667602539062, 12.359916687011719}, {-4.914827346801758, -166.0635528564453, 0}, "high explosive grenade", "ROCK (80 HP)", "Throw", 0},
    {"de_cbble", {285.36199951171875, -169.2576446533203, 51.80747985839844}, {-2.8095943927764893, -101.21484375, 0}, "high explosive grenade", "FAKEDUCK 80 HP", "Throw", 0},
    {"de_cbble", {-296.96868896484375, -618.466552734375, 0.03125}, {-5.412281036376953, 28.672893524169922, 0}, "high explosive grenade", "Long", "Run+Throw", 0},
    {"de_cbble", {-121.03929138183594, -520.0784301757812, 32.03125}, {-60.54490280151367, 116.79296112060547, 0}, "high explosive grenade", "Long", "Jump+Throw", 0},
    {"de_cbble", {-303.96893310546875, -16.031368255615234, 32.03125}, {-2.577958822250366, -34.6016731262207, 0}, "high explosive grenade", "Corner / Drop", "Jump+Throw", 0},
    {"de_overpass", {-1048.269287109375, -638.407958984375, 160.03125}, {-13.59200325012207, 86.6157012939453, 0}, "high explosive grenade", "Water", "Run+Throw", 21},
    {"de_overpass", {-1176.03125, -640.255981, 123.181717}, {64.249947, 102.696228, 0}, "high explosive grenade", "team-boost", "Team-boost", 10},
    {"de_overpass", {-1141.4085693359375, 157.20999145507812, 144.03125}, {-24.383459091186523, 152.04100036621094, 0}, "high explosive grenade", "Heaven (Ctrl)", "Throw", 1},
    {"de_overpass", {-481.5085754394531, -528.2068481445312, 75.55261993408203}, {-8.179642677307129, 107.55441284179688, 0}, "high explosive grenade", "Column", "Run+Throw", 22},
    {"de_overpass", {-864.8922119140625, -583.9449462890625, 160.03125}, {-12.365560531616211, 88.21858978271484, 0}, "high explosive grenade", "Barrels", "Throw", 1},
    {"de_overpass", {-1017.0237426757812, -564.472900390625, 160.03125}, {-11.917777061462402, 74.4395654296875, 0}, "high explosive grenade", "Barrels fakelag-off", "Throw", 0},
    {"de_overpass", {-1580.9578857421875, -1087.9552001953125, 200.03125}, {-8.577723503112793, 76.9768295288086, 0}, "high explosive grenade", "Water", "Run+Throw", 1},
    {"de_overpass", {-265.4296569824219, -1014.823974609375, 75.08824157714844}, {-3.481962299346924, 153.0970001220703, 0}, "high explosive grenade", "Short", "Run+Jump+Throw", 0},
    {"de_overpass", {-2474.96875, -1987.7607421875, 578.5694580078125}, {-13.23123550415039, 82.03817749023438, 0}, "high explosive grenade", "Toilet", "Run+Throw", 1},
    {"de_overpass", {-1543.564697, -902.474121, 115.742225646973}, {1.5240458488464, 61.69671585083, 0}, "high explosive grenade", "Barrels", "Run+Jump+Throw", 1},
    {"de_overpass", {-768.15313720703, 80.262344360352, 135.407666015625}, {-8.491834640503, -138.96389770508, 0}, "high explosive grenade", "Under-Water", "Run+Throw", 7},
    {"de_overpass", {-2441.76806640625, 95.25958251953125, 472.5286865234375}, {-16.950772857666017, 66.34442291259766, 0}, "high explosive grenade", "Fakeduck (Ctrl)", "Throw", 0},
    {"de_overpass", {-455.64, 384.61, 91.26}, {-22.04, -149.05, 0}, "high explosive grenade", "Barrels", "Throw", 8},
    {"de_overpass", {-2087.02, 677.44, 320.03}, {4.4, -28.24, 0}, "high explosive grenade", "Plant", "Run+Throw", 5},
    {"de_overpass", {-1744.02, 1233.48, 417.83}, {-17.78, -140.39, 0}, "high explosive grenade", "Plant", "Throw", 22},
    {"de_overpass", {-2052.37, 1248.41, 420.03}, {-20.64, -87.12, 0}, "high explosive grenade", "Plant", "Throw", 22},
    {"de_overpass", {-2749.68, -1758.59, 536.03}, {18.12, 46.52, 0}, "high explosive grenade", "Fakeduck", "Jump+Throw", 22},
    {"de_overpass", {-1241.18, -172.76, 164.59}, {-42.6, 87.1, 0}, "high explosive grenade", "Water", "Throw", 1},
    {"de_overpass", {-398.23, 355.61, 90.97}, {-14.01, -158.23, 0}, "high explosive grenade", "Water", "Throw", 1},
    {"de_overpass", {-1093.5, -535.65, 158.95}, {-10.88, -107.46, 0}, "high explosive grenade", "Under-Water", "Run+Jump+Throw", 3},
    {"de_overpass", {-569.03, -1197.71, 154.89}, {0.59, 99.85, 0}, "high explosive grenade", "Barrels", "Run+Jump+Throw", 1},
    {"de_overpass", {-2413.51, 35.92, 466.82}, {-19.02, 89.45, 0}, "high explosive grenade", "Left Fakeduck (Ctrl)", "Throw", 1},
    {"de_overpass", {-2017.49, 712.84, 302.03}, {-6.61, -41.1, 0}, "high explosive grenade", "Right Plant (Ctrl)", "Throw", 1},
    {"de_overpass", {-1228.18, 294.12, 83.39}, {-52.68, -84.72, 0}, "high explosive grenade", "Back Side", "Throw", 1},
    {"de_safehouse", {1931.003, 90.58, 486.03}, {5.98, 148.01, 0}, "high explosive grenade", "Car (Ctrl)", "Throw", 1},
    {"de_safehouse", {970.78, 119.42, 305.46}, {-26.36, -0.15, 0}, "high explosive grenade", "Plant (Ctrl)", "Throw", 1},
    {"de_safehouse", {2023.56, 340.85, 429.07}, {-8.38, -112.82, 0}, "high explosive grenade", "Garage (Ctrl)", "Throw", 0},
    {"de_safehouse", {2383.5, 255.85, 796.18}, {9.43, 168.69, 0}, "high explosive grenade", "Car", "Throw", 0},
    {"de_safehouse", {1990.64, 185.97, 486.03}, {0.92, -178.16, 0}, "high explosive grenade", "Fakeduck (Ctrl)", "Throw", 0},
    {"de_shortdust", {-768.921936, 795.664001, 100.03125}, {6.8205275535583, -41.455672454834, 0}, "high explosive grenade", "Barrels", "Run+Jump+Throw", 0},
    {"de_shortdust", {-910.35992431641, 970.1240234375, 99.09381103515625}, {13.721249580383, -35.259700775146, 0}, "high explosive grenade", "Car", "Run+Jump+Throw", 4},
    {"de_shortdust", {-911.27862548828, 898.36340332031, 99.09381103515625}, {6.5889212608337, -40.6231980896, 0}, "high explosive grenade", "Fakeduck CT", "Run+Jump+Throw", 4},
    {"de_shortdust", {-227.63909912109, 531.01525878906, 47.09381103515625}, {-13.178354263306, 23.428928375244, 0}, "high explosive grenade", "Tunnel", "Run+Throw", 4},
    {"de_shortdust", {-179.1764831543, 414.03912353516, 63.09381103515625}, {-10.364782333374, 31.167345046997, 0}, "high explosive grenade", "Tunnel", "Run+Throw", 5},
    {"de_shortdust", {-176.642471, 1805.493286, 96.09381103515625}, {-6.5653779029846, -45.643031311035, 0}, "high explosive grenade", "Tunnel", "Run+Throw", 7},
    {"de_shortdust", {-912.1661987304688, 854.3309326171875, 99.03125}, {6.84832893371582, -39.04734390258789, 0}, "high explosive grenade", "Fakeduck CT", "Run+Jump+Throw", 0},
    {"de_shortdust", {-316.70916748046875, 595.51171875, 29.08521270751953}, {-8.886062622070312, 47.26227569580078, 0}, "high explosive grenade", "Under Tunnel", "Run+Throw", 22},
    {"de_shortdust", {686.96875, 951.9366455078125, 96.03125}, {-7.800016403198242, -143.05377197265625, 0}, "high explosive grenade", "Car ot steni", "Throw", 0},
    {"de_train", {1294.3596191406, 400.02493286133, -151.96875}, {-4.9444236755371, 175.48867797852, 0}, "high explosive grenade", "fiveseven-spot", "Throw", 0},
    {"de_train", {170.15757751464844, 470.3016357421875, -151.90618896484375}, {-36.68, -70.6205062866211, 0}, "high explosive grenade", "hae-site", "Run+Throw", 1},
    {"de_train", {-628.4265747070312, 557.722900390625, -151.96875}, {-1.281444549560547, -33.17278289794922, 0}, "high explosive grenade", "heaven-Fakelag-off", "Run+Jump+Throw", 1},
    {"de_train", {538.37, -553.87, -160.12}, {5.87, 98.59, 0}, "high explosive grenade", "Heaven", "Run+Jump+Throw", 1},
    {"de_mirage", {-2173.391357421875, 236.70388793945312, -95.96875}, {-13.937911987304688, 125.8508071899414, 0}, "high explosive grenade", "Car", "Throw", 1},
    {"de_mirage", {-1045.7613525390625, 508.0062255859375, -15.96875}, {-14.872919082641602, 27.208328247070312, 0}, "high explosive grenade", "Fakeduck", "Throw", 1},
    {"de_mirage", {-543.8424682617188, -1309.03125, -95.96875}, {-11.039438247680664, -74.42620086669922, 0}, "high explosive grenade", "One-way site", "Throw", 0},
    {"de_mirage", {-2152.4736328125, 788.3026733398438, -63.96875}, {-14.831171989440918, -6.505409240722656, 0}, "high explosive grenade", "Ups B", "Throw", 0},
    {"de_mirage", {-1177.5926513671875, -1174.515380859375, -103.96875}, {-2.802222967147827, 82.6501693725586, 0}, "high explosive grenade", "Under window", "Run+Throw", 1},
    {"de_mirage", {497.6351318359375, -1570.1383056640625, -196.78262329101562}, {-25.29862403869629, 178.2367401123047, 0}, "high explosive grenade", "Stairs", "Throw", 0},
    {"de_mirage", {-1180.7381591796875, 679.6217651367188, -15.96875}, {-9.351309776306152, 174.55308532714844, 0}, "high explosive grenade", "Car", "Throw", 0},
    {"de_mirage", {-36.230712890625, 821.3238525390625, -71.96875}, {-8.639360427856445, -150.7427215576172, 0}, "high explosive grenade", "Under", "Run+Throw", 5},
    {"de_mirage", {-798.22, -1488.25, -103.97}, {-15.66, -89.67, 0}, "high explosive grenade", "Boost", "Run+Throw", 2},
    {"de_mirage", {-821.17, -684.64, -205.67}, {-15.46, -49.4, 0}, "high explosive grenade", "One-way", "Run+Throw", 16},
    {"de_mirage", {-517.51, -1433.03, -36.35}, {-1.62, -71.12, 0}, "high explosive grenade", "Fakeduck (Ctrl)", "Throw", 15},
    {"de_mirage", {-1688.51, -668.03, -103.97}, {-7.07, 122.44, 0}, "high explosive grenade", "B plant", "Run+Throw", 12},
    {"de_mirage", {-1132, 657.84, -15.97}, {-2.57, -23.21, 0}, "high explosive grenade", "One-way", "Run+Throw", 23},
    {"de_mirage", {362.7731018066406, -1711.981689453125, -129.35638427734375}, {-12.263968467712402, 123.63943481445312, 0}, "high explosive grenade", "Fakeduck", "Run+Throw", 26},
    {"de_mirage", {637.1300048828125, -1442.285888671875, -199.96875}, {-11.592479705810547, -131.1429901123047, 0}, "high explosive grenade", " Near pit", "Run+Throw", 10},
    {"de_mirage", {18.04, -2226.97, 24.03}, {-3.5, 14.1, 0}, "high explosive grenade", "A box", "Run+Throw", 2},
    {"de_mirage", {-1033.08837890625, -162.3196258544922, -303.96875}, {-10.437341690063477, -76.62198638916016, 0}, "high explosive grenade", "Short", "Run+Throw", 22},
    {"de_mirage", {542.8782348632812, -2194.452880859375, 24.09381103515625}, {-3.4129526615142822, -161.49090270996095, 0}, "high explosive grenade", "Push", "Run+Throw", 4},
    {"de_mirage", {-1020.6661376953125, -341.7388916015625, -301.097900390625}, {-22.474211502075196, -103.01636199951172, 0}, "high explosive grenade", "Up ladder", "Run+Jump+Throw", 0},
    {"de_mirage", {-1177.55, 216.4, -106.44}, {-12.65, 150.63, 0}, "high explosive grenade", "Car", "Run+Throw", 8},
    {"de_mirage", {-38.82, -1554.13, -103.97}, {-37.32, 164.18, 0}, "high explosive grenade", "Stairs", "Throw", 8},
    {"de_mirage", {-30.73310661315918, 771.1280517578125, -71.96875}, {-25.506772994995117, -172.29470825195312, 0}, "high explosive grenade", "One-way", "Throw", 1},
    {"de_mirage", {-552.7010498046875, 353.0328063964844, -133.77085876464844}, {-21.332910537719727, 47.070621490478516, 0}, "high explosive grenade", "Push", "Throw", 1},
    {"de_mirage", {-784.009033203125, -736.09716796875, -200.07284545898438}, {-21.142772674560547, -46.71687698364258, 0}, "high explosive grenade", "Fakeduck", "Throw", 1},
    {"de_mirage", {-1359.5682373046875, 318.76190185546875, -103.96875}, {-7.809592247009277, 145.75094604492188, 0}, "high explosive grenade", "Plant", "Run+Throw", 1},
    {"de_mirage", {-2067.44970703125, -516.6715698242188, -103.96875}, {-10.954521656036377, 53.701255798339844, 0}, "high explosive grenade", "Left Plant", "Run+Throw", 17},
    {"de_mirage", {327.7995300292969, 232.4734344482422, -198.32464599609375}, {-9.896465301513672, 51.033721923828125, 0}, "high explosive grenade", "Stairs", "Throw", 1},
    {"de_mirage", {-709.6861572265625, -1250.7174072265625, -103.96875}, {-20.562904357910156, -51.9279670715332, 0}, "high explosive grenade", "Palace", "Run+Throw", 8},
    {"de_mirage", {-1168.4720458984375, -828.07861328125, -103.96875}, {5.8858113288879395, -134.01956176757812, 0}, "high explosive grenade", "Right Fakeduck", "Throw", 1},
    {"de_mirage", {-521.0642700195312, -652.4973754882812, -209.87774658203125}, {-15.719079971313477, -118.91386413574219, 0}, "high explosive grenade", "One-way", "Throw", 1},
    {"de_mirage", {-509.40667724609375, -712.40771484375, -200.01861572265625}, {-15.139333724975586, -135.27406311035156, 0}, "high explosive grenade", "Box Fakeduck", "Throw", 1},
    {"de_mirage", {1227.5638427734375, -1471.9833984375, -103.96875}, {-5.748178482055664, 58.6875114440918, 0}, "high explosive grenade", "Fakeduck", "Run+Throw", 12},
    {"de_aztec", {-687.3937, -790.2736, -312.3039}, {-20.45292, 113.4226, 0}, "high explosive grenade", "here Stone -93hp", "Run+Throw", 4},
    {"de_aztec", {-701.8319702148438, -327.07470703125, -159.96875}, {-9.834869, 162.928897, 0}, "high explosive grenade", "Stone", "Run+Throw", 19},
    {"de_aztec", {-965.1803, -623.9202, -243.7773}, {-23.56154, 98.40856, 0}, "high explosive grenade", " Nade", "Throw", 0},
    {"de_aztec", {-918.6672, -623.7685, -290.3039}, {-26.35401, 99.82077, 0}, "high explosive grenade", "Courtyard Stone", "Throw", 0},
    {"de_aztec", {-687.3937, -790.2736, -312.9688}, {-20.45292, 113.4226, 0}, "high explosive grenade", "Water Stone", "Run+Throw", 4},
    {"de_aztec", {-714.9734, -486.3677, -440.7693}, {-31.66595, -71.80219, 0}, "high explosive grenade", "here gen highdmg", "Run+Throw", 5},
    {"de_aztec_HT", {-687.3937, -790.2736, -312.3039}, {-20.45292, 113.4226, 0}, "high explosive grenade", "here Stone -93hp", "Run+Throw", 4},
    {"de_aztec_HT", {-701.8319702148438, -327.07470703125, -159.96875}, {-9.834869, 162.928897, 0}, "high explosive grenade", "Stone", "Run+Throw", 19},
    {"de_aztec_HT", {-965.1803, -623.9202, -243.7773}, {-23.56154, 98.40856, 0}, "high explosive grenade", " Nade", "Throw", 0},
    {"de_aztec_HT", {-918.6672, -623.7685, -290.3039}, {-26.35401, 99.82077, 0}, "high explosive grenade", "Courtyard Stone", "Throw", 0},
    {"de_aztec_HT", {-687.3937, -790.2736, -312.9688}, {-20.45292, 113.4226, 0}, "high explosive grenade", "Water Stone", "Run+Throw", 4},
    {"de_aztec_HT", {-714.9734, -486.3677, -440.7693}, {-31.66595, -71.80219, 0}, "high explosive grenade", "here gen highdmg", "Run+Throw", 5},
    {"de_vertigo", {-2197.573486328125, -246.98292541503906, 11680.03125}, {-23.90870475769043, 98.81021118164062, 0}, "high explosive grenade", "Big box", "Throw", 1},
    {"de_vertigo", {-2003.7171630859375, 86.54362487792969, 11616.03125}, {-20.28949737548828, 172.20169067382812, 0}, "high explosive grenade", "Fakeduck", "Throw", 1},
    {"de_vertigo", {-1839.6301269531, -214.72941589355, 11840.637695313}, {-13.315687179565, 66.154853820801, 0}, "high explosive grenade", "Fakeduck", "Throw", 1},
    {"de_vertigo", {-1439.7333984375, 966.6212158203125, 11840.03125}, {-6.444976806640625, -134.74258422851562, 0}, "high explosive grenade", "Plant (fakelag off)", "Run+Throw", 32},
    {"de_vertigo", {-1384.746826171875, 948.9892578125, 11840.03125}, {-15.411205291748047, -147.7166290283203, 0}, "high explosive grenade", "Fakeduck (fakelag off)", "Run+Throw", 21},
    {"de_vertigo", {-2018.661865, -549.567322, 11840.03125}, {2.517535591125488, 64.94662475585938, 0}, "high explosive grenade", "Fakeduck (fakelag off)", "Jump+Throw", 0},
    {"de_vertigo", {-603.66, -1305.6, 11729.47}, {-12.52, 50.59, 0}, "high explosive grenade", "Site/Box", "Run+Throw", 5},
    {"de_vertigo", {-642.6594848632812, -218.68661499023438, 11840.03125}, {-2.2028162479400635, -34.08245849609375, 0}, "high explosive grenade", "Site/Box", "Run+Throw", 15},
    {"de_vertigo", {-1699.87744140625, 733.7057495117188, 11840.03125}, {-11.92576789855957, -154.3043212890625, 0}, "high explosive grenade", "Box", "Throw", 1},
    {"de_bank", {995.7448120117188, -436.04388427734375, 36.75340270996094}, {-21.986146926879883, 174.04270935058594, 0}, "high explosive grenade", "Up", "Run+Throw", 10},
    {"de_bank", {-515.51, -628.86, 252.09}, {-1.99, 6.88, 0}, "high explosive grenade", "Car", "Run+Throw", 24},
    {"de_bank", {-261.69, -902.47, 252.03}, {0.19, 23.28, 0}, "high explosive grenade", "Car", "Run+Throw", 0},
    {"de_bank", {-481.63, -249.08, 207.03}, {-3.63, -4.44, 0}, "high explosive grenade", "Car", "Run+Throw", 3},
    {"de_bank", {-532.2, -243.56, 210.21}, {-3.57, -2.96, 0}, "high explosive grenade", "Car", "Run+Throw", 17},
    {"de_bank", {-444.82, -395.07, 252.21}, {-2.12, 1.49, 0}, "high explosive grenade", "Car", "Run+Throw", 6},
    {"de_bank", {643.35, -308.58, 16.75}, {-14.14, -12.04, 0}, "high explosive grenade", "Car", "Run+Throw", 1},
    {"de_bank", {1405.31, -1949.47, 87.75}, {-10.67, 56.73, 0}, "high explosive grenade", "Trash", "Throw", 1},
    {"de_bank", {1225.23, -369.31, 37.03}, {-16.81, -87.14, 0}, "high explosive grenade", "FBI Car", "Throw", 22},
    {"de_tulip", {6299.3696289063, 4425.8061523438, -55.88412475586}, {3.4833682060242, -138.59098815918, 0}, "high explosive grenade", "Boost", "Run+Jump+Throw", 22},
    {"de_tulip", {6262.509765625, 4549.84912109375, -59.96875}, {-25.941469192504883, -127.37826538085938, 0}, "high explosive grenade", "boost", "Run+Throw", 18},
    {"de_tulip", {6068.712890625, 2926.1301269531, 0.46875}, {14.135782089233, -136.14909362793, 0}, "high explosive grenade", "Fountain", "Run+Jump+Throw", 0},
    {"de_tulip", {5891.0732421875, 2735.432373046875, 0.03125}, {0.8948776721954346, 125.65182495117188, 0}, "high explosive grenade", "Boost-26hp fakelag-off", "Throw", 0},
    {"de_tulip_HT", {6299.3696289063, 4425.8061523438, -55.88412475586}, {3.4833682060242, -138.59098815918, 0}, "high explosive grenade", "Boost", "Run+Jump+Throw", 22},
    {"de_tulip_HT", {6262.509765625, 4549.84912109375, -59.96875}, {-25.941469192504883, -127.37826538085938, 0}, "high explosive grenade", "boost", "Run+Throw", 18},
    {"de_tulip_HT", {6068.712890625, 2926.1301269531, 0.46875}, {14.135782089233, -136.14909362793, 0}, "high explosive grenade", "Fountain", "Run+Jump+Throw", 0},
    {"de_tulip_HT", {5891.0732421875, 2735.432373046875, 0.03125}, {0.8948776721954346, 125.65182495117188, 0}, "high explosive grenade", "Boost-26hp fakelag-off", "Throw", 0},
    {"cs_agency", {-1123.9649658203, -258.65048217773, 576.03125}, {-10.129358520508, 59.272856903076, 0}, "high explosive grenade", "Table-96HP", "Run+Throw", 1},
    {"cs_agency", {-956.72924804688, 240.17779541016, 384.03125}, {-28.11051361084, 47.477611541748, 0}, "high explosive grenade", "Front Hall fakelag-off", "Run+Throw", 9},
    {"cs_agency", {-1123.965, -258.6505, 575.0313}, {-10.63936, 59.07286, 0}, "high explosive grenade", "Office Table[2]", "Run+Throw", 4},
    {"cs_agency", {-956.7292, 240.1778, 383.0313}, {-28.34405, 47.47761, 0}, "high explosive grenade", "Main Hall Front_Hall[1]", "Run+Throw", 11},
    {"cs_agency", {-1190.767, 194.2783, 384.0313}, {-28.32124, 82.86166, 0}, "high explosive grenade", "here FCorridor[1]", "Run+Throw", 1},
    {"cs_agency", {-1123.965, -258.6505, 586.0313}, {-10.12936, 59.27286, 0}, "high explosive grenade", "here Table[1]", "Run+Throw", 1},
    {"cs_office", {983.9835205078125, -331.8383483886719, -95.96875}, {-7.202581882476807, -149.14889526367188, 0}, "high explosive grenade", "Fakeduck", "Throw", 1},
    {"cs_office", {-497.5635681152344, -538.58984375, -202.99795532226562}, {-18.72443962097168, 7.40939474105835, 0}, "high explosive grenade", "Boxes", "Throw", 0},
    {"cs_office", {1013.5485229492, -667.89953613281, -95.96875}, {-2.577028274536, 97.964347839355, 0}, "high explosive grenade", "Trash", "Run+Throw", 13},
    {"cs_office", {1534.95, 922.02, -95.97}, {-5.38, -147.18, 0}, "high explosive grenade", "Sofa", "Run+Throw", 5},
    {"cs_office", {-103.35, -1084.66, -159.97}, {-12.54, 69.74, 0}, "high explosive grenade", "Barrels", "Run+Throw", 9},
    {"cs_office", {-17.43520164489746, -823.5162963867188, -151.96875}, {-14.316509246826172, 67.68290710449219, 0}, "high explosive grenade", "Barrels", "Throw", 1},
    {"cs_office", {-832.45, -67.78, -303.97}, {-3.64, 43.53, 0}, "high explosive grenade", "Barrels", "Throw", 9},
    {"cs_office", {981.7322387695312, -266.8387145996094, -95.96875}, {-6.950443267822266, 45.6572555541992, 0}, "high explosive grenade", "Paper (fakelag off)", "Run+Throw", 4},
    {"cs_office", {787.82, -494.36, -95.97}, {-4.91, -49.45, 0}, "high explosive grenade", "Fakeduck", "Throw", 9},
    {"cs_office", {-840.97, 537.1, -303.97}, {-2.82, -33.22, 0}, "high explosive grenade", "Barrels", "Throw", 9},
    {"de_cache", {592.7044677734375, 515.6970825195312, 1677.03125}, {-18.262537994384765, -162.76670532226564, 0}, "high explosive grenade", "Rip ESP", "Run+Throw", 9},
    {"de_cache", {624.07080078125, 417.5489196777344, 1677.0311279296875}, {-16.34968078613281, -167.93629150390626, 0}, "high explosive grenade", "Rip ESP", "Run+Throw", 9},
    {"de_cache", {85.21552276611328, 159.5667724609375, 1677.03125}, {12.351604461669922, 111.44610595703125, 0}, "high explosive grenade", "Barrels Fakeduck", "Run+Jump+Throw", 0},
    {"de_cache", {578.692139, -127.96553, 1807.700635}, {-3.7644648551941, 160.81787414551, 0}, "high explosive grenade", "Entrance", "Run+Throw", 14},
    {"de_cache", {292.2883, 2102.647, 1751.031}, {-16.83993, -141.5616, 0}, "high explosive grenade", "Squeaky Box", "Throw", 1},
    {"de_dust", {656.6302, 805.4576, 72.03125}, {-23.9471, -104.5455, 0}, "high explosive grenade", "One-way", "Throw", 1},
    {"de_dust", {301.23, 91.79, 71.81}, {-7.65, -163.59, 0}, "high explosive grenade", "Box", "Run+Throw", 1},
    {"de_nuke", {1336.028076171875, -618.1556396484375, -575.9061889648438}, {-5.354787826538086, 149.40060424804688, 0}, "high explosive grenade", "Ramp", "Run+Throw", 26},
    {"de_nuke", {1112.7235107421875, -1040.381591796875, -703.96875}, {-4.346846580505371, 138.84170532226562, 0}, "high explosive grenade", "Fakeduck", "Run+Throw", 6},
    {"de_nuke", {669.3499755859375, -454.39459228515625, -657.0711059570312}, {-13.946136474609375, -19.27132797241211, 0}, "high explosive grenade", "Window", "Throw", 0},
    {"de_nuke", {408.6708984375, -72.99930572509766, -575.96875}, {-4.165727138519287, -33.579708099365234, 0}, "high explosive grenade", "Window", "Run+Throw", 1},
    {"de_nuke", {830.4251708984375, 95.98638916015625, -575.96875}, {-3.8035197257995605, -95.6500015258789, 0}, "high explosive grenade", "Plant", "Run+Throw", 5},
    {"de_nuke", {340.0143737792969, -1279.52587890625, -568.96875}, {6.339123725891113, 29.01650619506836, 0}, "high explosive grenade", "Doors", "Throw", 0},
    {"de_nuke", {1391.96875, -847.1563110351562, -671.39990234375}, {-11.772736549377441, 128.69210815429688, 0}, "high explosive grenade", "Unpush", "Throw", 0},
    {"de_nuke", {1172.644775390625, -998.387939453125, -703.96875}, {-17.266681671142578, 44.596221923828125, 0}, "high explosive grenade", "Window", "Run+Throw", 1},
    {"de_nuke", {1111.975341796875, -373.0437927246094, -575.96875}, {-1.8715708255767822, -124.62555694580078, 0}, "high explosive grenade", "Plant", "Throw", 0},
    {"de_nuke", {704.1917724609375, -383.9068298339844, -625.6384887695312}, {8.271063804626465, -65.2789306640625, 0}, "high explosive grenade", "Doors", "Throw", 0},
    {"de_nuke", {778.8310546875, 57.4388427734375, -575.96875}, {-2.9582581520080566, -70.77649688720703, 0}, "high explosive grenade", "Window", "Run+Throw", 1},
    {"de_nuke", {1170.2197265625, -373.0448303222656, -575.96875}, {-1.44895601272583, -127.94245147705078, 0}, "high explosive grenade", "Door", "Run+Throw", 0},
    {"de_nuke", {1170.2578125, -552.0615234375, -575.96875}, {12.074569702148438, -47.52925109863281, 0}, "high explosive grenade", "Push doors", "Throw", 0},
    {"cs_italy", {-292.3274230957031, 1978.3468017578125, 64.03125}, {-2.1315019130706787, -59.44070053100586, 0}, "high explosive grenade", "Box", "Throw", 1},
    {"cs_italy", {81.78328704833984, 2001.384765625, 64.03125}, {-2.6925160884857178, -116.10157775878906, 0}, "high explosive grenade", "Box", "Throw", 1},
    {"cs_italy", {32.905662536621094, 2416.8134765625, 26.170696258544922}, {-20.05764389038086, -141.74081420898438, 0}, "high explosive grenade", "Push", "Throw", 2},
    {"cs_italy", {-33.21971893310547, 1187.2340087890625, -96.09356689453125}, {-20.637380599975586, 87.47865295410156, 0}, "high explosive grenade", "Fakeduck", "Run+Throw", 2},
    {"cs_italy", {-26.13906478881836, 1246.0318603515625, -87.96875}, {-29.158992767333984, 112.97683715820312, 0}, "high explosive grenade", "Most", "Throw", 1},
    {"cs_italy", {-910.2120361328125, 1253.7633056640625, 72.06330871582031}, {-22.956024169921875, -94.54740905761719, 0}, "high explosive grenade", "Under Most", "Throw", 1},
    {"cs_italy", {-504.59613037109375, 1182.6982421875, 8.03}, {9.854912757873535, 114.59285736083984, 0}, "high explosive grenade", "Push", "Run+Jump+Throw", 19},
    {"cs_italy", {855.8480834960938, 1609.6368408203125, 30.028339385986328}, {-4.243151664733887, 128.7999835205078, 0}, "high explosive grenade", "Fakeduck-93HP", "Run+Throw", 14},
    {"cs_italy", {-835.4000854492188, 1204.1595458984375, 64.03125}, {-2.1563305854797363, 63.26720428466797, 0}, "high explosive grenade", "Wine Cellar", "Run+Throw", 28},
    {"cs_italy", {183.69, 744.51, -99.1}, {7.61, -32.11, 0}, "high explosive grenade", "Trash", "Run+Jump+Throw", 1},
    {"cs_italy", {798.97, 499.41, -95.97}, {-16.37, -143.38, 0}, "high explosive grenade", "Trash", "Throw", 15},
    {"cs_italy", {150.69, -155.84, -87.97}, {12.98, 48.14, 0}, "high explosive grenade", "Trash", "Run+Jump+Throw", 1},
    {"cs_italy", {-108.16, -447.63, -87.97}, {-5.17, 149.94, 0}, "high explosive grenade", "Trash", "Throw", 1},
    {"de_stmarc", {-8175.8369140625, 6801.56640625, 104.19894409179688}, {-12.079442024230957, 5.280690670013428, 0}, "high explosive grenade", "Fakeduck", "Run+Throw", 4},
    {"de_stmarc", {-6840.3720703125, 6924.4267578125, 116.46635437011719}, {-7.845247745513916, 178.0292510986328, 0}, "high explosive grenade", "Car (Ctrl)", "Throw", 0},
    {"de_swamp", {1955.458740234375, 1000.7933349609375, -127.96875}, {-23.87014389038086, -115.66828155517578, 0}, "high explosive grenade", "Fakeduck", "Run+Throw", 1},
    {"de_shortnuke", {1172.644775390625, -998.387939453125, -703.96875}, {-17.266681671142578, 44.596221923828125, 0}, "high explosive grenade", "Window", "Run+Throw", 1},
    {"de_shortnuke", {1112.7235107421875, -1040.381591796875, -703.96875}, {-4.346846580505371, 138.84170532226562, 0}, "high explosive grenade", "Fakeduck", "Run+Throw", 6},
    {"de_shortnuke", {778.8310546875, 57.4388427734375, -575.96875}, {-2.9582581520080566, -70.77649688720703, 0}, "high explosive grenade", "Window", "Run+Throw", 1},
    {"de_shortnuke", {669.3499755859375, -454.39459228515625, -657.0711059570312}, {-13.946136474609375, -19.27132797241211, 0}, "high explosive grenade", "Window", "Throw", 0},
    {"de_shortnuke", {830.4251708984375, 95.98638916015625, -575.96875}, {-3.8035197257995605, -95.6500015258789, 0}, "high explosive grenade", "Plant", "Run+Throw", 5},
    {"de_shortnuke", {498.69366455078125, 78.31049346923828, -575.96875}, {-7.230602741241455, -106.215576171875, 0}, "high explosive grenade", "plant", "Run+Throw", 15},
    {"de_shortnuke", {1336.028076171875, -618.1556396484375, -575.9061889648438}, {-5.354787826538086, 149.40060424804688, 0}, "high explosive grenade", "Ramp fakelag-off", "Run+Throw", 26},
    {"de_shortnuke", {1391.97, -741.64, -619.06}, {-3.25, 152.51, 0}, "high explosive grenade", "Fakeduck (Ctrl)", "Throw", 36},
    {"de_shortnuke", {321.0423278808594, -775.643798828125, -707.96875}, {-17.854751586914062, 51.99918746948242, 0}, "high explosive grenade", "Plant", "Run+Throw", 11},
    {"de_dust2_old", {-117.45, 1329.9, 64.03}, {-8.34, 139.89, 0}, "high explosive grenade", "Best HE (CT)", "Run+Throw", 34},
    {"de_dust2_old", {334.23, 1796.44, 160.02}, {-8.19, 57.2, 0}, "high explosive grenade", "Plant box", "Run+Throw", 16},
    {"de_dust2_old", {-1214.34, 2533.24, 111.13}, {-31.55, 122.06, 0}, "high explosive grenade", "Right-Box", "Throw", 0},
    {"de_dust2_old", {-1144.12, 2596.78, 105.43}, {-9.28, 158.8, 0}, "high explosive grenade", "Fakeduck", "Throw", 0},
    {"de_dust2_old", {119.8, 1377.74, 64.03}, {-16.51, 55.12, 0}, "high explosive grenade", "Fakeduck", "Throw", 0},
    {"de_dust2_old", {-272.03, 1776, -63.07}, {8.56, 159.59, 0}, "high explosive grenade", "CT", "Jump+Throw", 0},
    {"de_dust2_old", {-447.5, 1704.06, -62.74}, {2.42, 62.08, 0}, "high explosive grenade", "Spawn", "Run+Throw", 2},
    {"de_dust2_old_bc", {-117.45, 1329.9, 64.03}, {-8.34, 139.89, 0}, "high explosive grenade", "Best HE (CT)", "Run+Throw", 34},
    {"de_dust2_old_bc", {334.23, 1796.44, 160.02}, {-8.19, 57.2, 0}, "high explosive grenade", "Plant box", "Run+Throw", 16},
    {"de_dust2_old_bc", {-1214.34, 2533.24, 111.13}, {-31.55, 122.06, 0}, "high explosive grenade", "Right-Box", "Throw", 0},
    {"de_dust2_old_bc", {-1144.12, 2596.78, 105.43}, {-9.28, 158.8, 0}, "high explosive grenade", "Fakeduck", "Throw", 0},
    {"de_dust2_old_bc", {119.8, 1377.74, 64.03}, {-16.51, 55.12, 0}, "high explosive grenade", "Fakeduck", "Throw", 0},
    {"de_dust2_old_bc", {-272.03, 1776, -63.07}, {8.56, 159.59, 0}, "high explosive grenade", "CT", "Jump+Throw", 0},
    {"de_dust2_old_bc", {-447.5, 1704.06, -62.74}, {2.42, 62.08, 0}, "high explosive grenade", "Spawn", "Run+Throw", 2},
    {"de_dust2_old_1", {-117.45, 1329.9, 64.03}, {-8.34, 139.89, 0}, "high explosive grenade", "Best HE (CT)", "Run+Throw", 34},
    {"de_dust2_old_1", {334.23, 1796.44, 160.02}, {-8.19, 57.2, 0}, "high explosive grenade", "Plant box", "Run+Throw", 16},
    {"de_dust2_old_1", {-1214.34, 2533.24, 111.13}, {-31.55, 122.06, 0}, "high explosive grenade", "Right-Box", "Throw", 0},
    {"de_dust2_old_1", {-1144.12, 2596.78, 105.43}, {-9.28, 158.8, 0}, "high explosive grenade", "Fakeduck", "Throw", 0},
    {"de_dust2_old_1", {119.8, 1377.74, 64.03}, {-16.51, 55.12, 0}, "high explosive grenade", "Fakeduck", "Throw", 0},
    {"de_dust2_old_1", {-272.03, 1776, -63.07}, {8.56, 159.59, 0}, "high explosive grenade", "CT", "Jump+Throw", 0},
    {"de_dust2_old_1", {-447.5, 1704.06, -62.74}, {2.42, 62.08, 0}, "high explosive grenade", "Spawn", "Run+Throw", 2},
    {"de_dust2_old_ht", {-117.45, 1329.9, 64.03}, {-8.34, 139.89, 0}, "high explosive grenade", "Best HE (CT)", "Run+Throw", 34},
    {"de_dust2_old_ht", {334.23, 1796.44, 160.02}, {-8.19, 57.2, 0}, "high explosive grenade", "Plant box", "Run+Throw", 16},
    {"de_dust2_old_ht", {-1214.34, 2533.24, 111.13}, {-31.55, 122.06, 0}, "high explosive grenade", "Right-Box", "Throw", 0},
    {"de_dust2_old_ht", {-1144.12, 2596.78, 105.43}, {-9.28, 158.8, 0}, "high explosive grenade", "Fakeduck", "Throw", 0},
    {"de_dust2_old_ht", {119.8, 1377.74, 64.03}, {-16.51, 55.12, 0}, "high explosive grenade", "Fakeduck", "Throw", 0},
    {"de_dust2_old_ht", {-272.03, 1776, -63.07}, {8.56, 159.59, 0}, "high explosive grenade", "CT", "Jump+Throw", 0},
    {"de_dust2_old_ht", {-447.5, 1704.06, -62.74}, {2.42, 62.08, 0}, "high explosive grenade", "Spawn", "Run+Throw", 2},
    {"de_dust2_old_uwu", {-117.45, 1329.9, 64.03}, {-8.34, 139.89, 0}, "high explosive grenade", "Best HE (CT)", "Run+Throw", 34},
    {"de_dust2_old_uwu", {334.23, 1796.44, 160.02}, {-8.19, 57.2, 0}, "high explosive grenade", "Plant box", "Run+Throw", 16},
    {"de_dust2_old_uwu", {-1214.34, 2533.24, 111.13}, {-31.55, 122.06, 0}, "high explosive grenade", "Right-Box", "Throw", 0},
    {"de_dust2_old_uwu", {-1144.12, 2596.78, 105.43}, {-9.28, 158.8, 0}, "high explosive grenade", "Fakeduck", "Throw", 0},
    {"de_dust2_old_uwu", {119.8, 1377.74, 64.03}, {-16.51, 55.12, 0}, "high explosive grenade", "Fakeduck", "Throw", 0},
    {"de_dust2_old_uwu", {-272.03, 1776, -63.07}, {8.56, 159.59, 0}, "high explosive grenade", "CT", "Jump+Throw", 0},
    {"de_dust2_old_uwu", {-447.5, 1704.06, -62.74}, {2.42, 62.08, 0}, "high explosive grenade", "Spawn", "Run+Throw", 2},
    {"de_dust2_se++", {-117.45, 1329.9, 64.03}, {-8.34, 139.89, 0}, "high explosive grenade", "Best HE (CT)", "Run+Throw", 34},
    {"de_dust2_se++", {334.23, 1796.44, 160.02}, {-8.19, 57.2, 0}, "high explosive grenade", "Plant box", "Run+Throw", 16},
    {"de_dust2_se++", {-1214.34, 2533.24, 111.13}, {-31.55, 122.06, 0}, "high explosive grenade", "Right-Box", "Throw", 0},
    {"de_dust2_se++", {-1144.12, 2596.78, 105.43}, {-9.28, 158.8, 0}, "high explosive grenade", "Fakeduck", "Throw", 0},
    {"de_dust2_se++", {119.8, 1377.74, 64.03}, {-16.51, 55.12, 0}, "high explosive grenade", "Fakeduck", "Throw", 0},
    {"de_dust2_se++", {-272.03, 1776, -63.07}, {8.56, 159.59, 0}, "high explosive grenade", "CT", "Jump+Throw", 0},
    {"de_dust2_se++", {-447.5, 1704.06, -62.74}, {2.42, 62.08, 0}, "high explosive grenade", "Spawn", "Run+Throw", 2},
    {"de_dust2_se", {-117.45, 1329.9, 64.03}, {-8.34, 139.89, 0}, "high explosive grenade", "Best HE (CT)", "Run+Throw", 34},
    {"de_dust2_se", {334.23, 1796.44, 160.02}, {-8.19, 57.2, 0}, "high explosive grenade", "Plant box", "Run+Throw", 16},
    {"de_dust2_se", {-1214.34, 2533.24, 111.13}, {-31.55, 122.06, 0}, "high explosive grenade", "Right-Box", "Throw", 0},
    {"de_dust2_se", {-1144.12, 2596.78, 105.43}, {-9.28, 158.8, 0}, "high explosive grenade", "Fakeduck", "Throw", 0},
    {"de_dust2_se", {119.8, 1377.74, 64.03}, {-16.51, 55.12, 0}, "high explosive grenade", "Fakeduck", "Throw", 0},
    {"de_dust2_se", {-272.03, 1776, -63.07}, {8.56, 159.59, 0}, "high explosive grenade", "CT", "Jump+Throw", 0},
    {"de_dust2_se", {-447.5, 1704.06, -62.74}, {2.42, 62.08, 0}, "high explosive grenade", "Spawn", "Run+Throw", 2},
    {"de_dust2_old_up", {-117.45, 1329.9, 64.03}, {-8.34, 139.89, 0}, "high explosive grenade", "Best HE (CT)", "Run+Throw", 34},
    {"de_dust2_old_up", {334.23, 1796.44, 160.02}, {-8.19, 57.2, 0}, "high explosive grenade", "Plant box", "Run+Throw", 16},
    {"de_dust2_old_up", {-1214.34, 2533.24, 111.13}, {-31.55, 122.06, 0}, "high explosive grenade", "Right-Box", "Throw", 0},
    {"de_dust2_old_up", {-1144.12, 2596.78, 105.43}, {-9.28, 158.8, 0}, "high explosive grenade", "Fakeduck", "Throw", 0},
    {"de_dust2_old_up", {119.8, 1377.74, 64.03}, {-16.51, 55.12, 0}, "high explosive grenade", "Fakeduck", "Throw", 0},
    {"de_dust2_old_up", {-272.03, 1776, -63.07}, {8.56, 159.59, 0}, "high explosive grenade", "CT", "Jump+Throw", 0},
    {"de_dust2_old_up", {-447.5, 1704.06, -62.74}, {2.42, 62.08, 0}, "high explosive grenade", "Spawn", "Run+Throw", 2},
    {"de_dust2_old_mrx", {-117.45, 1329.9, 64.03}, {-8.34, 139.89, 0}, "high explosive grenade", "Best HE (CT)", "Run+Throw", 34},
    {"de_dust2_old_mrx", {334.23, 1796.44, 160.02}, {-8.19, 57.2, 0}, "high explosive grenade", "Plant box", "Run+Throw", 16},
    {"de_dust2_old_mrx", {-1214.34, 2533.24, 111.13}, {-31.55, 122.06, 0}, "high explosive grenade", "Right-Box", "Throw", 0},
    {"de_dust2_old_mrx", {-1144.12, 2596.78, 105.43}, {-9.28, 158.8, 0}, "high explosive grenade", "Fakeduck", "Throw", 0},
    {"de_dust2_old_mrx", {119.8, 1377.74, 64.03}, {-16.51, 55.12, 0}, "high explosive grenade", "Fakeduck", "Throw", 0},
    {"de_dust2_old_mrx", {-272.03, 1776, -63.07}, {8.56, 159.59, 0}, "high explosive grenade", "CT", "Jump+Throw", 0},
    {"de_dust2_old_mrx", {-447.5, 1704.06, -62.74}, {2.42, 62.08, 0}, "high explosive grenade", "Spawn", "Run+Throw", 2},
    {"de_dust2_old_otp", {-117.45, 1329.9, 64.03}, {-8.34, 139.89, 0}, "high explosive grenade", "Best HE (CT)", "Run+Throw", 34},
    {"de_dust2_old_otp", {334.23, 1796.44, 160.02}, {-8.19, 57.2, 0}, "high explosive grenade", "Plant box", "Run+Throw", 16},
    {"de_dust2_old_otp", {-1214.34, 2533.24, 111.13}, {-31.55, 122.06, 0}, "high explosive grenade", "Right-Box", "Throw", 0},
    {"de_dust2_old_otp", {-1144.12, 2596.78, 105.43}, {-9.28, 158.8, 0}, "high explosive grenade", "Fakeduck", "Throw", 0},
    {"de_dust2_old_otp", {119.8, 1377.74, 64.03}, {-16.51, 55.12, 0}, "high explosive grenade", "Fakeduck", "Throw", 0},
    {"de_dust2_old_otp", {-272.03, 1776, -63.07}, {8.56, 159.59, 0}, "high explosive grenade", "CT", "Jump+Throw", 0},
    {"de_dust2_old_otp", {-447.5, 1704.06, -62.74}, {2.42, 62.08, 0}, "high explosive grenade", "Spawn", "Run+Throw", 2},
    {"de_dust2", {-99.97807312011719, 1333.609130859375, 64.79857635498047}, {10.182931804656983, 139.0959930419922, 0}, "high explosive grenade", "CT Spawn", "Run+Jump+Throw", 0},
    {"de_dust2", {335.939453125, 1791.4554443359375, 160.03125}, {-8.878296375274658, 57.51290512084961, 0}, "high explosive grenade", "A-Box", "Run+Throw", 22},
    {"de_dust2", {-1214.33, 2533.26, 117.84}, {-19.9, 125.9, 0}, "high explosive grenade", "Left-Box", "Throw", 0},
    {"de_dust2", {-1154.56, 2621.78, 131.9}, {-4.36, 163.35, 0}, "high explosive grenade", "Fakeduck", "Throw", 0},
    {"de_dust2", {-276.03, 1772, -37.51}, {1.56, 159.59, 0}, "high explosive grenade", "CT", "Jump+Throw", 0},
    {"de_dust2", {-416.08, 1773.33, -62.65}, {0.31, 64.63, 0}, "high explosive grenade", "Spawn", "Throw", 2},
    {"de_dust2", {130.58, 1334.05, 65.08}, {-14.66, 57.77, 0}, "high explosive grenade", "Fakeduck", "Run+Throw", -3},
    {"cs_assault", {5028.03125, 4440.9306640625, -543.96875}, {-4.565028190612793, -39.25461196899414, 0}, "high explosive grenade", "car", "Run+Throw", 3},
    {"cs_assault", {5042.77685546875, 4356.4990234375, -799.96875}, {-25.300151824951172, -36.75469970703125, 0}, "high explosive grenade", "car2", "Run+Throw", 3},
    {"cs_assault", {5834.3203125, 4474.19287109375, -809.96875}, {-38.1151123046875, -95.53984832763672, 0}, "high explosive grenade", "car3", "Throw", 0},
    {"gd_rialto", {-225.0385284423828, 43.242218017578125, 288.03125}, {-51.835357666015625, -7.485260963439941, 0}, "high explosive grenade", "One-way", "Run+Throw", 1},
    {"gd_rialto", {-657.360107421875, 709.5709838867188, 160.03125}, {-41.26045227050781, -41.000579833984375, 0}, "high explosive grenade", "Roof", "Run+Throw", 3},
    {"gd_rialto", {234.99375915527344, 7.205482006072998, 288.03125}, {-51.04185485839844, -178.90574645996094, 0}, "high explosive grenade", "Roof", "Run+Throw", 1},
    {"gd_rialto", {390.07269287109375, -444.25128173828125, 213.9654083251953}, {-7.888189315795898, 137.41482543945312, 0}, "high explosive grenade", "Plant", "Run+Throw", 2},
    {"gd_rialto", {-204.06932067871094, -63.39451217651367, 593.85986328125}, {22.325172424316406, 2.7596023082733154, 0}, "high explosive grenade", "Plant", "Run+Throw", 6},
    {"gd_rialto", {248.8062286376953, 0.4104073643684387, 619.03125}, {31.320512771606445, -179.70718383789062, 0}, "high explosive grenade", "Plant", "Run+Throw", 7},
    {"gd_rialto", {423.952392578125, 108.00133514404297, 288.03125}, {-6.867362976074219, -162.24012756347656, 0}, "high explosive grenade", "Plant", "Throw", 0},
    {"gd_rialto", {172.48260498046875, -725.0706787109375, 160.03125}, {-24.849159240722656, 119.72855377197266, 0}, "high explosive grenade", "Side Fakeduck", "Throw", 0},
    {"de_guard", {401.6592712402344, -1580.5986328125, -111.96875}, {-9.276509284973145, 120.36446380615234, 0}, "high explosive grenade", "Box", "Throw", 1},
    {"de_guard", {367.96, -256.45, 72.03}, {-4.17, -100.6, 0}, "high explosive grenade", "Truck", "Run+Throw", 20},
    {"de_guard", {620.61, -51.94, 65.25}, {10.17, -107.54, 0}, "high explosive grenade", "Short One-way", "Run+Jump+Throw", 2},
    {"de_guard", {814.35, 14.36, 228.03}, {-38.37, -74.33, 0}, "high explosive grenade", "Short One-way", "Throw", 22},
    {"de_elysion", {-337.1941833496094, 63.131858825683594, 9728.03125}, {7.754693031311035, 9.125452995300293, 0}, "high explosive grenade", "Fakeduck", "Jump+Throw", 0},
    {"de_elysion", {-194.00038146972656, 169.2692413330078, 9728.03125}, {8.469687461853027, -12.929821014404297, 0}, "high explosive grenade", "Right Side", "Jump+Throw", 0},
    {"de_elysion", {-675.6004638671875, 66.67803192138672, 9728.03125}, {-14.96, 6.55, 0}, "high explosive grenade", "best hae", "Run+Throw", 20},
    {"de_elysion", {547.562255859375, -373.7716369628906, 9664.03125}, {-8.470314979553223, 54.58503723144531, 0}, "high explosive grenade", "Fakeduck", "Run+Throw", 18},
    {"de_elysion", {-388.18756103515625, 73.87593841552734, 9728.03125}, {4.289790153503418, 9.369359016418457, 0}, "high explosive grenade", "Fakeduck", "Jump+Throw", 0},
    {"de_elysion", {-378.64300537109375, 153.75814819335938, 9728.03125}, {9.789690971374512, -5.700649738311768, 0}, "high explosive grenade", "Right Side", "Jump+Throw", 0},
}
local cachedmaps = {}
local cachedoneways = {}

local vector_add = function(vec1, vec2) 
    newVec = {vec1[0] + vec2[0], vec1[1] + vec2[1], vec1[2] + vec2[2]}
    return newVec;
end

local degreesToRadians = function(radians)
    local arifemtic = (radians * math.pi / 180)
    return arifemtic
end

local vector_sub = function(vec1, vec2)
    return {vec1[1] - vec2.x, vec1[2] - vec2.y, vec1[3] - vec2.z};
end

local vector_add = function(vec1, vec2)
    newVec = {vec1[1] + vec2[1], vec1[2] + vec2[2], vec1[3] + vec2[3]};
    return newVec;
end
local vec_mul_fl = function(vec1, vec2)
    return {vec1[1] * vec2, vec1[2] * vec2, vec1[3] * vec2};
end

local getNadeName = function(id)
    local string = ""
    if id == 'CHEGrenade' then
        string = "high explosive grenade"
    elseif id == 'CIncendiaryGrenade'  or id == 'CMolotovGrenade' then
        string = "molotov"
    else
        string = "none"
    end
    return tostring(string)
end
local angle_to_vec = function(x, y)
    local vecx = degreesToRadians(x);
    local vecy = degreesToRadians(y);
    local vectorx = math.sin(vecx);
    local vectory = math.cos(vecx);
    local vectorz = math.sin(vecy);
    local vectoroffset = math.cos(vecy);
    return {(vectory * vectoroffset), (vectory * vectorz), (vectorx / -1)}
end

local previoustrails = {}
local can_shift_shot = function(tts)
    local me = g_EntityList:GetClientEntity(g_EngineClient:GetLocalPlayer()):GetPlayer()
    if me == nil then return end
    local wpn = me:GetActiveWeapon()
    if (me == null or wpn == null) then
        return false;
    end
    local player = g_EntityList:GetLocalPlayer()
    local tickbase = player:GetProp("m_nTickBase");
    local curtime = g_GlobalVars.interval_per_tick * (tickbase - tts)

    if (curtime < player:GetProp("m_flNextAttack")) then
        return false;
    end
    if (curtime < wpn:GetProp("m_flNextPrimaryAttack")) then
        return false;
    end
    return true;
end
local quest = function(cond , T , F )
    if cond then return true else return false end
end
local recharge = function()
    local is_charged = exploits.GetCharge()
    if (can_shift_shot(16) and is_charged ~= 1) then
        exploits.AllowCharge(true)
        exploits.ForceCharge()
    end

    exploits.OverrideDoubleTapSpeed(16)
end

local trails = function()
    local local_player_index    = g_EngineClient:GetLocalPlayer()
    local local_player          = g_EntityList:GetClientEntity(local_player_index):GetPlayer()
    local me = g_EntityList:GetClientEntity(g_EngineClient:GetLocalPlayer())
    if local_player and local_player:GetProp("m_iHealth") > 0 then
        local r = math.floor(math.sin(g_GlobalVars.realtime * 2) * 127 + 128)
        local g =  math.floor(math.sin(g_GlobalVars.realtime * 2 + 2) * 127 + 128)
        local b = math.floor(math.sin(g_GlobalVars.realtime * 2 + 4) * 127 + 128)    
        local localplayer = g_EntityList:GetClientEntity(g_EngineClient:GetLocalPlayer())
        local origin = localplayer:GetRenderOrigin()
        previoustrails[#previoustrails+1] = { x = origin.x, y = origin.y, z = origin.z, tick = tonumber(g_GlobalVars.tickcount) + 50, draw = true, r = r, g = g, b = b}
        for i = 1, #previoustrails do
            if i > 2 then
                local trail = previoustrails[i]
                local trailtwo = previoustrails[i - 1]
                    local s = Vector.new(trail.x,trail.y,trail.z)
                    local stwo = Vector.new(trailtwo.x,trailtwo.y,trailtwo.z)
                    local beam_info = BeamInfo_t.new()
                    beam_info.m_vecStart = s
                    beam_info.m_vecEnd = stwo
                    beam_info.m_nSegments = 2
                    beam_info.m_nType = 0
                    beam_info.m_bRenderable = true
                    beam_info.m_nFlags = 0
                    beam_info.m_pszModelName = "sprites/purplelaser1.vmt"
                    beam_info.m_flHaloScale = 0.0
                    beam_info.m_flLife = TrailLength:GetInt() / 100
                    beam_info.m_flWidth = TrailSize:GetInt()
                    beam_info.m_flEndWidth = TrailSize:GetInt()
                    beam_info.m_flFadeLength = 0.0
                    beam_info.m_flAmplitude = 0.0
                    beam_info.m_flSpeed = 0.0
                    beam_info.m_flFrameRate = 0.0
                    beam_info.m_nHaloIndex = 0
                    beam_info.m_nStartFrame = 0
                    beam_info.m_flBrightness = 255.0
                    if TrailColor:GetBool() then
                        beam_info.m_flRed = r
                        beam_info.m_flGreen = g
                        beam_info.m_flBlue = b
                    elseif TrailColor:GetBool() == false then
                        beam_info.m_flRed = TrailColor:GetColor():r() * 255
                        beam_info.m_flGreen = TrailColor:GetColor():g() * 255
                        beam_info.m_flBlue = TrailColor:GetColor():b() * 255
                    end

                    g_RenderBeams:CreateBeamPoints(beam_info)
                    if i > 3 then
                        table.remove(previoustrails, i - 2)
                    end
            end
        end
    end
end

local toleng = 0

local customscope = function()
    local sc = g_EngineClient:GetScreenSize()
    local player = g_EntityList:GetLocalPlayer()
    local scoped = player:GetProp("m_bIsScoped");
    local gui = g_CVar:FindVar("r_drawvgui")
    if scoped then
        if toleng < (ScopeOrigin:GetInt() / 2 + ScopeWidth:GetInt()) then toleng = toleng + 2 else toleng = (ScopeOrigin:GetInt() / 2 + ScopeWidth:GetInt()) end
        gui:SetInt(0);
        g_Render:GradientBoxFilled(Vector2.new(sc.x / 2 - 0.1, sc.y / 2 - math.min(ScopeOrigin:GetInt(), toleng)), Vector2.new(sc.x / 2 + 1, sc.y / 2 - math.min(ScopeOrigin:GetInt(), toleng) - math.min(ScopeWidth:GetInt(), toleng)), CustomScope:GetColor(), CustomScope:GetColor(), Color.new(CustomScope:GetColor():r() * 255, CustomScope:GetColor():g() * 255, CustomScope:GetColor():b() * 255,  0), Color.new(CustomScope:GetColor():r() * 255, CustomScope:GetColor():g() * 255, CustomScope:GetColor():b() * 255,  0))
        g_Render:GradientBoxFilled(Vector2.new(sc.x / 2 - math.min(ScopeOrigin:GetInt(), toleng), sc.y / 2 - 0.1), Vector2.new(sc.x / 2 - math.min(ScopeOrigin:GetInt(), toleng) - math.min(ScopeWidth:GetInt(), toleng), sc.y / 2  + 1), CustomScope:GetColor(), Color.new(CustomScope:GetColor():r() * 255, CustomScope:GetColor():g() * 255, CustomScope:GetColor():b() * 255,  0), CustomScope:GetColor(), Color.new(CustomScope:GetColor():r() * 255, CustomScope:GetColor():g() * 255, CustomScope:GetColor():b() * 255,  0))
        g_Render:GradientBoxFilled(Vector2.new(sc.x / 2 - 0.1, sc.y / 2 + math.min(ScopeOrigin:GetInt(), toleng)), Vector2.new(sc.x / 2 + 1, sc.y / 2  + math.min(ScopeOrigin:GetInt(), toleng) + math.min(ScopeWidth:GetInt(), toleng)), CustomScope:GetColor(), CustomScope:GetColor(), Color.new(CustomScope:GetColor():r() * 255, CustomScope:GetColor():g() * 255, CustomScope:GetColor():b() * 255,  0), Color.new(CustomScope:GetColor():r() * 255, CustomScope:GetColor():g() * 255, CustomScope:GetColor():b() * 255,  0))
        g_Render:GradientBoxFilled(Vector2.new(sc.x / 2 + math.min(ScopeOrigin:GetInt(), toleng), sc.y / 2 - 0.1), Vector2.new(sc.x / 2  + math.min(ScopeOrigin:GetInt(), toleng) + math.min(ScopeWidth:GetInt(), toleng), sc.y / 2  + 1), CustomScope:GetColor(), Color.new(CustomScope:GetColor():r() * 255, CustomScope:GetColor():g() * 255, CustomScope:GetColor():b() * 255,  0), CustomScope:GetColor(), Color.new(CustomScope:GetColor():r() * 255, CustomScope:GetColor():g() * 255, CustomScope:GetColor():b() * 255,  0))
    else
        if toleng > 0 then toleng = toleng - 2 else toleng = 0 end
        gui:SetInt(1);
    end
end

local showNades = function()
    local me = g_EntityList:GetClientEntity(g_EngineClient:GetLocalPlayer()):GetPlayer()
    if(me:GetProp("m_iHealth") == 0) then return end
    if me == nil then return end
    local wpn = me:GetActiveWeapon()
    if not wpn:IsGrenade() then return end
    if #cachedmaps == 0 then
        for i = 1, #locations do
            local map = locations[i]
            if g_EngineClient:GetLevelNameShort() == map[1] then
                cachedmaps[#cachedmaps+1] = map
            end
        end
    else
        for f = 1, #cachedmaps do
            local nade = cachedmaps[f]
            if g_EngineClient:GetLevelNameShort() ~= nade[1] then 
                cachedmaps = {}
                return
            end
            local me = g_EntityList:GetClientEntity(g_EngineClient:GetLocalPlayer()):GetPlayer()
            if me == nil then return end
            local wpn = me:GetActiveWeapon()
            local localplayer = g_EntityList:GetClientEntity(g_EngineClient:GetLocalPlayer())
            local origin = localplayer:GetPlayer():GetEyePosition()
            local vec = Vector.new(origin.x, origin.y, origin.z)
            local distance = vec:DistTo(Vector.new(nade[2][1], nade[2][2], nade[2][3]))
            local trace = g_EngineTrace:TraceRay(Vector.new(origin.x, origin.y, origin.z), Vector.new(nade[2][1], nade[2][2], nade[2][3]), localplayer, 0x200400B)
            if (GHOnlyVisible:GetBool() == true) then
                    if(trace.fraction > 0.96) then
                        if getNadeName(wpn:GetClassName()) == nade[4] then
                            local localplayer = g_EntityList:GetClientEntity(g_EngineClient:GetLocalPlayer())
                            local origin = localplayer:GetRenderOrigin()
                            local vec = Vector.new(origin.x, origin.y, origin.z)
                            local distance = vec:DistTo(Vector.new(nade[2][1], nade[2][2], nade[2][3]))
                            if(distance > 150) then
                                local sp =  g_Render:ScreenPosition(Vector.new(nade[2][1], nade[2][2], nade[2][3] - 40))
                                local ts = g_Render:CalcTextSize("nade", 16)
                                local sc = g_EngineClient:GetScreenSize()
                                g_Render:GradientBoxFilled(Vector2.new(sp.x - ts.x/2, sp.y), Vector2.new(sp.x, sp.y+ts.y), Color.new(0, 0, 0, 0), Color.new(0, 0, 0, 0.5), Color.new(0, 0, 0, 0), Color.new(0, 0, 0, 0.5))
                                g_Render:GradientBoxFilled(Vector2.new(sp.x, sp.y), Vector2.new(sp.x + ts.x/2, sp.y+ts.y), Color.new(0, 0, 0, 0.5), Color.new(0, 0, 0, 0), Color.new(0, 0, 0, 0.5), Color.new(0, 0, 0, 0))
                                if getNadeName(wpn:GetClassName()) == 'molotov' then
                                    local icon_size = g_Render:CalcWeaponIconSize(46, 16)
                                    g_Render:WeaponIcon(46, Vector2.new(sp.x- icon_size.x/2, sp.y), Color.new(1.0, 1.0, 1.0), 16)
                                elseif getNadeName(wpn:GetClassName()) == 'high explosive grenade' then
                                    local icon_size = g_Render:CalcWeaponIconSize(44, 16)
                                    g_Render:WeaponIcon(44, Vector2.new(sp.x - icon_size.x/2, sp.y), Color.new(1.0, 1.0, 1.0), 16)
                                end
                            else 
                                local sp =  g_Render:ScreenPosition(Vector.new(nade[2][1], nade[2][2], nade[2][3] - 40))
                                local ts = g_Render:CalcTextSize(tostring(nade[5] .. " | " .. nade[6]), 16)
                                local sc = g_EngineClient:GetScreenSize()
                                g_Render:GradientBoxFilled(Vector2.new(sp.x - ts.x/2, sp.y), Vector2.new(sp.x, sp.y+ts.y), Color.new(0, 0, 0, 0), Color.new(0, 0, 0, 0.5), Color.new(0, 0, 0, 0), Color.new(0, 0, 0, 0.5))
                                g_Render:GradientBoxFilled(Vector2.new(sp.x, sp.y), Vector2.new(sp.x + ts.x/2, sp.y+ts.y), Color.new(0, 0, 0, 0.5), Color.new(0, 0, 0, 0), Color.new(0, 0, 0, 0.5), Color.new(0, 0, 0, 0))
                                g_Render:Text(tostring(nade[5] .. " | " .. nade[6]), Vector2.new(sp.x - ts.x/2, sp.y), Color.new(1.0, 1.0, 1.0, 1.0), 16, font)
                            end
                            if(distance < 80) then
                                local sp =  g_Render:ScreenPosition(Vector.new(nade[2][1], nade[2][2], nade[2][3] - 40))
                                local ts = g_Render:CalcTextSize(tostring(nade[5] .. " | " .. nade[6]), 16)
                                local sc = g_EngineClient:GetScreenSize()
                                local aimAngle = angle_to_vec(nade[3][1], nade[3][2])
                                local vector = nade[2];
                                local aA = g_Render:ScreenPosition(Vector.new(vector[1] + aimAngle[1] * 400, vector[2] + aimAngle[2] * 400, vector[3] + aimAngle[3 ] * 400))
                                g_Render:Circle(Vector2.new(aA.x, aA.y), 6.0, 30, Color.new(1.0, 1.0, 1.0, 1.0))
                                g_Render:Line(Vector2.new(sc.x/2,sc.y/2), Vector2.new(aA.x, aA.y), Color.new(1.0, 1.0, 1.0, 1.0))
                            end
                        end
                    end
            else
                if getNadeName(wpn:GetClassName()) == nade[4] then
                    local localplayer = g_EntityList:GetClientEntity(g_EngineClient:GetLocalPlayer())
                            local origin = localplayer:GetRenderOrigin()
                            local vec = Vector.new(origin.x, origin.y, origin.z)
                            local distance = vec:DistTo(Vector.new(nade[2][1], nade[2][2], nade[2][3]))
                            if(distance > 150) then
                                local sp = g_Render:ScreenPosition(Vector.new(nade[2][1], nade[2][2], nade[2][3] - 40))
                                local ts = g_Render:CalcTextSize("nade", 16)
                                local sc = g_EngineClient:GetScreenSize()
                                g_Render:GradientBoxFilled(Vector2.new(sp.x - ts.x/2, sp.y), Vector2.new(sp.x, sp.y+ts.y), Color.new(0, 0, 0, 0), Color.new(0, 0, 0, 0.5), Color.new(0, 0, 0, 0), Color.new(0, 0, 0, 0.5))
                                g_Render:GradientBoxFilled(Vector2.new(sp.x, sp.y), Vector2.new(sp.x + ts.x/2, sp.y+ts.y), Color.new(0, 0, 0, 0.5), Color.new(0, 0, 0, 0), Color.new(0, 0, 0, 0.5), Color.new(0, 0, 0, 0))
                                if getNadeName(wpn:GetClassName()) == 'molotov' then
                                    local icon_size = g_Render:CalcWeaponIconSize(46, 16)
                                    g_Render:WeaponIcon(46, Vector2.new(sp.x- icon_size.x/2, sp.y), Color.new(1.0, 1.0, 1.0), 16)
                                elseif getNadeName(wpn:GetClassName()) == 'high explosive grenade' then
                                    local icon_size = g_Render:CalcWeaponIconSize(44, 16)
                                    g_Render:WeaponIcon(44, Vector2.new(sp.x - icon_size.x/2, sp.y), Color.new(1.0, 1.0, 1.0), 16)
                                end
                            else 
                                local sp =  g_Render:ScreenPosition(Vector.new(nade[2][1], nade[2][2], nade[2][3] - 40))
                                local ts = g_Render:CalcTextSize(tostring(nade[5] .. " | " .. nade[6]), 16)
                                local sc = g_EngineClient:GetScreenSize()
                                g_Render:GradientBoxFilled(Vector2.new(sp.x - ts.x/2, sp.y), Vector2.new(sp.x, sp.y+ts.y), Color.new(0, 0, 0, 0), Color.new(0, 0, 0, 0.5), Color.new(0, 0, 0, 0), Color.new(0, 0, 0, 0.5))
                                g_Render:GradientBoxFilled(Vector2.new(sp.x, sp.y), Vector2.new(sp.x + ts.x/2, sp.y+ts.y), Color.new(0, 0, 0, 0.5), Color.new(0, 0, 0, 0), Color.new(0, 0, 0, 0.5), Color.new(0, 0, 0, 0))
                                g_Render:Text(tostring(nade[5] .. " | " .. nade[6]), Vector2.new(sp.x - ts.x/2, sp.y), Color.new(1.0, 1.0, 1.0, 1.0), 16, font)
                            end
                            if(distance < 80) then
                                local sp =  g_Render:ScreenPosition(Vector.new(nade[2][1], nade[2][2], nade[2][3] - 40))
                                local ts = g_Render:CalcTextSize(tostring(nade[5] .. " | " .. nade[6]), 16)
                                local sc = g_EngineClient:GetScreenSize()
                                local aimAngle = angle_to_vec(nade[3][1], nade[3][2])
                                local vector = nade[2];
                                local aA = g_Render:ScreenPosition(Vector.new(vector[1] + aimAngle[1] * 400, vector[2] + aimAngle[2] * 400, vector[3] + aimAngle[3 ] * 400))
                                g_Render:Circle(Vector2.new(aA.x, aA.y), 6.0, 30, Color.new(1.0, 1.0, 1.0, 1.0))
                                g_Render:Line(Vector2.new(sc.x/2,sc.y/2), Vector2.new(aA.x, aA.y), Color.new(1.0, 1.0, 1.0, 1.0))
                            end
                end
            end
        end
    end
end
local movement = function(to_pos, curr_pos, view)
    local diff_x = curr_pos.x - to_pos.x
    local diff_y = curr_pos.y - to_pos.y
        
    local yaw = view.yaw

    local translatedVelocity = { diff_x * math.cos(yaw/180*math.pi) + diff_y*math.sin(yaw/180*math.pi), diff_y * math.cos(yaw/180*math.pi) - diff_x*math.sin(yaw/180*math.pi) }
    
    return { -translatedVelocity[1]*40, translatedVelocity[2]*40}
end

local tick = 0
local start_tick = 0
local run_start = 0
local running = false
local attacked = false
local nadeHelper = function(cmd)
    if #cachedmaps == 0 then return end
    local AutoStrafe = g_Config:FindVar("Miscellaneous", "Main", "Movement", "Auto Strafe")
    local RageBot = g_Config:FindVar("Aimbot", "Ragebot", "Main", "Enable Ragebot")
    local Exploit1 = g_Config:FindVar("Aimbot", "Ragebot", "Exploits", "Double Tap")
    local Exploit2 = g_Config:FindVar("Aimbot", "Ragebot", "Exploits", "Hide Shots")
    local Exploit3 = g_Config:FindVar("Aimbot", "Anti Aim", "Fake Lag", "Enable Fake Lag")
    if running == true then
        if runtype == 1 then
            nade = cachedmaps[1]
            local localplayer = g_EntityList:GetClientEntity(g_EngineClient:GetLocalPlayer())
            local origin = localplayer:GetPlayer():GetEyePosition()
            local aimAngle = angle_to_vec(nade[3][1], nade[3][2])
            local vector = nade[2];
            local forward = Vector.new(vector[1] + aimAngle[1] * 400, vector[2] + aimAngle[2] * 400, vector[3] + aimAngle[3 ] * 400)  
            if GHSilentThrow:GetBool() == true and RageBot:GetBool() == true then
                cmd.viewangles = QAngle.new(nade[3][1], nade[3][2], nade[3][3])    
                elseif GHSilentThrow:GetBool() == true and RageBot:GetBool() == false then
                if notified == false then
                    notified = true
                    cheat.AddNotify("WARNING", "Silent throw works correctly with rage config!")
                GHSilentThrow:SetBool(false)
                end
                cmd.viewangles = QAngle.new(nade[3][1], nade[3][2], nade[3][3])     
            else
                g_EngineClient:SetViewAngles(QAngle.new(nade[3][1], nade[3][2], nade[3][3]))
            end
            cmd.viewangles = QAngle.new(nade[3][1], nade[3][2], nade[3][3])  
            local viewangles = g_EngineClient:GetViewAngles()  
            local moveTo = movement(forward, origin, viewangles)
            cmd.sidemove = moveTo[2]
            cmd.forwardmove = moveTo[1]
            cmd.buttons = cmd.buttons and 1 
            local localplayer = g_EntityList:GetClientEntity(g_EngineClient:GetLocalPlayer())
            local origin = localplayer:GetRenderOrigin()
            local vec = Vector.new(origin.x, origin.y, origin.z)
            local distance = vec:DistTo(Vector.new(nade[2][1], nade[2][2], nade[2][3]))
            local angletoaim = angle_to_vec(nade[3][1], nade[3][2]);
            angletoaim = vec_mul_fl(angletoaim, 130);
            local vectorsub = vector_sub(vector_add(angletoaim, nade[2]),vec);
            local hypot = mathhypot(vectorsub[1], vectorsub[2]);
            if (hypot < 80) then
                if attacked == false then
                    cmd.buttons = 2
                    throw = throw + 1
                    if throw >= 20 then 
                        running = false
                        throw = 0
                        notified = false
                        attacked = false
                    end
                end
            end
        
        elseif runtype == 2 then
            nade = cachedmaps[1]
            if GHSilentThrow:GetBool() == true and RageBot:GetBool() == true then
                cmd.viewangles = QAngle.new(nade[3][1], nade[3][2], nade[3][3])    
                elseif GHSilentThrow:GetBool() == true and RageBot:GetBool() == false then
                if notified == false then
                    notified = true
                    cheat.AddNotify("WARNING", "Silent throw works correctly with rage config!")
                GHSilentThrow:SetBool(false)
                end
                cmd.viewangles = QAngle.new(nade[3][1], nade[3][2], nade[3][3])     
            else
                g_EngineClient:SetViewAngles(QAngle.new(nade[3][1], nade[3][2], nade[3][3]))
            end
            if attacked == false then
                cmd.viewangles = QAngle.new(nade[3][1], nade[3][2], nade[3][3])  
                if g_GlobalVars.tickcount >= start_tick then
                    cmd.viewangles = QAngle.new(nade[3][1], nade[3][2], nade[3][3])  
                    cmd.buttons = cmd.buttons and 1 
                    attacked = true
                end
            else
                cmd.viewangles = QAngle.new(nade[3][1], nade[3][2], nade[3][3])  
                if g_GlobalVars.tickcount >= start_tick + 10 then
                    throw = 0
                    notified = false
                    start_tick = 0
                    running = false
                    attacked = false
                end
            end
        elseif runtype == 3 then
            nade = cachedmaps[1]
            if GHSilentThrow:GetBool() == true and RageBot:GetBool() == true then
                cmd.viewangles = QAngle.new(nade[3][1], nade[3][2], nade[3][3])    
            elseif GHSilentThrow:GetBool() == true and RageBot:GetBool() == false then
                if notified == false then
                    notified = true
                    cheat.AddNotify("WARNING", "Silent throw works correctly with rage config!")
                GHSilentThrow:SetBool(false)
                end
                cmd.viewangles = QAngle.new(nade[3][1], nade[3][2], nade[3][3])     
            else
                g_EngineClient:SetViewAngles(QAngle.new(nade[3][1], nade[3][2], nade[3][3]))
            end
            attacked = false
            if attacked == false then
                throw = throw + 1
                if throw >= 20 then 
                    cmd.buttons = cmd.buttons and 1 
                    if throw >= 50 then
                        running = false
                        throw = 0
                        notified = false
                        attacked = false
                    end
                end
            end
        elseif runtype == 4 then
            nade = cachedmaps[1]  
            local localplayer = g_EntityList:GetClientEntity(g_EngineClient:GetLocalPlayer())
            local origin = localplayer:GetPlayer():GetEyePosition()
            local aimAngle = angle_to_vec(nade[3][1], nade[3][2])
            local vector = nade[2];
            local forward = Vector.new(vector[1] + aimAngle[1] * 400, vector[2] + aimAngle[2] * 400, vector[3] + aimAngle[3 ] * 400)                  
            if run_start == 0 then run_start = g_GlobalVars.tickcount end
            if GHSilentThrow:GetBool() == true and RageBot:GetBool() == true then
                cmd.viewangles = QAngle.new(nade[3][1], nade[3][2], nade[3][3])    
            elseif GHSilentThrow:GetBool() == true and RageBot:GetBool() == false then
                if notified == false then
                    notified = true
                    cheat.AddNotify("WARNING", "Silent throw works correctly with rage config!")
                GHSilentThrow:SetBool(false)
                end
                cmd.viewangles = QAngle.new(nade[3][1], nade[3][2], nade[3][3])     
            else
                g_EngineClient:SetViewAngles(QAngle.new(nade[3][1], nade[3][2], nade[3][3]))
            end   
            cmd.viewangles = QAngle.new(nade[3][1], nade[3][2], nade[3][3])  
            local viewangles = g_EngineClient:GetViewAngles()  
            local moveTo = movement(forward, origin, viewangles)
            cmd.forwardmove = moveTo[1]
            cmd.sidemove = moveTo[2]
            if(attacked == false) then cmd.buttons = 1 end
            if(run_start > 0 and g_GlobalVars.tickcount - run_start > nade[7]) then
                attacked = true
                if(run_start > 0 and g_GlobalVars.tickcount - run_start > nade[7] + 8) then
                    running = false
                    run_start = 0
                end
            end
        elseif runtype == 5 then
            cmd.buttons = 2048 
            nade = cachedmaps[1]
             if GHSilentThrow:GetBool() == true and RageBot:GetBool() == true then
                cmd.viewangles = QAngle.new(nade[3][1], nade[3][2], nade[3][3])    
            elseif GHSilentThrow:GetBool() == true and RageBot:GetBool() == false then
                if notified == false then
                    notified = true
                    cheat.AddNotify("WARNING", "Silent throw works correctly with rage config!")
                GHSilentThrow:SetBool(false)
                end
                cmd.viewangles = QAngle.new(nade[3][1], nade[3][2], nade[3][3])     
            else
                g_EngineClient:SetViewAngles(QAngle.new(nade[3][1], nade[3][2], nade[3][3]))
            end
            cmd.buttons = cmd.buttons and 2048 
            attacked = false
            if attacked == false then
                cmd.buttons = cmd.buttons and 2
                throw = throw + 1
                if throw >= 20 then 
                    running = false
                    throw = 0
        notified = false
                    attacked = false
                end
            end
        elseif runtype == 6 then
            cmd.buttons = 2048 
            nade = cachedmaps[1]
             if GHSilentThrow:GetBool() == true and RageBot:GetBool() == true then
                cmd.viewangles = QAngle.new(nade[3][1], nade[3][2], nade[3][3])    
            elseif GHSilentThrow:GetBool() == true and RageBot:GetBool() == false then
                if notified == false then
                    notified = true
                    cheat.AddNotify("WARNING", "Silent throw works correctly with rage config!")
                GHSilentThrow:SetBool(false)
                end
                cmd.viewangles = QAngle.new(nade[3][1], nade[3][2], nade[3][3])     
            else
                g_EngineClient:SetViewAngles(QAngle.new(nade[3][1], nade[3][2], nade[3][3]))
            end
            cmd.buttons = 2048 
            attacked = false
            if attacked == false then
                throw = throw + 1
                if throw >= 20 then 
                    cmd.buttons = 2048 
                    running = false
                    throw = 0
        notified = false
                    attacked = false
                end
            end
        end
        
        return
    end
    if running == true then return end
    -- if AutoStrafe:GetBool() == false then AutoStrafe:SetBool(true) end
    if Exploit3:GetBool() == false then Exploit3:SetBool(true) end
    if #cachedmaps == 0 then return end
    for i = 1, #cachedmaps do
        local cachednade = cachedmaps[i]
        if g_EngineClient:GetLevelNameShort() ~= cachednade[1] then 
            cachedmaps = {}
            for i = 1, #locations do
                local map = locations[i]
                if g_EngineClient:GetLevelNameShort() == map[1] then
                    cachedmaps[#cachedmaps+1] = map
                end
            end
        end
        local localplayer = g_EntityList:GetClientEntity(g_EngineClient:GetLocalPlayer())
        local origin = localplayer:GetPlayer():GetEyePosition()
        local me = g_EntityList:GetClientEntity(g_EngineClient:GetLocalPlayer()):GetPlayer()
        if me == nil then return end
        local wpn = me:GetActiveWeapon()
        if getNadeName(wpn:GetClassName()) == cachednade[4] then
            local vec = Vector.new(origin.x, origin.y, origin.z)
            local distance = vec:DistTo(Vector.new(cachednade[2][1], cachednade[2][2], cachednade[2][3]))
            if distance < 100 then
                if sorted == false then
                    table.sort(cachedmaps, function(a,b) 
                        if a[4] == getNadeName(wpn:GetClassName()) then
                            return vec:DistTo(Vector.new(a[2][1], a[2][2], a[2][3])) < vec:DistTo(Vector.new(b[2][1], b[2][2], b[2][3])) 
                        else 
                        
                        end
                    end) 
                    sorted = true
                else
                    local nade = cachedmaps[1]
                    local localplayer = g_EntityList:GetClientEntity(g_EngineClient:GetLocalPlayer())
                    local origin = localplayer:GetPlayer():GetEyePosition()
                    local vec = Vector.new(origin.x, origin.y, origin.z)
                    local me = g_EntityList:GetClientEntity(g_EngineClient:GetLocalPlayer()):GetPlayer()
                    if me == nil then return end
                    local wpn = me:GetActiveWeapon()
                    if getNadeName(wpn:GetClassName()) == nade[4] then
                    local dist = vec:DistTo(Vector.new(nade[2][1], nade[2][2], nade[2][3]))
                    local Exploit1 = g_Config:FindVar("Aimbot", "Ragebot", "Exploits", "Double Tap")
                    local Exploit2 = g_Config:FindVar("Aimbot", "Ragebot", "Exploits", "Hide Shots")
                    local Exploit3 = g_Config:FindVar("Aimbot", "Anti Aim", "Fake Lag", "Enable Fake Lag")
                    Exploit1:SetBool(false)
                    Exploit2:SetBool(false)
                    Exploit3:SetBool(false)
                    if dist > 1 and dist < 100 and autostrafed <= 0 then
                        local viewangles = g_EngineClient:GetViewAngles()
                        local moveTo = movement(Vector.new(nade[2][1], nade[2][2], nade[2][3]), origin, viewangles)
                        cmd.forwardmove = moveTo[1]
                        cmd.sidemove = moveTo[2]
                    elseif dist <= 1 then
                        local velocity = Vector.new(localplayer:GetProp("DT_BasePlayer", "m_vecVelocity[0]"), localplayer:GetProp("DT_BasePlayer", "m_vecVelocity[1]"), localplayer:GetProp("DT_BasePlayer", "m_vecVelocity[2]")):Length2D()
                        if(velocity <= 0) then
                            timeout = timeout + 1
                            if timeout >= 20 then
                                if AutoStrafe:GetBool() then AutoStrafe:SetBool(false) end
                                autostrafed = 100
                                if (nade[6] == 'Run+Jump+Throw') then
                                    runtype = 1
                                    running = true
                                    throw = 0
                                    notified = false
                                    timeout = 0
                                    tick = 0
                                    Exploit1:SetBool(false)
                                elseif nade[6] == "Jump+Throw" then
                                    cmd.buttons = cmd.buttons and 1 
                                    cmd.buttons = cmd.buttons and 2
                                    start_tick = g_GlobalVars.tickcount + nade[7]
                                    timeout = 0
                                    runtype = 2
                                    running = true
                                    throw = 0
                                    notified = false
                                    tick = 0
                                    Exploit1:SetBool(false)
                                elseif nade[6] == "Throw" then
                                    cmd.buttons = cmd.buttons and 1 
                                    runtype = 3
                                    running = true
                                    throw = 0
                                    notified = false
                                    timeout = 0
                                    tick = 0
                                    Exploit1:SetBool(false)
                                elseif nade[6] == "Run+Throw" then
                                    cmd.buttons = cmd.buttons and 1 
                                    runtype = 4
                                    running = true
                                    throw = 0
                                    notified = false
                                    timeout = 0
                                    tick = 0
                                    Exploit1:SetBool(false)
                                elseif nade[6] == "Jump+Half throw" then
                                    cmd.buttons = cmd.buttons and 2048 
                                    runtype = 5
                                    running = true
                                    throw = 0
                                    notified = false
                                    timeout = 0
                                    tick = 0
                                    Exploit1:SetBool(false)
                                elseif nade[6] == "Half throw" then
                                    cmd.buttons = cmd.buttons and 2048 
                                    runtype = 6
                                    running = true
                                    throw = 0
                                    notified = false
                                    timeout = 0
                                    tick = 0
                                    Exploit1:SetBool(false)
                                end
                                end
                            end
                    end
                    else
                        sorted = false
                    end
                end
            end
        end
    end
end

local alpha = {
    0,
    0,
    0,
    0,
    0,
    0,
}

local LowdeltaPreset = function()
     antiaim.OverrideYawOffset(0.0)
     antiaim.OverrideLimit(-20.0)
     antiaim.OverrideLBYOffset(21)
 end

local LegitAAPreset = function(cmd)
    cmd.buttons = bit.band(cmd.buttons, bit.bnot(32))
    if antiaim.GetInverterState() then
        antiaim.OverrideLBYOffset(-60)
    else
        antiaim.OverrideLBYOffset(60)
    end
        antiaim.OverrideYawOffset(180.0)
        antiaim.OverrideLimit(60)
        antiaim.OverridePitch(0.0)
 end

local manualalpha = 0
local manualminus = false
local tolengf = 0
local manuals = function()
    local local_player_index    = g_EngineClient:GetLocalPlayer()
    local local_player          = g_EntityList:GetClientEntity(local_player_index):GetPlayer()
    local me = g_EntityList:GetClientEntity(g_EngineClient:GetLocalPlayer())
    if local_player and local_player:GetProp("m_iHealth") > 0 then
        if manualminus == false then
            if manualalpha < 255 then manualalpha = manualalpha + 2 else manualminus = true end
        else
            if manualalpha > 0 then manualalpha = manualalpha - 2 else manualminus = false end
        end
        local manual = g_Config:FindVar("Aimbot", "Anti Aim", "Main", "Yaw Base")
        local sc = g_EngineClient:GetScreenSize()
        local x = sc.x/2
        local y = sc.y/2
        local player = g_EntityList:GetLocalPlayer()
        local scoped = player:GetProp("m_bIsScoped");
        local gui = g_CVar:FindVar("r_drawvgui")
        if scoped and CustomScope:GetBool() then 
            if tolengf < (ScopeOrigin:GetInt() + ScopeWidth:GetInt()) then tolengf = tolengf + 2 else tolengf = (ScopeOrigin:GetInt() + ScopeWidth:GetInt()) end
        else
            if tolengf > 0 then tolengf = tolengf - 2 else tolengf = 0 end
        end
        local arrow = 40 + tolengf
        g_Render:PolyFilled(Color.new(0.0, 0.0, 0.0, 0.5), Vector2.new(x+arrow, y-10), Vector2.new(x+arrow, y+10), Vector2.new(x+arrow+20, y), Vector2.new(x+arrow, y-10))
        g_Render:PolyFilled(Color.new(0.0, 0.0, 0.0, 0.5), Vector2.new(x-arrow, y-10), Vector2.new(x-arrow, y+10), Vector2.new(x-arrow-20, y), Vector2.new(x-arrow, y-10))
        if manual:GetInt() == 1 then     --backward
            -- g_Render:PolyFilled(Color.new(1.0, 1.0, 1.0, 1.0), Vector2.new(x-20, y-10), Vector2.new(x-20, y+10), Vector2.new(x-40, y))
        elseif manual:GetInt() == 2 then --right
            g_Render:PolyFilled(Color.new(manualcolors:GetColor():r(), manualcolors:GetColor():g(), manualcolors:GetColor():b(), manualalpha/255), Vector2.new(x+arrow, y-10), Vector2.new(x+arrow, y+10), Vector2.new(x+arrow+20, y), Vector2.new(x+arrow, y-10))
        elseif manual:GetInt() == 3 then --left
            g_Render:PolyFilled(Color.new(manualcolors:GetColor():r(), manualcolors:GetColor():g(), manualcolors:GetColor():b(), manualalpha/255), Vector2.new(x-arrow, y-10), Vector2.new(x-arrow, y+10), Vector2.new(x-arrow-20, y), Vector2.new(x-arrow, y-10))
        end
    end
end

local showOneways = function()
    local me = g_EntityList:GetClientEntity(g_EngineClient:GetLocalPlayer()):GetPlayer()
    if me == nil then return end
    if(me:GetProp("m_iHealth") == 0) then return end
    if #cachedoneways == 0 then
        for i = 1, #onewaylocations do
            local map = onewaylocations[i]
            if g_EngineClient:GetLevelNameShort() == map[1] then
                cachedoneways[#cachedoneways+1] = map
            end
        end
    else
        for f = 1, #cachedoneways do
            local nade = cachedoneways[f]
            if g_EngineClient:GetLevelNameShort() ~= nade[1] then 
                cachedoneways = {}
                return
            end
            local me = g_EntityList:GetClientEntity(g_EngineClient:GetLocalPlayer()):GetPlayer()
            if me == nil then return end
            local wpn = me:GetActiveWeapon()
            local localplayer = g_EntityList:GetClientEntity(g_EngineClient:GetLocalPlayer())
            local origin = localplayer:GetPlayer():GetEyePosition()
            local vec = Vector.new(origin.x, origin.y, origin.z)
            local distance = vec:DistTo(Vector.new(nade[5][1], nade[5][2], nade[5][3]))
            local trace = g_EngineTrace:TraceRay(Vector.new(origin.x, origin.y, origin.z), Vector.new(nade[5][1], nade[5][2], nade[5][3]), localplayer, 0x200400B)
            if (OWOnlyVisible:GetBool() == true) then
                    if(trace.fraction > 0.96) then
                        local localplayer = g_EntityList:GetClientEntity(g_EngineClient:GetLocalPlayer())
                        local origin = localplayer:GetRenderOrigin()
                        local vec = Vector.new(origin.x, origin.y, origin.z)
                        local distance = vec:DistTo(Vector.new(nade[5][1], nade[5][2], nade[5][3]))
                        if(distance > 150) then
                            local sp =  g_Render:ScreenPosition(Vector.new(nade[5][1], nade[5][2], nade[5][3]))
                            local ts = g_Render:CalcTextSize("nade", 16)
                            local sc = g_EngineClient:GetScreenSize()
                            g_Render:GradientBoxFilled(Vector2.new(sp.x - ts.x/2, sp.y), Vector2.new(sp.x, sp.y+ts.y), Color.new(0, 0, 0, 0), Color.new(0, 0, 0, 0.5), Color.new(0, 0, 0, 0), Color.new(0, 0, 0, 0.5))
                            g_Render:GradientBoxFilled(Vector2.new(sp.x, sp.y), Vector2.new(sp.x + ts.x/2, sp.y+ts.y), Color.new(0, 0, 0, 0.5), Color.new(0, 0, 0, 0), Color.new(0, 0, 0, 0.5), Color.new(0, 0, 0, 0))
                            local is = g_Render:CalcWeaponIconSize(50, 26)
                            g_Render:WeaponIcon(50, Vector2.new(sp.x - 5, sp.y), Color.new(1.0, 1.0, 1.0), 16)
                        else 
                            local sp =  g_Render:ScreenPosition(Vector.new(nade[5][1], nade[5][2], nade[5][3]))
                            local ts = 0
                            local sc = g_EngineClient:GetScreenSize()
                            ts = g_Render:CalcTextSize(tostring(nade[2]), 16)
                            g_Render:GradientBoxFilled(Vector2.new(sp.x - ts.x/2, sp.y), Vector2.new(sp.x, sp.y+ts.y), Color.new(0, 0, 0, 0), Color.new(0, 0, 0, 0.5), Color.new(0, 0, 0, 0), Color.new(0, 0, 0, 0.5))
                            g_Render:GradientBoxFilled(Vector2.new(sp.x, sp.y), Vector2.new(sp.x + ts.x/2, sp.y+ts.y), Color.new(0, 0, 0, 0.5), Color.new(0, 0, 0, 0), Color.new(0, 0, 0, 0.5), Color.new(0, 0, 0, 0))
                            g_Render:Text(tostring(nade[2]), Vector2.new(sp.x - ts.x/2, sp.y), Color.new(1.0, 1.0, 1.0, 1.0), 16, font)
                            ts = g_Render:CalcTextSize(tostring(nade[3]), 16)
                            g_Render:GradientBoxFilled(Vector2.new(sp.x - ts.x/2, sp.y + 15), Vector2.new(sp.x, sp.y + 15+ts.y), Color.new(0, 0, 0, 0), Color.new(0, 0, 0, 0.5), Color.new(0, 0, 0, 0), Color.new(0, 0, 0, 0.5))
                            g_Render:GradientBoxFilled(Vector2.new(sp.x, sp.y + 15), Vector2.new(sp.x + ts.x/2, sp.y + 15+ts.y), Color.new(0, 0, 0, 0.5), Color.new(0, 0, 0, 0), Color.new(0, 0, 0, 0.5), Color.new(0, 0, 0, 0))
                            g_Render:Text(tostring(nade[3]), Vector2.new(sp.x - ts.x/2, sp.y + 15), Color.new(1.0, 1.0, 1.0, 1.0), 16, font)
                            local sp =  g_Render:ScreenPosition(Vector.new(nade[5][1], nade[5][2], nade[5][3]))
                            local aimAngle = angle_to_vec(nade[6][1], nade[6][2])
                            local vector = nade[5];
                            local aA = g_Render:ScreenPosition(Vector.new(vector[1] + aimAngle[1] * 70, vector[2] + aimAngle[2] * 70, vector[3] + aimAngle[3 ] * 70))
                            g_Render:Line(Vector2.new(sp.x, sp.y+25+ts.y), Vector2.new(aA.x, aA.y), Color.new(1.0, 1.0, 1.0, 1.0))
                            g_Render:Circle(Vector2.new(aA.x, aA.y), 6.0, 30, Color.new(1.0, 1.0, 1.0, 1.0))
                        end
                    end
            else
                local localplayer = g_EntityList:GetClientEntity(g_EngineClient:GetLocalPlayer())
                        local origin = localplayer:GetRenderOrigin()
                        local vec = Vector.new(origin.x, origin.y, origin.z)
                        local distance = vec:DistTo(Vector.new(nade[5][1], nade[5][2], nade[5][3]))
                        if(distance > 150) then
                            local sp =  g_Render:ScreenPosition(Vector.new(nade[5][1], nade[5][2], nade[5][3]))
                            local ts = g_Render:CalcTextSize("nade", 16)
                            local sc = g_EngineClient:GetScreenSize()
                            g_Render:GradientBoxFilled(Vector2.new(sp.x - ts.x/2, sp.y), Vector2.new(sp.x, sp.y+ts.y), Color.new(0, 0, 0, 0), Color.new(0, 0, 0, 0.5), Color.new(0, 0, 0, 0), Color.new(0, 0, 0, 0.5))
                            g_Render:GradientBoxFilled(Vector2.new(sp.x, sp.y), Vector2.new(sp.x + ts.x/2, sp.y+ts.y), Color.new(0, 0, 0, 0.5), Color.new(0, 0, 0, 0), Color.new(0, 0, 0, 0.5), Color.new(0, 0, 0, 0))
                            local is = g_Render:CalcWeaponIconSize(50, 26)
                            g_Render:WeaponIcon(50, Vector2.new(sp.x - 5, sp.y), Color.new(1.0, 1.0, 1.0), 16)
                        else 
                            local sp =  g_Render:ScreenPosition(Vector.new(nade[5][1], nade[5][2], nade[5][3]))
                            local ts = 0
                            local sc = g_EngineClient:GetScreenSize()
                            ts = g_Render:CalcTextSize(tostring(nade[2]), 16)
                            g_Render:GradientBoxFilled(Vector2.new(sp.x - ts.x/2, sp.y), Vector2.new(sp.x, sp.y+ts.y), Color.new(0, 0, 0, 0), Color.new(0, 0, 0, 0.5), Color.new(0, 0, 0, 0), Color.new(0, 0, 0, 0.5))
                            g_Render:GradientBoxFilled(Vector2.new(sp.x, sp.y), Vector2.new(sp.x + ts.x/2, sp.y+ts.y), Color.new(0, 0, 0, 0.5), Color.new(0, 0, 0, 0), Color.new(0, 0, 0, 0.5), Color.new(0, 0, 0, 0))
                            g_Render:Text(tostring(nade[2]), Vector2.new(sp.x - ts.x/2, sp.y), Color.new(1.0, 1.0, 1.0, 1.0), 16, font)
                            ts = g_Render:CalcTextSize(tostring(nade[3]), 16)
                            g_Render:GradientBoxFilled(Vector2.new(sp.x - ts.x/2, sp.y + 15), Vector2.new(sp.x, sp.y + 15+ts.y), Color.new(0, 0, 0, 0), Color.new(0, 0, 0, 0.5), Color.new(0, 0, 0, 0), Color.new(0, 0, 0, 0.5))
                            g_Render:GradientBoxFilled(Vector2.new(sp.x, sp.y + 15), Vector2.new(sp.x + ts.x/2, sp.y + 15+ts.y), Color.new(0, 0, 0, 0.5), Color.new(0, 0, 0, 0), Color.new(0, 0, 0, 0.5), Color.new(0, 0, 0, 0))
                            g_Render:Text(tostring(nade[3]), Vector2.new(sp.x - ts.x/2, sp.y + 15), Color.new(1.0, 1.0, 1.0, 1.0), 16, font)
                            local sp =  g_Render:ScreenPosition(Vector.new(nade[5][1], nade[5][2], nade[5][3]))
                            local aimAngle = angle_to_vec(nade[6][1], nade[6][2])
                            local vector = nade[5];
                            local aA = g_Render:ScreenPosition(Vector.new(vector[1] + aimAngle[1] * 70, vector[2] + aimAngle[2] * 70, vector[3] + aimAngle[3 ] * 70))
                            g_Render:Line(Vector2.new(sp.x, sp.y+25+ts.y), Vector2.new(aA.x, aA.y), Color.new(1.0, 1.0, 1.0, 1.0))
                            g_Render:Circle(Vector2.new(aA.x, aA.y), 6.0, 30, Color.new(1.0, 1.0, 1.0, 1.0))
                        end 
            end
        end
    end
end

local sc = g_EngineClient:GetScreenSize()
local SpecX = sc.x/2 - sc.x/8
local SpecY = sc.y/2
local SpecDrag = false
local BindsX = sc.x/2 + sc.x/8
local BindsY = sc.y/2
local BindsDrag = false
local spectatorList = function()
    local players = g_EntityList:GetPlayers()
    local speclist = {}
    local local_player = g_EntityList:GetLocalPlayer()
    for table_index, player_pointer in pairs(players) do
        if player_pointer and player_pointer:GetProp("m_iHealth") <= 0 then
            local local_player = g_EntityList:GetLocalPlayer()
            if(local_player:GetProp("m_iHealth") > 0) then
                local player = player_pointer
                local spec_handle = player:GetProp("m_hObserverTarget")
                local spec_player = g_EntityList:GetClientEntityFromHandle(spec_handle)
                if spec_player ~= nil then
                    if spec_player:GetPlayer() == local_player:GetPlayer() then
                        speclist[#speclist+1] = player_pointer:GetName()
                    end
                end
            else 
                local observer = player_pointer:GetProp('m_hObserverTarget')
                local player = g_EntityList:GetLocalPlayer()
                local localtarget = player:GetProp('m_hObserverTarget')
                if observer == localtarget then
                    speclist[#speclist+1] = player_pointer:GetName()
                end
            end
        end
       
    end
    if #speclist > 0 or cheat.IsMenuVisible() then
        local ts = g_Render:CalcTextSize("Spectator list", 16)
        local sc = g_EngineClient:GetScreenSize()
        g_Render:GradientBoxFilled(Vector2.new(SpecX - 120, SpecY + 0 * 17), Vector2.new(SpecX, SpecY + 0 * 17+ts.y), Color.new(0, 0, 0, 0), Color.new(0, 0, 0, 0.5), Color.new(0, 0, 0, 0), Color.new(0, 0, 0, 0.5))
        g_Render:GradientBoxFilled(Vector2.new(SpecX, SpecY + 0 * 17), Vector2.new(SpecX + 120, SpecY + 0 * 17+ts.y), Color.new(0, 0, 0, 0.5), Color.new(0, 0, 0, 0), Color.new(0, 0, 0, 0.5), Color.new(0, 0, 0, 0))
        g_Render:Text("Spectator list", Vector2.new(SpecX - ts.x/2, SpecY + 0 * 17), Color.new(1.0, 1.0, 1.0, 1.0), 16)
        for i = 1, #speclist do
            local ts = g_Render:CalcTextSize(speclist[i], 16)
            local sc = g_EngineClient:GetScreenSize()
            g_Render:Text(speclist[i], Vector2.new(SpecX - ts.x/2, SpecY + i * 17), Color.new(1.0, 1.0, 1.0, 1.0), 16)
        end

        local is_key_pressed = cheat.IsKeyDown(0x1)
        if is_key_pressed then
            local mouse = cheat.GetMousePos()
            local ts = g_Render:CalcTextSize("Spectator list", 16)
            if SpecDrag == true then
                SpecX = mouse.x
                SpecY = mouse.y
            end
            if mouse.x >= SpecX - 120 and mouse.y >= SpecY and mouse.x <= SpecX - 120 + 240 and mouse.y <= SpecY + ts.y then
                if BindsDrag == false then SpecDrag = true end
            end
        else
            SpecDrag = false
        end
    end
end

local keysList = {
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
}

local keybindsList = function()
    local binds = cheat.GetBinds()
    if #binds > 0 or cheat.IsMenuVisible() then
        for i = 1, #binds do
            if binds[i]:IsActive() then
                if keysList[i] < 255 then keysList[i] = keysList[i] + 5 else keysList[i] = 255 end
            else
                if keysList[i] > 0 then keysList[i] = keysList[i] - 5 else keysList[i] = 0 end
            end
                local ts = g_Render:CalcTextSize(binds[i]:GetValue(), 14)
                local sc = g_EngineClient:GetScreenSize()
                g_Render:Text(binds[i]:GetName(), Vector2.new(BindsX - 90, BindsY + i * math.min(17, keysList[i])), Color.new(1.0, 1.0, 1.0, keysList[i]/255), 14)
                if string.len(binds[i]:GetValue()) > 10 then
                    local a = -string.len(binds[i]:GetValue()) + 10
                    fs = g_Render:CalcTextSize(binds[i]:GetValue():sub(0,a), 14)
                    g_Render:Text(binds[i]:GetValue():sub(0,a) .. "..", Vector2.new(BindsX + 90 - fs.x, BindsY + i * math.min(17, keysList[i])), Color.new(1.0, 1.0, 1.0, keysList[i]/255), 14)
                else 
                    fs = g_Render:CalcTextSize(binds[i]:GetValue():sub(0,-15), 14)
                    g_Render:Text(binds[i]:GetValue(), Vector2.new(BindsX + 90 - fs.x, BindsY + i * math.min(17, keysList[i])), Color.new(1.0, 1.0, 1.0, keysList[i]/255), 14)
                end
        end
        local sc = g_EngineClient:GetScreenSize()
        local ts = g_Render:CalcTextSize('Keybinds', 16)
        g_Render:GradientBoxFilled(Vector2.new(BindsX-120, BindsY + 0 * 17), Vector2.new(BindsX, BindsY + 0 * 17+ts.y), Color.new(0, 0, 0, 0), Color.new(0, 0, 0, 0.5), Color.new(0, 0, 0, 0), Color.new(0, 0, 0, 0.5))
        g_Render:GradientBoxFilled(Vector2.new(BindsX, BindsY + 0 * 17), Vector2.new(BindsX + 120, BindsY + 0 * 17+ts.y), Color.new(0, 0, 0, 0.5), Color.new(0, 0, 0, 0), Color.new(0, 0, 0, 0.5), Color.new(0, 0, 0, 0))
        g_Render:Text("Keybinds", Vector2.new(BindsX - ts.x/2, BindsY + 0 * 17), Color.new(1.0, 1.0, 1.0, 1.0), 16)
        local is_key_pressed = cheat.IsKeyDown(0x1)
        if is_key_pressed then
            local mouse = cheat.GetMousePos()
            local ts = g_Render:CalcTextSize("Keybinds", 16)
            if BindsDrag == true then
                BindsX = mouse.x
                BindsY = mouse.y
            end
            if mouse.x >= BindsX - 120 and mouse.y >= BindsY and mouse.x <= BindsX - 120 + 240 and mouse.y <= BindsY + ts.y then
                if SpecDrag == false then BindsDrag = true end
            end
        else
            BindsDrag = false
        end
    end
end

cheat.RegisterCallback('draw', function()
    rgb_line_draw()
    local is_rage = quest(tabs:GetInt() == 0)
    local is_visible = quest(tabs:GetInt() == 1)
    local is_misc = quest(tabs:GetInt() == 2)
    local is_hotkeys = quest(tabs:GetInt() == 3)
	DTCorrection:SetVisible(is_rage)
	DTModes:SetVisible(is_rage)
    DTRecharge:SetVisible(is_rage)
    lowdelta:SetVisible(is_rage)
    legitaa:SetVisible(is_rage)
    antiaimpresets:SetVisible(is_rage)
    LegsBreaker:SetVisible(is_rage)
	trashtalk:SetVisible(is_visible)
    hitsound:SetVisible(is_visible)
    Trail:SetVisible(is_visible)
    TrailSize:SetVisible(quest(is_visible and Trail:GetBool()))
    TrailLength:SetVisible(quest(is_visible and Trail:GetBool()))
    TrailColor:SetVisible(quest(is_visible and Trail:GetBool()))
	ui_windows:SetVisible(is_visible)
	ui_themes:SetVisible(is_visible)
	ui_custom_cheat_name:SetVisible(is_visible)
	ui_custom_username:SetVisible(is_visible)
	ui_line_color:SetVisible(is_visible)
	ui_text_outline:SetVisible(is_visible)
	ui_box_alpha:SetVisible(is_visible)
	ui_keybinds_x:SetVisible(is_visible)
	ui_keybinds_y:SetVisible(is_visible)
	ui_spectators_x:SetVisible(is_visible)
	ui_spectators_y:SetVisible(is_visible)
    CustomScope:SetVisible(quest(is_visible))
    ScopeOrigin:SetVisible(quest(is_visible and CustomScope:GetBool()))
    ScopeWidth:SetVisible(quest(is_visible and CustomScope:GetBool()))
	rgb_line:SetVisible(is_visible)
	line_size:SetVisible(quest(is_visible and rgb_line:GetBool()))
    displayNades:SetVisible(is_misc)
    GHOnlyVisible:SetVisible(quest(is_misc and displayNades:GetBool()))
    GHSilentThrow:SetVisible(quest(is_misc and displayNades:GetBool()))
	GHKeybind:SetVisible(quest(is_misc and displayNades:GetBool()))
    manualIndicators:SetVisible(is_visible)
    displayoneways:SetVisible(is_misc)
    OWOnlyVisible:SetVisible(quest(is_misc and displayoneways:GetBool()))
    JumpScout:SetVisible(is_rage)
    JumpScoutHC:SetVisible(quest(is_rage and JumpScout:GetBool()))
    JumpScoutMD:SetVisible(quest(is_rage and JumpScout:GetBool()))
    manualcolors:SetVisible(is_visible)
    
    local local_player_index    = g_EngineClient:GetLocalPlayer()
    local local_player          = g_EntityList:GetClientEntity(local_player_index)

    get_slowly_info()
    if ui_windows:GetBool(0) then draw_watermark() end
    if ui_windows:GetBool(1) then draw_spectators() end
    if ui_windows:GetBool(2) then draw_keybinds() end
    if ui_windows:GetBool(3) then draw_fake() end
    if ui_windows:GetBool(4) then draw_io() end
    if ui_windows:GetBool(5) then draw_dt() end
    if ui_windows:GetBool(6) then draw_hz() end
    
    if not local_player then
        cachedmaps = {}
        cachedoneways = {}
        logs = {}
        g_CVar:FindVar("r_drawvgui"):SetInt(1)
        return
    end
    if local_player:GetProp("m_iHealth") > 0 then
        if LegsBreaker:GetBool() then lbreaker:SetInt(math.random(1,2)) end
        if Trail:GetBool() then trails() end
        if CustomScope:GetBool() then customscope() else g_CVar:FindVar("r_drawvgui"):SetInt(1) end
        if displayNades:GetBool() then showNades() end
        if displayoneways:GetBool() then showOneways() end
        if manualIndicators:GetBool() then manuals() end
    end
end)

local function instant_recharge()
    
    if (DTRecharge:GetBool()) then
        exploits.ForceCharge()
    end

end
	
    local instant = 16
    local fast = 15
    local default = 12

    local insecure = 0
    local secure = 1
    local safe = 2

    local cl_clock_correction = g_CVar:FindVar("cl_clock_correction")
    local sv_maxusrcmdprocessticks = g_CVar:FindVar("sv_maxusrcmdprocessticks")

    if (DTCorrection:GetBool()) then
        g_CVar:FindVar("cl_clock_correction"):SetInt(0)
        g_CVar:FindVar("cl_clock_correction_adjustment_max_amount"):SetInt(450)
    end

    if (DTModes:GetInt() == 0) then
        exploits.OverrideDoubleTapSpeed(default)

    else if (DTModes:GetInt() == 1) then
        exploits.OverrideDoubleTapSpeed(fast)
        
    else if (DTModes:GetInt() == 2) then
		exploits.OverrideDoubleTapSpeed(instant)
        
    else if (DTModes:GetInt() == 3) then
        exploits.OverrideDoubleTapSpeed(17)
        g_CVar:FindVar("cl_clock_correction"):SetInt(0)
        g_CVar:FindVar("cl_clock_correction_adjustment_max_amount"):SetInt(450)
    end
	end
    end   
end

local jumpScouted = false
local jumpscoutTicks = 0
local oldDamage = 0
local oldAutowall = 0
local oldHitChance = 0
cheat.RegisterCallback('events', function(event)
    if event:GetName() == "player_jump" then
        local user_id = event:GetInt("userid") - 1
        local local_player_index    = g_EngineClient:GetLocalPlayer()
        if user_id == local_player_index then
            if JumpScout:GetBool() then 
                local me = g_EntityList:GetClientEntity(g_EngineClient:GetLocalPlayer()):GetPlayer()
                if me == nil then return end
                local wpn = me:GetActiveWeapon():GetClassName()
                if wpn == "CWeaponSSG08" then
                    local damage = g_Config:FindVar("Aimbot", "Ragebot", "Min. Damage", "Visible", "SSG-08")
                    local autowall = g_Config:FindVar("Aimbot", "Ragebot", "Min. Damage", "Autowall", "SSG-08")
                    local hitchance = g_Config:FindVar("Aimbot", "Ragebot", "Accuracy", "Hit Chance")
                    if jumpScouted == false then 
                        oldDamage = damage:GetInt() 
                        oldAutowall = autowall:GetInt()
                        oldHitChance = hitchance:GetInt()
                    end
                    hitchance:SetInt(JumpScoutHC:GetInt())
                    damage:SetInt(JumpScoutMD:GetInt())
                    autowall:SetInt(JumpScoutMD:GetInt())
                    jumpscoutTicks = g_GlobalVars.tickcount + 50
                    jumpScouted = true
                end
            end 
        end
    elseif event:GetName() == "player_hurt" then
        local user_id = event:GetInt("userid") - 1
        local local_player_index    = g_EngineClient:GetLocalPlayer()
        if user_id == local_player_index then
            hitbox = event:GetInt('hitgroup');
            target_damage = event:GetInt("dmg_health");
            target_health = event:GetInt("health");
            victim = event:GetInt('userid');
            attacker = event:GetInt('attacker');
            weapon = event:GetString('weapon');
            local entity = g_EntityList:GetClientEntity(victim)
            local Name = entity:GetPlayer():GetName()
            logs[#logs+1] = {('Hit by ' .. Name .. ' for ' .. target_damage .. ' in ' .. hitboxes[hitbox+1]), g_GlobalVars.tickcount + 300, 0}
            print('[Essentials.Lua] '.. 'Hit by ' .. Name .. ' for ' .. target_damage .. ' in ' .. hitboxes[hitbox+1])
        end
    end
end)

local setLowdelta = false
local LowDelta = function()
    if setLowdelta == false then
        local FakeOptions = g_Config:FindVar("Aimbot", "Anti Aim", "Fake Angle", "Fake Options")
        local LBYMode = g_Config:FindVar("Aimbot", "Anti Aim", "Fake Angle", "LBY Mode")
        local freestandDesync = g_Config:FindVar("Aimbot", "Anti Aim", "Fake Angle", "Freestanding Desync")
        local DesyncOnShot = g_Config:FindVar("Aimbot", "Anti Aim", "Fake Angle", "Desync On Shot")
        FakeOptions:SetInt(0)
        LBYMode:SetInt(1)
        freestandDesync:SetInt(0)
        DesyncOnShot:SetInt(0)
        setLowdelta = true
    end
    antiaim.OverrideLimit(17.0)
    antiaim.OverrideLBYOffset(21.0)
    antiaim.OverrideYawOffset(1.0)
    antiaim.OverridePitch(90.0)
    if antiaim.GetInverterState() == false then
        antiaim.OverrideLBYOffset(21)
    else
        antiaim.OverrideLBYOffset(21.0)
    end
end
local setLegitOptions = false
local LegitAA = function(cmd)
    local ents = g_EntityList:GetEntitiesByClassID(129)
    local hosts = g_EntityList:GetEntitiesByClassID(97)
    if ents[1] ~= nil or ents[0] ~= nil then
        for i = 1, #ents do
            local localplayer = g_EntityList:GetClientEntity(g_EngineClient:GetLocalPlayer())
            local position = ents[i]:GetProp("DT_BaseEntity", "m_vecOrigin")
            local origin = localplayer:GetPlayer():GetEyePosition()
            local vec = Vector.new(origin.x, origin.y, origin.z)
            local distance = vec:DistTo(position)
            if distance > 100 then
                cmd.buttons = bit.band(cmd.buttons, bit.bnot(32))
            end
        end
    elseif hosts[1] ~= nil then
        for f = 1, #hosts do
            if f > 1 then
                local localplayer = g_EntityList:GetClientEntity(g_EngineClient:GetLocalPlayer())
                local position = hosts[f]:GetProp("DT_BaseEntity", "m_vecOrigin")
                local position2 = hosts[f-1]:GetProp("DT_BaseEntity", "m_vecOrigin")
                local origin = localplayer:GetPlayer():GetEyePosition()
                local vec = Vector.new(origin.x, origin.y, origin.z)
                local distance = vec:DistTo(position)
                local distance2 = vec:DistTo(position2)
                if distance > 100 and distance2 > 100 then
                    cmd.buttons = bit.band(cmd.buttons, bit.bnot(32))
                end
            end
        end
    else
        cmd.buttons = bit.band(cmd.buttons, bit.bnot(32))
    end
    if setLegitOptions == false then
        local FakeOptions = g_Config:FindVar("Aimbot", "Anti Aim", "Fake Angle", "Fake Options")
        local LBYMode = g_Config:FindVar("Aimbot", "Anti Aim", "Fake Angle", "LBY Mode")
        local freestandDesync = g_Config:FindVar("Aimbot", "Anti Aim", "Fake Angle", "Freestanding Desync")
        local DesyncOnShot = g_Config:FindVar("Aimbot", "Anti Aim", "Fake Angle", "Desync On Shot")
        FakeOptions:SetInt(8)
        LBYMode:SetInt(1)
        freestandDesync:SetInt(0)
        DesyncOnShot:SetInt(0)
        setLegitOptions = true
    end
    if antiaim.GetInverterState() then
        antiaim.OverrideLBYOffset(-60)
    else
        antiaim.OverrideLBYOffset(60)
    end
    antiaim.OverrideYawOffset(180.0)
    antiaim.OverrideLimit(60)
    antiaim.OverridePitch(0.0)
end

local pingticks = 0
local antiAims = false
local set = false
local settwo = false
local setthree = false
local ticksAfterUpload = 0
local savedAntiAims = {
    0,0,0,0,0,0,0,0,0,0,0,0
}
local presaveforlegit = {
    0,0,0,0,0,0,0,0,0,0,0,0
}
local presaveforldelta = {
    0,0,0,0,0,0,0,0,0,0,0,0
}
cheat.RegisterCallback('pre_prediction', function(cmd)
    local Pitch = g_Config:FindVar("Aimbot", "Anti Aim", "Main", "Pitch")
    local YawBase = g_Config:FindVar("Aimbot", "Anti Aim", "Main", "Yaw Base")
    local YawAdd = g_Config:FindVar("Aimbot", "Anti Aim", "Main", "Yaw Add")
    local YawMod = g_Config:FindVar("Aimbot", "Anti Aim", "Main", "Yaw Modifier")
    local ModDeg = g_Config:FindVar("Aimbot", "Anti Aim", "Main", "Modifier Degree")
    local LeftLimit = g_Config:FindVar("Aimbot", "Anti Aim", "Fake Angle", "Left Limit")
    local RightLimit = g_Config:FindVar("Aimbot", "Anti Aim", "Fake Angle", "Right Limit")
    local FakeOptions = g_Config:FindVar("Aimbot", "Anti Aim", "Fake Angle", "Fake Options")
    local LBYMode = g_Config:FindVar("Aimbot", "Anti Aim", "Fake Angle", "LBY Mode")
    local freestandDesync = g_Config:FindVar("Aimbot", "Anti Aim", "Fake Angle", "Freestanding Desync")
    local DesyncOnShot = g_Config:FindVar("Aimbot", "Anti Aim", "Fake Angle", "Desync On Shot")
    if lowdelta:GetBool() then LowDelta() else
        if setLowdelta == true then
            FakeOptions:SetInt(presaveforldelta[1])
            LBYMode:SetInt(presaveforldelta[2])
            freestandDesync:SetInt(presaveforldelta[3])
            DesyncOnShot:SetInt(presaveforldelta[4])
            setLowdelta = false
        else
            presaveforldelta[1] = FakeOptions:GetInt()
            presaveforldelta[2] = LBYMode:GetInt()
            presaveforldelta[3] = freestandDesync:GetInt()
            presaveforldelta[4] = DesyncOnShot:GetInt()
        end
    end
    if legitaa:GetBool() then LegitAA(cmd) else
        if setLegitOptions == true then
            FakeOptions:SetInt(presaveforlegit[1])
            LBYMode:SetInt(presaveforlegit[2])
            freestandDesync:SetInt(presaveforlegit[3])
            DesyncOnShot:SetInt(presaveforlegit[4])
            setLegitOptions = false
        else
            presaveforlegit[1] = FakeOptions:GetInt()
            presaveforlegit[2] = LBYMode:GetInt()
            presaveforlegit[3] = freestandDesync:GetInt()
            presaveforlegit[4] = DesyncOnShot:GetInt()
        end
    end
    if antiaimpresets:GetInt() == 0 then
        if savedAntiAims[12] == 0 then
            savedAntiAims[1] = Pitch:GetInt()
            savedAntiAims[2] = YawBase:GetInt()
            savedAntiAims[3] = YawAdd:GetInt()
            savedAntiAims[4] = YawMod:GetInt()
            savedAntiAims[5] = LeftLimit:GetInt()
            savedAntiAims[6] = RightLimit:GetInt()
            savedAntiAims[7] = FakeOptions:GetInt()
            savedAntiAims[8] = LBYMode:GetInt()
            savedAntiAims[9] = freestandDesync:GetInt()
            savedAntiAims[10] = DesyncOnShot:GetInt()
            savedAntiAims[11] = ModDeg:GetInt()
        elseif savedAntiAims[12] == 2 then
            Pitch:SetInt(savedAntiAims[1])
            YawBase:SetInt(savedAntiAims[2])
            YawAdd:SetInt(savedAntiAims[3])
            YawMod:SetInt(savedAntiAims[4])
            LeftLimit:SetInt(savedAntiAims[5])
            RightLimit:SetInt(savedAntiAims[6])
            FakeOptions:SetInt(savedAntiAims[7])
            LBYMode:SetInt(savedAntiAims[8])
            freestandDesync:SetInt(savedAntiAims[9])
            DesyncOnShot:SetInt(savedAntiAims[10])
            ModDeg:SetInt(savedAntiAims[11])
            savedAntiAims[12] = 0
        end
        set = false
        settwo = false
        setthree = false
        setfour = false
    elseif antiaimpresets:GetInt() == 1 then
        if set == false then
            Pitch:SetInt(1)
            YawBase:SetInt(1)
            YawAdd:SetInt(7)
            YawMod:SetInt(2)
            LeftLimit:SetInt(51)
            RightLimit:SetInt(38)
            FakeOptions:SetInt(8)
            LBYMode:SetInt(1)
            freestandDesync:SetInt(1)
            DesyncOnShot:SetInt(2)
            ModDeg:SetInt(-9)
            set = true
            settwo = false
            setthree = false
            setfour = false
            savedAntiAims[12] = 2
        end
    elseif antiaimpresets:GetInt() == 2 then
        if settwo == false then
            Pitch:SetInt(1)
            YawBase:SetInt(1)
            YawAdd:SetInt(0)
            YawMod:SetInt(2)
            LeftLimit:SetInt(40)
            RightLimit:SetInt(30)
            FakeOptions:SetInt(10)
            LBYMode:SetInt(1)
            freestandDesync:SetInt(1)
            DesyncOnShot:SetInt(3)
            ModDeg:SetInt(7)
            set = false
            settwo = true
            setthree = false
            setfour = false
            savedAntiAims[12] = 2
        end
    elseif antiaimpresets:GetInt() == 3 then
        if setthree == false then
            Pitch:SetInt(1)
            YawBase:SetInt(1)
            YawAdd:SetInt(0)
            YawMod:SetInt(0)
            LeftLimit:SetInt(60)
            RightLimit:SetInt(49)
            FakeOptions:SetInt(10)
            LBYMode:SetInt(1)
            freestandDesync:SetInt(1)
            DesyncOnShot:SetInt(3)
            set = false
            settwo = false
            setthree = true
            setfour = false
            savedAntiAims[12] = 2
        end
    elseif antiaimpresets:GetInt() == 4 then
        if setfour == false then
            Pitch:SetInt(1)
            YawBase:SetInt(1)
            YawAdd:SetInt(0)
            YawMod:SetInt(0)
            LeftLimit:SetInt(57)
            RightLimit:SetInt(43)
            FakeOptions:SetInt(8)
            LBYMode:SetInt(1)
            freestandDesync:SetInt(1)
            DesyncOnShot:SetInt(0)
            ModDeg:SetInt(0)
            set = false
            settwo = false
            setthree = false
            setfour = true
            savedAntiAims[12] = 2
        end
    end
    if JumpScout:GetBool() and jumpScouted == true then 
        local me = g_EntityList:GetClientEntity(g_EngineClient:GetLocalPlayer()):GetPlayer()
        if me == nil then return end
        local wpn = me:GetActiveWeapon():GetClassName()
        if wpn == "CWeaponSSG08" then
            if g_GlobalVars.tickcount >= jumpscoutTicks then
                jumpScouted = false
                local hitchance = g_Config:FindVar("Aimbot", "Ragebot", "Accuracy", "Hit Chance")
                local damage = g_Config:FindVar("Aimbot", "Ragebot", "Min. Damage", "Visible", "SSG-08")
                local autowall = g_Config:FindVar("Aimbot", "Ragebot", "Min. Damage", "Autowall", "SSG-08")
                hitchance:SetInt(oldHitChance)
                damage:SetInt(oldDamage)
                autowall:SetInt(oldAutowall)
            end           
        end
    end 
    if GHKeybind:GetBool() then nadeHelper(cmd) 
    else 
        
        local AutoStrafe = g_Config:FindVar("Miscellaneous", "Main", "Movement", "Auto Strafe")
        if AutoStrafe:GetBool() == false and autostrafed <= 0 then 
            autostrafed = 0
            AutoStrafe:SetBool(true) 
        elseif autostrafed > 0 then
            autostrafed = autostrafed - 5
        end
        running = false
        throw = 0
notified = false
        attacked = false 
        sorted = false
    end

local phrases = {
   "u r so ez ",
	"get clapped ",
	"did that hurt  ?",
	"do you want me to blow on that ?",
	"btw you are supposed to shoot me .",
	"sry I didn't know you were retarded ",
	"CSGO->Game->Game->TurnOnInstructorMessages that might help you ",
	"better luck next time ",
	"bro how did you hit the accept button with that aim ???",
	"ff ?",
	" should i teach you, just if you want .",
	"xD my cat killed you ",
	"better do you homework ",
	"Which controller are you using ???",
	"Did you ever think about suicide? It would make things quicker .",
	"is that a decoy, or are you trying to shoot somebody ?",
	"If this guy was the shooter Harambe would still be alive ",
	"CS:GO is too hard for you m8 maybe consider a game that requires less skill, like idk.... solitaire ",
	"Your shots are like a bad girlfriend: No Head",
	"I would call you AIDS but at least AIDS gets kills.",
	"I could swallow bullets and shit out a better spray than that",
	"Don't be a loser, buy a rope and hang yourself",
	"This guy is more toxic than the beaches at Fukushima",
	"deranking?",
	"Road to Bronce?",
	"Did you learn your spray downs in a bukkake video?",
	"Oops, I must have chosen easy bots by accident",
	"server cvar 'sv_rekt' changed to 1.",
	"Did you notice warm up is already over? Please start playing seriously!!!",
	"How do you change your difficulty settings? My CSGO is stuck on easy",
	"I'd say your aim is cancer, but cancer kills.",
	"I'd call you corona but nobody's afraid of you and corona gets kills.",
	"Nice $4750 decoy ' ' ",
	"CRY HERE ---> |___| <--- Africans need water",
	"Was that your spray on the wall or are you just happy to see me?",
	"Internet Explorer is faster than your reactions",
	"Safest place for us to stand is in front of ' ' �s gun",
	"Is your monitor on?",
	"mad cuz bad",
	"Choose your excuse: I suck, I'm bad, I can't play CSGO, WHY ARE YOU BULLYING ME",
	"If you want to play against enemies of your skill level just go to the main menu and click 'Offline with Bots'",
	"Did you know that csgo is free to uninstall?",
    "halt die fresse noname ",
    "Your ass is grass and I've got the weed-whacker.",
    "You are the reason they put instructions on shampoo.",
    "I used to fuck guys like you in prison",
    "i'll fuck you 'til you love me, faggot",
	"I smell your drunk mom from here.",
	"I'm the reason your dad's gay",
	"If you were a CSGO match, your mother would have a 7day cool down all the time, because she kept abandoning you.",
	"If I were to commit suicide, I would jump from your ego to your elo.",
	"You sound like your parents beat each other in front of you",
	"My knife is well-worn, just like your mother",
	"You're the human equivalent of a participation award.",
	"Did you grow up near by Chernobyl or why are you so toxic?",
	"I thought I put bots on hard, why are they on easy?",
	"You sound like your parents beat each other in front of you",
	"My knife is well-worn, just like your mother",
	"You're the human equivalent of a participation award.",
	"Did you grow up near by Chernobyl or why are you so toxic?",
	"I thought I put bots on hard, why are they on easy?",
	"Your nans like my ak vulcan, battle-scarred",
	"I have a coupon code for you = y0UStUP1d. It only works for dumb people so can you maybe try that one out for me?",
	"You're almost as salty as the semen dripping from your mum's mouth",
	"If you fuck your mom and sister it's still only a 2 sum. Are you from Alabama by any chance?",
	"Maybe if you stopped taking loads in the mouth you wouldn't be so salty",
	"The only thing you carry is an extra chromosome.",
	"I kissed your mom last night. Her breath was globally offensive",
	"You can't even carry groceries in from the car",
	"You can feel the autism",
	"Who are you sponsored by? Parkinson's?",
	"You define autism",
	"You dropped your weapon just like your mom dropped you on your head as a kid",
	"Shut up kid and talk to me when your balls have reached the bottom of your spiderman underwear!",
	"The time you need to react is equal to the WindowsXP boot time!",
	"You Polish fuck, Hitler should had killed your family",
	"Do you know the STOP BULLYING ME kid? That could be you.",
	"Bro you couldn't hit an elephant in the ass with a shotgun with aim like that",
	"Hey man, dont worry about being bad. It's called a trashCAN not a trashCAN'T.",
	"If i wanted to listen to an asshole I would fart",
	"Sell your computer and buy a Wii",
	"Are you one of those SpECi4L kids?",
	"Yo momma's so damn fat they named her after your throwing skills",
	"You have a reaction time slower than coastal erosion.",
	"I PRAY TO GOD A PACK OF WOLVES RAPES YOU IN THE DEAD OF WINTER AND FORCES YOU TO WALK HOME BAREFOOT!",
	"LOL watchin u play this game is like watching helen keller play tennis.",
	"Don't be upsetti, have some spaghetti",
	"Which one of your 2 dads taught you how to play CS?",
}

local function get_phrase()
    return phrases[utils.RandomInt(1, #phrases)]:gsub('\"', '')
end

cheat.RegisterCallback("events", function(event)
    if event:GetName() == "player_hurt" and hitsound:GetBool() then
        g_Config:FindVar("Visuals","World", "Hit", "Hit Sound")
        local attacker = g_EngineClient:GetPlayerForUserId(event:GetInt("attacker", 0))
        if attacker == g_EngineClient:GetLocalPlayer() then
            g_EngineClient:ExecuteClientCmd("play buttons/arena_switch_press_02.wav")
        end
    end
	if (trashtalk:GetBool() == false) then return end
    if (trashtalk:GetBool() == true) then
    if event:GetName() ~= "player_death" then return end
end
    local me = g_EngineClient:GetLocalPlayer()
    local victim = g_EngineClient:GetPlayerForUserId(event:GetInt("userid"))
    local attacker = g_EngineClient:GetPlayerForUserId(event:GetInt("attacker"))

    if victim == attacker or attacker ~= me then return end

    g_EngineClient:ExecuteClientCmd('say "' .. get_phrase() .. '"')
end)
    cheat.RegisterCallback('destroy', function() 
    g_Config:FindVar("Visuals","World", "Hit", "Hit Sound"):SetBool(oldStatus)
end)
end)