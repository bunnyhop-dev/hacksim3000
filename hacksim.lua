math.randomseed(os.time())

local firewall_code = math.random(1000, 9999)
local ai_defense = 0
local hacked = false
local attempts = 3
local command = {"scan", "brute-force", "bypass", "modify-code"}
local trap_codes = {}
local scan_counter = 0
local analyze_used = false
local scanned_recently = false


os.execute('clear')
print("Welcome to HackSim!")
print("\nGNU Linux v 2.0\n Type 'help' for command lists\n")

while attempts > 0 do
  io.write("> ")
  local cmd = io.read()

  if cmd == "help" then
    print("\nscan | scan for find code for inject firewall\n\nanalyze | analyze firewall code\n\nbrute-force | guess firewall password to inject system\n\nbypass | this command will help you weak firewall strength\n\nmodify-code | replace new number to firewall_code for inject system\n\n")

  elseif cmd == "clear" or cmd == "cls" then
    os.execute('clear' or 'cls')

  elseif cmd == "scan" then

    scan_counter = scan_counter + 1
    if scan_counter >= 3 then
      print("\n!!! AI detected pattern scanning. Counter-hack activated!")

      local attack_type = math.random(1, 3)

      if attack_type == 1 then
        print("-> AI corrupted your data! Password changed")
        firewall_code = math.random(1000, 9999)

      elseif attack_type == 2 then
        print("-> AI blocked access temporarily! -1 attempt")
        attempts = attempts - 1

      elseif attack_type == 3 then
        print("-> AI upgraded defense system")
        ai_defense = ai_defense + 2
      end
      scan_counter = 0
    end

    print("Checking...")
    os.execute('sleep 1')
    print("\nFound:")

    local real_pos = math.random(1, 7)
    trap_codes = {}

    if math.random() < 0.3 then
      
      for i = 1, 7 do
        local fake_code = math.random(100, 9999)
        io.write(" " .. i .. ": " .. fake_code)
        table.insert(trap_codes, fake_code)

        if i < 7 then
          io.write(" |")
        else
          print()
        end
      end

    else
      for i = 1, 7 do
        local code
        if i == real_pos then
          code = firewall_code
        else
          code = math.random(100, 9999)
          table.insert(trap_codes, code)
        end

        io.write(" " .. i .. ":" .. code)

        if i < 7 then
          io.write(" |")
        else
          print()
        end
      end
    end
  scanned_recently = true

  elseif cmd == "analyze" then
    if not scanned_recently then
      print("\nYou need to scan first before using analyze!")

    elseif analyze_used then
      print("Analyze already used. Access denied!")

    else
      print("\nRunning deep packet inspection...")
      os.execute('sleep 1')
      print("Firewall real code is: " .. firewall_code)
      analyze_used = true
      scanned_recently = false
    end

  elseif cmd == "brute-force" then
      io.write("Enter password: ")
      local attempt = tonumber(io.read())
    
    for _, trap in ipairs(trap_codes) do
      if attempt == trap then
        print("\n!!! TRAP DETECTED: AI caught your move! Defense boosted!")
        ai_defense = ai_defense + 2
        attempts = attempts - 1
        goto continue
      end
    end

      if attempt == firewall_code then
        print("Password Correct! Firewall destroyed!")
        hacked = true
        break
      else
        print("Wrong password! Firewall got upgraded!")
        firewall_code = firewall_code + math.random(1, 50)
        ai_defense = ai_defense + 1000
    end

  elseif cmd == "bypass" then
    if ai_defense < 2 then
      print("Use vulneration for inject! Firewall is weakness!")
      firewall_code = firewall_code - math.random(10, 30)
    else
      print("!! Firewall detected! can't inject!")
    end

  elseif cmd == "modify-code" then
    io.write("Fix code: (Input New number for replace firewall) ")
    local new_code = tonumber(io.read())

    if new_code == firewall_code then
      print("Firewall replaced! access system")
      hacked = true
      break
    else
      print("!! Firewall Defense editing code")
      attempts = attempts - 1000
    end

  else
    print("Error " .. cmd .. " command not found")
  end

  if math.random() < 0.2 then
    print("AI is scanning your terminal...")
    ai_defense = ai_defense + 1
  end
    ::continue::
end

if hacked then
  print("Hacked successfully!")

  local file = io.open("reward.txt", "w")
  file:write("Congratulations! You just finished Hack Sim V2\n")
  file:write("If you have feedback contact dejavolf@gmail.com :)\n")
  file:write("🕵️ ♂️ Please use your abilities ethically!\n")
  file:close()

  os.execute('sleep 1')
  print("[+] You recived reward check 'reward.txt'!")

elseif ai_defense >= 3 then
  print("AI learned you technique! Mission Failed")

else
  print("Firewall lockdown, Mission failed")
end
