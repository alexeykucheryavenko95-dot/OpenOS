local files = {
  "auto_daemon.lua",
  "hud_daemon.lua",
  "energy_daemon.lua"
  "tps_hud.lua"
}

local base = "https://raw.githubusercontent.com/alexeykucheryavenko95-dot/Open-OS/main/"
local target = "/home/"

print("=== Open-OS installer ===")

for _, f in ipairs(files) do
  local cmd = 'wget -f "' .. base .. f .. '" "' .. target .. f .. '"'
  print("Downloading " .. f)
  os.execute(cmd)
end

print("Install complete.")
