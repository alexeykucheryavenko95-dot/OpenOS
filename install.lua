local files = {
  "auto_daemon.lua",
  "hud_daemon.lua",
  "energy_daemon.lua"
}

local base = "https://raw.githubusercontent.com/alexeykucheryavenko95-dot/Open-OS/main/"
local target = "/home/"

print("=== Open-OS installer ===")

for _, f in ipairs(files) do
  print("Installing " .. f)
  os.execute("wget -f " .. base .. f .. " " .. target .. f)
end

-- автозапуск демонов
local shrc = io.open("/home/.shrc", "a")
if shrc then
  shrc:write("\n-- Open-OS autostart\n")
  for _, f in ipairs(files) do
    shrc:write(f .. " &\n")
  end
  shrc:close()
end

print("Install complete. Reboot or reload shell.")
