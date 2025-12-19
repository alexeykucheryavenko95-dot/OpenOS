local files = {
  "auto_daemon.lua",
  "hud_daemon.lua",
  "energy_daemon.lua",
  "tps_hud.lua",
}

local base = "https://raw.githubusercontent.com/alexeykucheryavenko95-dot/Open-OS/main/"

for _, f in ipairs(files) do
  print("Downloading " .. f)
  os.execute("wget -f " .. base .. f .. " /home/" .. f)
end

print("Install complete.")
