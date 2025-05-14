-- https://github.com/bunnyhop-dev
-- Hack Simulator 3000 Enchance Edition :P

math.randomseed(os.time())

-- Config
local initial_firewall_code = math.random(1000, 9999)
local firewall_code = initial_firewall_code
local ai_defense = 0
local attempts = 5
local command = {"scan", "analyze", "brute-force", "bypass", "modify-code", "status", "reset"}
local trap_codes = {}
local scan_counter = 0
local analyze_used = false
local scanned_recently = false
local game_over = false
local resources = 100
local bypass_level = 0
local scan_range = 7
local ai_learning_rate = 0.1
local difficulty = 1 
local game_mode = "story" -- default mode bro 

-- Story Mode
local story_mission = 1
local story_missions = {
  [1] = {
    title = "Mission 1: Infiltrate Secure Server",
    description = "Hack into the secure server to retrieve the encrypted data. Firewall is strong",
    objective = "Retrieve data",
    reward = 200,
    difficulty = 2,
    initial_attempts = 5,
    initial_resources = 100,
    initial_ai_defense = 5
  },
  [2] = {
    title = "Mission 2: Bypass Corporate Firewall",
    description = "Bypass the corporate firewall to gain access to the internal network. AI is actively learning.",
    objective = "Access Network",
    reward = 300,
    difficulty = 3,
    initial_attempts = 4,
    initial_resources = 150,
    initial_ai_defense = 10
  },
  [3] = {
    title = "Mission 3: Modify Central System Code",
    description = "Modify the central system code to disable the security lockdown. Heavy defenses and active countermeasures",
    objective = "Disable lockdown",
    reward = 400,
    difficulty = 3,
    initial_attempts = 3,
    initial_resources = 200,
    initial_ai_defense = 15
  },
}

local function display_status()
  print("\n=== System Status ===")
  print("Attempts remaining: " .. attempts)
  print("AI Defense Level: " .. ai_defense)
  print("Firewall Code: " .. firewall_code)
  print("Resources: " .. resources)
  print("Scan Range: " .. scan_range)
  print("Bypass Level: " .. bypass_level)
  print("Difficulty: " .. difficulty)

  if game_mode == "story" then
    print("Mission: " .. story_missions[story_mission].title)
    print(story_missions[story_mission].description)
  end
  print("--------------------\n")
end

local function ai_counter_attack()
  print("\n!!! AI detected intrusion. Counter-Attack Initiated!")
  local attack_type = math.random(1, 3)

  if attack_type == 1 then
    print("-> AI corrupted your data! Firewall code changed.")
    firewall_code = math.random(1000, 9999)

  elseif attack_type == 2 then
    print("-> AI locked down the system! -1 attempt.")
    attempts = attempts - 1

  elseif attack_type == 3 then
    print("-> AI upgraded its defenses! AI Defense increased.")
    ai_defense = ai_defense + math.random(1, 3)
  end
  scan_counter = 0
end

local function display_scan_results()
  print("\nFound potential firewall codes:")
  for i = 1, scan_range do
    io.write(" " .. i .. ": " .. trap_codes[i])
    if i < scan_range then
      io.write(" |")
    end
  end
  print()
  scanned_recently = true
end

local function handle_scan()
  scan_counter = scan_counter + 1
  if scan_counter >= 3 then
    ai_counter_attack()
  end

  print("Scanning for vulnerabilities...")
  os.execute('sleep 1')

  trap_codes = {}
  local real_pos = math.random(1, scan_range)

  for i = 1, scan_range do
    if i == real_pos then
      trap_codes[i] = firewall_code
    else
      trap_codes[i] = math.random(1000, 9999)
    end
  end
  display_scan_results()
end

local function handle_analyze()
  if not scanned_recently then
    print("\nYou need to scan first before analyzing...")

  elseif analyze_used then
    print("\nAnalysis aleady performed.")

  elseif resources < 20 then
    print("Not enough resources (20 required).")

  else
    resources = resources - 20
    print("\nPerforming deep packet analysis...")
    os.execute('sleep 2')
    print("Analysus complete. Potential vulnerabilities indentified")
    analyze_used = true
    scanned_recently = false
  end
end

local function  handle_brute_force()
  io.write("Enter passwd: ")
  local guess = tonumber(io.read())

  if guess == nil then
    print("Invalid input. Please enter a number")
    return
  end

  for i = 1, scan_range do
    if trap_codes[i] == guess then
      print("\n!!! TRAP DETECTED: AI caught your move! Defense increased.")
      ai_defense = ai_defense + 2
      attempts = attempts - 1
      return
    end
  end

  if guess == firewall_code then
    print("\n*** SUCCESS: Firewall cracked! Access granted. ***")
    hacked = true
    game_over = true

  else
    print("Incorrect passwd. AI is adapting...")
    attempts = attempts - 1
    ai_defense = ai_defense + math.random(1, 2)
  end
end

local function handle_bypass()
  if resources < 30 then
    print("Not enough resources (30 required)")

  elseif ai_defense <= 0 then
    print("Firewall is already too weak to bypass")

  else
    resources = resources - 30
    ai_defense = math.max(0, ai_defense - 2)
    print("Firewall bypasswd. AI Defense reduced. (Current: " .. ai_defense .. ")")
    bypass_level = bypass_level + 1
  end
end

local function handle_modify_code()
  io.write("Enter new firewall code: ")
  local new_code = tonumber(io.read())

  if new_code == nil or new_code < 1000 or new_code > 9999 then
    print("Invalid code. Must be a 4-digit number.")
    return 
  end

  if new_code == firewall_code then
    print("\n*** SUCCESS: Firewall code modified! System compromised. ***")
    hacked = true
    game_over = true

  else
    print("Code modification failed. AI detected intrusion")
    attempts = attempts - 2
    ai_defense = ai_defense + math.random(2, 4)
  end
end

function handle_reset()
  print("Are you sure you want to reset the game? (yes/no)")
  io.write("> ")
  local confirm = io.read()
  if confirm == "yes" then
    game_over = false
    hacked = false
    attempts = initial_attempts
    resources = initial_resources
    ai_defense = initial_ai_defense
    firewall_code = initial_firewall_code
    scan_counter = 0
    trap_codes = {}
    bypass_level = 0
    os.execute('clear')
    print("Game reset")

  else
    print("Reset cancelled.")
  end
end

local function select_game_mode()
  print("Welcome to HackSim: Enchance Edition\n[V] 2.1")
  print("\nSelect Game Mode:")
  print("[1] Story Mode")
  print("[2] Sandbox Mode")
  io.write("\n> ")
  local choice = io.read()

  if choice == "1" then
    os.execute('clear')
    game_mode = "story"
    print("\n--- Story Mode ---")
    print(story_missions[story_mission].title)
    print(story_missions[story_mission].description)
    attempts = story_missions[story_mission].initial_attempts
    resources = story_missions[story_mission].initial_resources
    ai_defense = story_missions[story_mission].initial_ai_defense
    difficulty = story_missions[story_mission].difficulty

  elseif choice == "2" then
    os.execute('clear')
    game_mode = "sandbox"
    print("\n--- Sandbox Mode ---")
    print("GNU Linux V 2.1\nType 'help' for command list.\n")
    attempts = 5
    resources = 100
    ai_defense = 0 
    difficulty = 1
  
  else
    print("Invalid choice. Defaulting to Story Mode.")
    game_mode = "story"
    print("\n--- Story Mode ---")
    print(story_missions[story_mission].title)
    print(story_missions[story_mission].description)
    attempts = story_missions[story_mission].initial_attempts
    resources = story_missions[story_mission].initial_resources
    ai_defense = story_missions[story_mission].initial_ai_defense
    difficulty = story_missions[story_mission].difficulty
  end
end

-- Main game
os.execute('clear')
select_game_mode()
firewall_code = math.random(1000, 9999)

while not game_over do
  display_status()
  io.write("> ")
  local cmd = io.read()

  if cmd == "help" then
    print("\nAvailable Commands:")
    print("scan         | Scan for potential firewall codes")
    print("analyze      | Analyze scanned codes for weaknesses (cost: 20 resources)")
    print("brute-force  | Attempt to guess the firewall code")
    print("bypass       | Temporarily weaken the firewall (cost: 30 resources)")
    print("modify-code  | Attempt to change the firewall code (cost: 40 resources)")
    print("status       | Display current game status")
    print("reset        | Reset the game to the beginning")
    print("clear/cls    | Clear Terminal screen\n")

  elseif cmd == "clear" or cmd == "cls" then
    os.execute('clear' or 'cls')

  elseif cmd == "scan" then
    handle_scan()

  elseif cmd == "analyze" then
    handle_analyze()

  elseif cmd == "brute-force" then
    handle_brute_force()

  elseif cmd == "bypass" then
    handle_bypass()

  elseif cmd == "modify-code" then
    handle_modify_code()

  elseif cmd == "status" then
    display_status()

  elseif cmd == "reset" then
    handle_reset()

  elseif cmd == "" then
    -- nothing here :P

  elseif cmd == "exit" then
    print("\n\n Good Bye Hacker")
    os.exit()

  else
    print("bash: " .. cmd .. ": command not found")
  end

  if math.random() < ai_learning_rate then
    ai_defense = ai_defense + math.random(0, difficulty)
    print("AI is learning your tactics")
  end

  if attempts <= 0 then
    game_over = true
    print("\n\n*** GAME OVER: Firewall detected malicious script. System security lockdown ***\n\n")
  end
end


if hacked then
  print("\n\n*** HACKING SUCCESSFUL! System compromised. ***\n")
  if game_mode == "story" then
    print("Mission Complete! Reward: " .. story_missions[story_mission].reward .. " resources.")
    resources = resources + story_missions[story_mission].reward

    if story_mission < #story_missions then
      story_mission = story_mission + 1
      print("\n--- Next Mission: " .. story_missions[story_mission].title .. " ---")
      print(story_missions[story_mission].description)
      attempts = story_missions[story_mission].initial_attempts
      resources = story_missions[story_mission].initial_resources
      ai_defense = story_missions[story_mission].initial_ai_defense
      difficulty = story_missions[story_mission].difficulty
      game_over = false
      hacked = false
      firewall_code = math.random(1000, 9999)
      scan_counter = 0
      analyze_used = false
      scanned_recently = false
      trap_codes = {}
      bypass_level = 0
      os.execute('sleep 2')

    else
      print("\n*** Congratulations! You completed the story mode. ***")
      print("Thank you for playing HackSim: Enchance Edition :)\n")
    end

  else
    local file = io.open("reward.txt", "w")
    file:write("Congratulations You successfully hacked the system.\n")
    file:write("Please use your abilities responsibly.\n")
    file:close()
    print("[+] A reward has been placed in 'reward.txt'!")
  end
end
