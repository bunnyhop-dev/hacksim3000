# HackSim - A Hacker Simulation Game / เกมจำลองการแฮ็ก

Welcome to **HackSim V2**, a text-based hacking simulation where you must infiltrate a system by bypassing firewalls, cracking passwords, and analyzing security protocols. Test your skills in a simulated environment, but beware—the AI is constantly adapting to your moves!

ยินดีต้อนรับสู่ **HackSim V2**, เกมจำลองการแฮ็กในรูปแบบเท็กซ์เบสที่คุณจะต้องเจาะระบบโดยการข้ามไฟร์วอลล์, การเดารหัสผ่าน และการวิเคราะห์โปรโตคอลความปลอดภัย ทดสอบทักษะของคุณในสภาพแวดล้อมจำลอง แต่ต้องระวัง—AI จะเรียนรู้และปรับตัวตามการกระทำของคุณ!

---

## 📝 Description / รายละเอียด

HackSim V2 is a hacker simulation game built in Lua, where you play as a hacker trying to break through a firewall. You must scan, analyze, and modify firewall codes while avoiding traps and counter-hacks from the AI. The game features commands like `scan`, `brute-force`, `bypass`, and `modify-code`, and the AI continuously learns from your actions.

เกมจำลองการแฮ็ก HackSim เขียนในภาษา Lua ซึ่งคุณจะรับบทเป็นแฮ็กเกอร์ที่พยายามเจาะไฟร์วอลล์ คุณจะต้องสแกน, วิเคราะห์, และปรับแก้รหัสไฟร์วอลล์ ในขณะเดียวกันก็ต้องหลีกเลี่ยงกับดักและการโจมตีจาก AI เกมนี้มีคำสั่งต่างๆ เช่น `scan`, `brute-force`, `bypass`, และ `modify-code` และ AI จะเรียนรู้จากการกระทำของคุณตลอดเวลา

The game includes:
- A firewall code that changes during the game.
- AI counter-hacks that attempt to block your progress.
- A trap system to catch you off guard.
- A challenge to crack the firewall password.
- Real-time defense upgrades and countermeasures.

เกมนี้มี:
- รหัสไฟร์วอลล์ที่เปลี่ยนไปในระหว่างเกม
- การโจมตีจาก AI ที่พยายามบล็อกการก้าวหน้าของคุณ
- ระบบกับดักที่อาจทำให้คุณสะดุด
- ความท้าทายในการเดารหัสผ่านของไฟร์วอลล์
- การอัปเกรดการป้องกันและมาตรการต่อต้านแบบเรียลไทม์

---

## 🔧 Installation / การติดตั้ง

To get started, follow these steps:

1. **Install Lua** (if you don't already have it installed):
   - You can download Lua from [https://www.lua.org/download.html](https://www.lua.org/download.html)
   - Alternatively, use a package manager to install Lua. For example:
     - **macOS**: `brew install lua`
     - **Linux (Debian/Ubuntu)**: `sudo apt install lua5.3`
     - **Linux (Arch)**: `sudo pacman -S lua`
     - **Windows**: Follow the instructions on the Lua website.

2. **Clone or download HackSim**:
   - Clone the repository using Git:
     ```bash
     git clone https://github.com/bunnyhop-dev/hacksim3000
     ```
   - Or download the `.zip` file from GitHub.

3. **Run HackSim**:
   - Open a terminal or command prompt.
   - Navigate to the directory containing `hacksim.lua` (the main script).
   - Run the following command to start the game:
     ```bash
     lua hacksim.lua
     ```

ติดตั้งเกม HackSim ดังนี้:

1. **ติดตั้ง Lua** (หากยังไม่ได้ติดตั้ง):
   - ดาวน์โหลด Lua ได้ที่ [https://www.lua.org/download.html](https://www.lua.org/download.html)
   - หรือใช้ package manager เพื่อทำการติดตั้ง Lua เช่น:
     - **macOS**: `brew install lua`
     - **Linux (Debian/Ubuntu)**: `sudo apt install lua5.3`
     - **Linux (Arch)**: `sudo pacman -S lua`
     - **Windows**: ตามคำแนะนำบนเว็บไซต์ Lua

2. **Clone หรือดาวน์โหลด HackSim**:
   - Clone โค้ดจาก GitHub โดยใช้คำสั่ง:
     ```bash
     git clone https://github.com/bunnyhop-dev/hacksim3000
     ```
   - หรือดาวน์โหลดไฟล์ `.zip` จาก GitHub

3. **รัน HackSim**:
   - เปิด terminal หรือ command prompt
   - ไปที่โฟลเดอร์ที่มีไฟล์ `hacksim.lua` (สคริปต์หลัก)
   - รันคำสั่งนี้เพื่อเริ่มเกม:
     ```bash
     lua hacksim.lua
     ```

---

## 🎮 How to Play / วิธีเล่น

Once the game starts, you'll have a few seconds to complete the mission before the firewall locks down. You can use the following commands:

เมื่อเกมเริ่มต้น คุณจะมีเวลาจำกัดเพื่อทำภารกิจให้สำเร็จก่อนที่ไฟร์วอลล์จะล็อกตัวเอง คุณสามารถใช้คำสั่งต่อไปนี้:

1. **`scan`**: Scan the system for potential vulnerabilities. / สแกนระบบเพื่อหาจุดอ่อน
2. **`analyze`**: Analyze the firewall code (must scan first!). / วิเคราะห์รหัสไฟร์วอลล์ (ต้องสแกนก่อน!)
3. **`brute-force`**: Guess the firewall password. / เดารหัสผ่านของไฟร์วอลล์
4. **`bypass`**: Try bypassing the firewall if it's weak. / พยายามข้ามไฟร์วอลล์หากมันอ่อนแอ
5. **`modify-code`**: Attempt to modify the firewall code. / พยายามแก้ไขรหัสไฟร์วอลล์

Your goal is to either:
- **Hack the system** by guessing the firewall password or replacing the code.
- **Avoid traps** and countermeasures from the AI.

เป้าหมายของคุณคือ:
- **แฮ็กระบบ** โดยการเดารหัสผ่านของไฟร์วอลล์ หรือการแทนที่รหัส
- **หลีกเลี่ยงกับดัก** และการป้องกันของ AI

---

## 🧑‍💻 ChangeLog / ประวัติการเปลี่ยนแปลง

### V2.2 Enchance Edition (Current Version)
- Added Level and Experience system
- Added Skills and Skill Points system
- Added Inventory and Tools system
- Added diverse Environments
- Added Achievements system
- Enhanced AI system
- New commands: inventory, upgrade, achievements
### [New Systems]
- Level System: Players gain EXP and level up from completing missions
- Skills System: Upgrade various abilities like Scan Efficiency, Resource Management
- Tools System: Special hacking tools like Firewall Bypass Tool, AI Jammer
- Environments: Various systems to hack like Bank Security, Satellite Control
- Achievements: Special accomplishments and rewards

### V2.1 Enchance Edition
- Add Story mode and Sandbox mode
- Add display status
- Add more command
- Add player resources
- Upgrade AI, AI learning rate
- Fixed bugs
### [Story mode]
- Player will start game with a mission and recive a reward
### [Sandbox mode]
- Freedom mode

### V2.0
- Added AI defense and counter-hack system that learns from player actions.
- New `scan`, `analyze`, `brute-force`, `bypass`, and `modify-code` commands.
- AI now detects scanning patterns and responds with counterattacks (e.g., blocking access, changing password).
- Introduced the trap system, where fake codes are displayed to trick players.
- Added the concept of limited attempts to prevent over-scanning or brute-forcing.
- Introduced a reward system

### V1.0 (Initial Version)
- Basic firewall system with one password to crack.
- Introduced basic commands (`scan`, `bruteforce`, `connect`, `upload payload`).
- Firewall lockdown after failed attempts.
- Simple game flow and interactions.

### V2.2 Enchance Edition (เวอร์ชันปัจจุบัน)
- เพิ่มระบบ Level และ Experience
- เพิ่มระบบ Skills และ Skill Points
- เพิ่มระบบ Inventory และ Tools
- เพิ่มระบบ Environments ที่หลากหลาย
- เพิ่มระบบ Achievements
- เพิ่มระบบ AI ที่ฉลาดขึ้น
- เพิ่มคำสั่งใหม่: inventory, upgrade, achievements
### [ระบบใหม่]
- ระบบ Level: ผู้เล่นจะได้รับ EXP และเลเวลอัพจากการทำภารกิจ
- ระบบ Skills: อัพเกรดความสามารถต่างๆ เช่น Scan Efficiency, Resource Management
- ระบบ Tools: เครื่องมือพิเศษที่ช่วยในการแฮก เช่น Firewall Bypass Tool, AI Jammer
- ระบบ Environments: สภาพแวดล้อมที่หลากหลาย เช่น ระบบธนาคาร, ระบบดาวเทียม
- ระบบ Achievements: ความสำเร็จและรางวัลพิเศษ

### V2.1 Enchance Edition
- เพิ่มโหมดเนื้อเรื่อง และ โหมดSandbox
- เพิ่มแสดงสถานะของระบบ
- เพิ่มคำสั่งใหม่
- เพิ่มทรัพยากรของผู้เล่น
- อัปเกรดAI และ การเรียนรู้ของAI
- แก้ไขบัก
### [โหมดเนื้อเรื่อง]
- ผู้เล่นจะเริ่มเกมโดยการทำภารกิจ เพื่อรับรางวัล
### [โหมดSandbox]
- โหมดอิสระ

### V2.0
- เพิ่มระบบการป้องกัน AI และการโจมตีตอบโต้ที่เรียนรู้จากการกระทำของผู้เล่น
- เพิ่มคำสั่งใหม่ `scan`, `analyze`, `brute-force`, `bypass`, และ `modify-code`
- AI สามารถตรวจจับรูปแบบการสแกนและตอบโต้ด้วยการโจมตี (เช่น การบล็อกการเข้าถึง, เปลี่ยนรหัสผ่าน)
- เพิ่มระบบกับดักที่จะแสดงรหัสปลอมเพื่อหลอกผู้เล่น
- เพิ่มแนวคิดของการจำกัดจำนวนครั้งในการสแกนหรือเดารหัสผ่าน
- เพิ่มระบบรางวัล



### V1.0 (เวอร์ชันแรก)
- ระบบไฟร์วอลล์พื้นฐานที่มีรหัสผ่านเดียวให้เดา
- เพิ่มคำสั่งพื้นฐาน (`scan`, `bruteforce`, `connect`, `upload payload`)
- การล็อกไฟร์วอลล์หลังจากที่พยายามผิด
- กระบวนการและการโต้ตอบพื้นฐานของเกม

---

## 📧 Contact / ติดต่อ

For feedback or suggestions, please contact the developer at:  
**Email**: [dejavolf@gmail.com](mailto:dejavolf@gmail.com)

หากมีข้อเสนอแนะหรือคำถามเพิ่มเติม กรุณาติดต่อผู้พัฒนาได้ที่:  
**อีเมล**: [dejavolf@gmail.com](mailto:dejavolf@gmail.com)

---

**Have fun hacking!** 😎  
**ขอให้สนุกกับการแฮ็ก!** 😎

