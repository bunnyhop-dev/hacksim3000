-- https://github.com/bunnyhop-dev
-- Hack Simulator 3000 Enchance Edition :P

math.randomseed(os.time())

-- Config
local initial_firewall_code = math.random(1000, 9999)
local firewall_code = initial_firewall_code
local ai_defense = 0
local attempts = 5
local command = {"scan", "analyze", "brute-force", "bypass", "modify-code", "status", "reset", "inventory", "upgrade", "achievements"}
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

-- New Systems
local player = {
    level = 1,
    exp = 0,
    skill_points = 0,
    skills = {
        scan_efficiency = 0,
        resource_management = 0,
        analysis_accuracy = 0,
        stealth = 0,
        ai_resistance = 0
    },
    inventory = {},
    achievements = {},
    story_progress = 1,
    reputation = 0
}

local tools = {
    firewall_bypass = {
        name = "Firewall Bypass Tool",
        description = "Bypass firewall without triggering alarms",
        uses = 3,
        cost = 150
    },
    ai_jammer = {
        name = "AI Jammer",
        description = "Temporarily disable AI defense",
        uses = 2,
        cost = 200
    },
    data_scanner = {
        name = "Advanced Data Scanner",
        description = "Increase scan accuracy by 50%",
        uses = 5,
        cost = 100
    }
}

local environments = {
    bank = {
        name = "Bank Security System",
        description = "High-security banking network with multiple layers of protection",
        special_mechanisms = {"vault_encryption", "transaction_monitoring"},
        difficulty = 4
    },
    satellite = {
        name = "Satellite Control System",
        description = "Orbital defense network with limited access windows",
        special_mechanisms = {"orbital_tracking", "signal_jamming"},
        difficulty = 5
    },
    corporate = {
        name = "Corporate Network",
        description = "Enterprise-level security with active monitoring",
        special_mechanisms = {"employee_tracking", "data_encryption"},
        difficulty = 3
    }
}

local achievements = {
    first_hack = {
        name = "First Steps",
        description = "Complete your first successful hack",
        reward = 100,
        completed = false
    },
    speed_demon = {
        name = "Speed Demon",
        description = "Complete a mission in under 2 minutes",
        reward = 200,
        completed = false
    },
    master_hacker = {
        name = "Master Hacker",
        description = "Reach level 10",
        reward = 500,
        completed = false
    }
}

local ai_personalities = {
    aggressive = {
        name = "Aggressive AI",
        description = "Focuses on direct counter-attacks",
        learning_rate = 0.2,
        defense_pattern = "offensive"
    },
    defensive = {
        name = "Defensive AI",
        description = "Prioritizes system protection",
        learning_rate = 0.1,
        defense_pattern = "defensive"
    },
    adaptive = {
        name = "Adaptive AI",
        description = "Learns from player's tactics",
        learning_rate = 0.3,
        defense_pattern = "mixed"
    }
}

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

-- New System Functions
local function gain_exp(amount)
    player.exp = player.exp + amount
    local exp_needed = player.level * 100
    if player.exp >= exp_needed then
        player.level = player.level + 1
        player.skill_points = player.skill_points + 1
        player.exp = player.exp - exp_needed
        print("\n*** Level Up! You are now level " .. player.level .. " ***")
        print("You gained 1 skill point!")
    end
end

local function check_achievements()
    if not achievements.first_hack.completed and hacked then
        achievements.first_hack.completed = true
        resources = resources + achievements.first_hack.reward
        print("\n*** Achievement Unlocked: " .. achievements.first_hack.name .. " ***")
        print("Reward: " .. achievements.first_hack.reward .. " resources")
    end
    
    if not achievements.master_hacker.completed and player.level >= 10 then
        achievements.master_hacker.completed = true
        resources = resources + achievements.master_hacker.reward
        print("\n*** Achievement Unlocked: " .. achievements.master_hacker.name .. " ***")
        print("Reward: " .. achievements.master_hacker.reward .. " resources")
    end
end

local function display_inventory()
    print("\n=== Inventory ===")
    if #player.inventory == 0 then
        print("Your inventory is empty")
    else
        for _, item in ipairs(player.inventory) do
            print(item.name .. " - " .. item.description)
            print("Uses remaining: " .. item.uses)
        end
    end
    print("----------------")
end

local function use_tool(tool_name)
    for i, item in ipairs(player.inventory) do
        if item.name == tool_name then
            if item.uses > 0 then
                item.uses = item.uses - 1
                if item.name == "Firewall Bypass Tool" then
                    ai_defense = math.max(0, ai_defense - 3)
                    print("\nFirewall temporarily weakened!")
                elseif item.name == "AI Jammer" then
                    ai_learning_rate = 0
                    print("\nAI temporarily disabled!")
                elseif item.name == "Advanced Data Scanner" then
                    scan_range = scan_range + 2
                    print("\nScan range increased!")
                end
                if item.uses == 0 then
                    table.remove(player.inventory, i)
                end
                return true
            else
                print("\nThis tool has no uses remaining!")
                return false
            end
        end
    end
    print("\nTool not found in inventory!")
    return false
end

local function display_skills()
    print("\n=== Skills ===")
    print("Skill Points: " .. player.skill_points)
    print("\nAvailable Skills:")
    print("1. Scan Efficiency (Level " .. player.skills.scan_efficiency .. ")")
    print("2. Resource Management (Level " .. player.skills.resource_management .. ")")
    print("3. Analysis Accuracy (Level " .. player.skills.analysis_accuracy .. ")")
    print("4. Stealth (Level " .. player.skills.stealth .. ")")
    print("5. AI Resistance (Level " .. player.skills.ai_resistance .. ")")
    print("----------------")
end

local function upgrade_skill(skill_name)
    if player.skill_points > 0 then
        if player.skills[skill_name] < 5 then
            player.skills[skill_name] = player.skills[skill_name] + 1
            player.skill_points = player.skill_points - 1
            
            -- Apply skill effects
            if skill_name == "scan_efficiency" then
                scan_range = scan_range + 1
            elseif skill_name == "resource_management" then
                resources = resources + 50
            elseif skill_name == "analysis_accuracy" then
                analyze_used = false
            elseif skill_name == "stealth" then
                scan_counter = math.max(0, scan_counter - 1)
            elseif skill_name == "ai_resistance" then
                ai_defense = math.max(0, ai_defense - 1)
            end
            
            print("\nSkill upgraded successfully!")
        else
            print("\nThis skill is already at maximum level!")
        end
    else
        print("\nNot enough skill points!")
    end
end

local function display_achievements()
    print("\n=== Achievements ===")
    for id, achievement in pairs(achievements) do
        local status = achievement.completed and "✓" or "✗"
        print(status .. " " .. achievement.name)
        print("   " .. achievement.description)
        print("   Reward: " .. achievement.reward .. " resources")
    end
    print("----------------")
end

local function select_environment()
    print("\nSelect Environment:")
    for id, env in pairs(environments) do
        print(id .. ". " .. env.name)
        print("   " .. env.description)
        print("   Difficulty: " .. env.difficulty)
    end
    io.write("\n> ")
    local choice = io.read()
    return environments[choice]
end

local function display_status()
  print("\n=== System Status ===")
  print("Level: " .. player.level)
  print("Experience: " .. player.exp .. "/" .. (player.level * 100))
  print("Skill Points: " .. player.skill_points)
  print("Attempts remaining: " .. attempts)
  print("AI Defense Level: " .. ai_defense)
  print("Firewall Code: " .. firewall_code)
  print("Resources: " .. resources)
  print("Scan Range: " .. scan_range)
  print("Bypass Level: " .. bypass_level)
  print("Difficulty: " .. difficulty)
  print("Reputation: " .. player.reputation)

  if game_mode == "story" then
    print("\nMission: " .. story_missions[story_mission].title)
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
  print("Welcome to HackSim: Enchance Edition\n[V] 2.2")
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
    print("GNU Linux V 2.2\nType 'help' for command list.\n")
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

local function handle_command(cmd)
    if cmd == "scan" then
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
    elseif cmd == "inventory" then
        display_inventory()
    elseif cmd == "upgrade" then
        display_skills()
        print("\nEnter skill number to upgrade (1-5):")
        io.write("> ")
        local skill_choice = io.read()
        local skill_map = {
            ["1"] = "scan_efficiency",
            ["2"] = "resource_management",
            ["3"] = "analysis_accuracy",
            ["4"] = "stealth",
            ["5"] = "ai_resistance"
        }
        if skill_map[skill_choice] then
            upgrade_skill(skill_map[skill_choice])
        else
            print("\nInvalid skill choice!")
        end
    elseif cmd == "achievements" then
        display_achievements()
    else
        print("\nUnknown command. Available commands:")
        for _, c in ipairs(command) do
            print("- " .. c)
        end
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
    print("inventory    | Display your inventory and tools")
    print("upgrade      | Upgrade your hacking skills")
    print("achievements | View your achievements and rewards")
    print("clear/cls    | Clear Terminal screen")
    print("exit         | Exit the game\n")

  elseif cmd == "clear" or cmd == "cls" then
    os.execute('clear' or 'cls')

  elseif cmd == "" then
    -- nothing here :P

  elseif cmd == "exit" then
    print("\n\n Good Bye Hacker")
    os.exit()

  else
    handle_command(cmd)
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
