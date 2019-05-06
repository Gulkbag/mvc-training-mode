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
local p1pastcombo  = 0
local p2pastcombo  = 0
local p1control    = 0
local p2control    = 0
local controltemp  = 0
local p1input 	   = 0
local p2input 	   = 0
local p1pastinput  = 0
local p2pastinput  = 0
local inputhistortablep1 = {}
local inputhistortablep2 = {}
local p1meter            = 0
local p2meter 			 = 0
local gameinputs		 = {}
local p1pastdir 		 = 0
local p2pastdir          = 0
local p1dir 			 = 0
local p2dir              = 0
--
for i = 1, _inputhistor, 1 do
	inputhistortablep1[i] = 0
	inputhistortablep2[i] = 0
end
--
local offset 		   = 3
local p1guion 		   = true
local p2guion 		   = false
local frmlockp1 	   = 0
local frmlockp2 	   = 0
local dispcombocountp1 = 0
local dispcombocountp2 = 0
local combocountcolP1  = "white"
local combocountcolP2  = "white"
local scroll 		   = 1
if _inputscroll ~= true then
	scroll =-1
end
function memoryread()
	p1pasthealth = p1health
	p2pasthealth = p2health
	p1health 	 = memory.readbyte(0xFF3271)
	p2health     = memory.readbyte(0xFF3671)
	p1meter 	 = memory.readbyte(0xFF3274)
	p2meter      = memory.readbyte(0xFF3674)
	gameinputs   = joypad.read()
end

function infinite_time()
	if _infinitetime == true then
		memory.writebyte(0xFF4008, 0x99)
	end
end

function inputsort()
	p1pastinput = p1input
	p2pastinput = p2input
	p1input 	= 0
	p2input 	= 0


	if gameinputs["P1 Left"] then
		p1input=p1input+1
	end
	if gameinputs["P1 Down"] then
		p1input=p1input+3
	end
	if gameinputs["P1 Right"] then
		p1input=p1input+5
	end
	if gameinputs["P1 Up"] then
		p1input=p1input+10
	end

	p1pastdir=p1dir
	p1dir=p1input

	if gameinputs["P1 Weak Punch"] then
		p1input=p1input+20
	end
	if gameinputs["P1 Medium Punch"] then
		p1input=p1input+40
	end
	if gameinputs["P1 Strong Punch"] then
		p1input=p1input+80
	end
	if gameinputs["P1 Weak Kick"] then
		p1input=p1input+160
	end
	if gameinputs["P1 Medium Kick"] then
		p1input=p1input+320
	end
	if gameinputs["P1 Strong Kick"] then
		p1input=p1input+640
	end



	if gameinputs["P2 Left"] then
		p2input=p2input+1
	end
	if gameinputs["P2 Down"] then
		p1input=p1input+3
	end
	if gameinputs["P2 Right"] then
		p2input=p2input+5
	end
	if gameinputs["P2 Up"] then
		p2input=p2input+10
	end

	p2pastdir=p2dir
	p2dir=p2input

	if gameinputs["P2 Weak Punch"] then
		p2input=p2input+20
	end
	if gameinputs["P2 Medium Punch"] then
		p2input=p2input+40
	end
	if gameinputs["P2 Strong Punch"] then
		p2input=p2input+80
	end
	if gameinputs["P2 Weak Kick"] then
		p2input=p2input+160
	end
	if gameinputs["P2 Medium Kick"] then
		p2input=p2input+320
	end
	if gameinputs["P2 Strong Kick"] then
		p2input=p2input+640
	end
end

function inputhsitorrefresh()
	temp={}
	if (p1input ~= p1pastinput) and (p1input ~= 0) and (p1pastinput-p1pastdir+p1input)~=p1pastinput and (p1pastinput-p1pastdir~=p1input-p1dir or p1dir~=0) and (not(p1input-(p1pastinput-p1pastdir)<0)) then
		for i=1, _inputhistor-1, 1 do
			temp[i+1] = inputhistortablep1[i]
		end
		inputhistortablep1 = temp
		if (p1pastinput-p1pastdir~=p1input-p1dir) then
			inputhistortablep1[1] = p1input-(p1pastinput-p1pastdir)
		else
			inputhistortablep1[1] = p1dir
		end
	end
	temp={}
	if (p1input ~= p1pastinput) and (p1input ~= 0) and (p1pastinput-p1pastdir+p1input)~=p1pastinput and (p1pastinput-p1pastdir~=p1input-p1dir or p1dir~=0) and (not(p1input-(p1pastinput-p1pastdir)<0)) then
		for i=1, _inputhistor-1, 1 do
			temp[i+1] = inputhistortablep1[i]
		end
		inputhistortablep1 = temp
		if (p1pastinput-p1pastdir~=p1input-p1dir) then
			inputhistortablep1[1] = p1input-(p1pastinput-p1pastdir)
		else
			inputhistortablep1[1] = p1dir
		end
	end
end

while true do
	infinite_time()

	emu.frameadvance()
end