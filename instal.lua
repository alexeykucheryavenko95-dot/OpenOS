local component = require("component")
if not component.isAvailable("internet") then
  error("No internet card")
end

local net = component.internet
local base = "https://raw.githubusercontent.com/alexeykucheryavenko95-dot/OpenOS/main/"
local dst  = "/home/"

-- ДОБАВЛЯЕШЬ ФАЙЛЫ ТОЛЬКО ЗДЕСЬ
local files = {
  "auto_daemon.lua",
  "hud_daemon.lua",
  "energy_daemon.lua",
  "tps_hud.lua"
}

local function get(url)
  local h = assert(net.request(url))
  local data = ""
  repeat
    local chunk = h.read(math.huge)
    if chunk then data = data .. chunk end
  until not chunk
  h.close()
  return data
end

for _, f in ipairs(files) do
  print("Installing", f)
  local file = assert(io.open(dst .. f, "w"))
  file:write(get(base .. f))
  file:close()
end

print("Install done")
