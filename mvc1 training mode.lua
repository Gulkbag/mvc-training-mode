--Start Console Log
print("Marvel vs. Capcom: Clash of Super Heroes Training Mod")
print("Credits : Boigahs and Ahmed Nasser for Programming")
print("Peon2 for help with this project")
print("Make sure to use this script with FBA-RR")
print("Anybody can edit/add things to this script")

print()
print("Commands: ")
print()
print("Coin+Down = Infinite Meter")
print("Coin+Up = Health Refill")
print()
--Variables
local _infinitetime = true
local _inputhistor  = 11
local _p1meterfill  = false
local _p2meterfill  = false
local _healthfill 	= true
local _inputscroll	= true

--Colors&&input
local _inputcollp	="blue"
local _inputcolmp	="green"
local _inputcolhp	="red"
local _inputcollk	="yellow"
local _inputcolmk	="grey"
local _inputcolhk	="cyan"

--hexvalues variables
local p1pasthealth = p1health 
local p2pasthealth = p2health 
local p1health 	   = memory.readbyte(0xFF3271)
local p2health 	   = memory.readbyte(0xFF3671)
local p1dmg 	   = 0
local p2dmg 	   = 0
local p1pastdmg    = 0
local p2pastdmg    = 0
local p1combodmg   = 0
local p2combodmg   = 0
local p1combo 	   = 0
local p2combo 	   = 0
local p1control    = 0
local p2control    = 0
local controltemp  = 0
local p1input 	   = 0
local  

while true do
	emu.frameadvance()
end