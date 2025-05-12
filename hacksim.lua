math.randomseed(os.time())

local commands = { "scan", "bruteforce", "connect", "upload payload" }
local password = "secure64"
local firewall_time = 10
local hacked = false

print("Welcome to HackSim! [V] 1")
print("You must use command to hack system in " .. firewall_time .. " second!")
print("List commands: " .. table.concat(commands, ", "))

local start_time = os.time()

while os.time() - start_time < firewall_time do
  io.write("> ")
  local cmd = io.read()

  if cmd == "scan" then
    print("Checking... Found 1 Vulnetion!")
  elseif cmd == "connect" then
    print("Connecting to server...")
  elseif cmd == "bruteforce" then
    io.write("Type you think is right: ")
    local attempt = io.read()
    if attempt == password then
      print("Login success!")
      hacked = true
      break
    else
      print("Wrong password Try again")
    end
  elseif cmd == "upload payload" then
    print("Uploading payload... wait a second")
  else
    print("Error " .. cmd .. " command not found")
  end
end

if hacked then
  print("Hacked successfully!")
else
  print("Firewall lockdown, Mission failed")
end
