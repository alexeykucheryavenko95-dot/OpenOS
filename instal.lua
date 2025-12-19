local component = require("component")
local fs = require("filesystem")

if not component.isAvailable("internet") then
  io.stderr:write("[INSTALL] No internet card\n")
  return
end

local internet = component.internet

local base = "https://raw.githubusercontent.com/alexeykucheryavenko95-dot/Open-OS/main/"

local files = {
  "auto_daemon.lua",
  "hud_daemon.lua",
  "energy_daemon.lua",
  "tps_hud.lua"
}

local function download(url)
  local h, err = internet.request(url)
  if not h then return nil, err end
  local data = ""
  while true do
    local chunk = h.read(math.huge)
    if not chunk then break end
    data = data .. chunk
  end
  h.close()
  return data
end

print("=== Open-OS installer ===")

for _, name in ipairs(files) do
  local url = base .. name
  local path = "/home/" .. name

  print("Downloading " .. name)

  local data, err = download(url)
  if not data or #data == 0 then
    io.stderr:write("[INSTALL] Failed: " .. name .. (err and (" ("..tostring(err)..")") or "") .. "\n")
    return
  end

  local f = io.open(path, "w")
  if not f then
    io.stderr:write("[INSTALL] Cannot write " .. path .. "\n")
    return
  end
  f:write(data)
  f:close()
end

-- автозапуск
local shrc = io.open("/home/.shrc", "a")
if shrc then
  shrc:write("\n-- Open-OS autostart\n")
  shrc:write("/home/auto_daemon.lua &\n")
  shrc:write("/home/hud_daemon.lua &\n")
  shrc:write("/home/energy_daemon.lua &\n")
  shrc:write("/home/tps_hud.lua &\n")
  shrc:close()
  print("Autostart configured")
else
  print("WARN: cannot open /home/.shrc")
end

print("Install complete. Reboot OpenOS.")
