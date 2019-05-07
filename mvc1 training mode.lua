--Start Console Log
print("Marvel vs. Capcom: Clash of Super Heroes Training Mod")
print("Credits : Boigahs and Ahmed Nasser for Programming")
print("Peon2 for help with this project and using his script as a refrence")
print("Whoever made the mvsc.ini cheats file as it provided most of the hex values")
print("Make sure to use this script with FBA-RR")
print("Anybody can edit/add things to this script")

print()
print("Commands: ")
print()
print("Coin+Down = Disable/Enable Infinite Meter")
print("Coin+Up = Disable/Enable P1 Gui")
print("Coin+Weak punch = Disable/Enable Health Refill")
--Variables
 _infinitetime = true
 _inputhistor  = 11
 _p1meterfill  = false
 _p2meterfill  = false
 _healthfill 	= true
 _inputscroll	= true


 _p1x = 13
 _p1y = 207
 _p2x = 337
 _p2y = 207

--Colors&&input
 _inputcollp	="blue"
 _inputcolmp	="green"
 _inputcolhp	="red"
 _inputcollk	="yellow"
 _inputcolmk	="grey"
 _inputcolhk	="cyan"

--hexvalues variables
 p1pasthealth = p1health
 p2pasthealth = p2health
 p1health 	   = memory.readbyte(0xFF3271)
 p2health 	   = memory.readbyte(0xFF3671)
 p1dmg 	   = 0
 p2dmg 	   = 0
 p1pastdmg    = 0
 p2pastdmg    = 0
 p1combodmg   = 0
 p2combodmg   = 0
 p1combo 	   = 0
 p2combo 	   = 0
 p1pastcombo  = 0
 p2pastcombo  = 0
 p1control    = 0
 p2control    = 0
 controltemp  = 0
 p1input 	   = 0
 p2input 	   = 0
 p1pastinput  = 0
 p2pastinput  = 0
 inputhistortablep1 = {}
 inputhistortablep2 = {}
 p1meter            = 0
 p2meter 			 = 0
 gameinputs		 = {}
 p1pastdir 		 = 0
 p2pastdir          = 0
 p1dir 			 = 0
 p2dir              = 0
--
for i = 1, _inputhistor, 1 do
	inputhistortablep1[i] = 0
	inputhistortablep2[i] = 0
end
--
offset 		   = 3
p1guion 		   = true
 p2guion 		   = false
 frmlockp1 	   = 0
 frmlockp2 	   = 0
 dispcombocountp1 = 0
 dispcombocountp2 = 0
 combocountcolP1  = "white"
 combocountcolP2  = "white"
 scroll 		   = 1
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
	if (p2input ~= p2pastinput) and (p2input ~= 0) and (p2pastinput-p2pastdir+p2input)~=p2pastinput and (p2pastinput-p2pastdir~=p2input-p2dir or p2dir~=0) and (not(p2input-(p2pastinput-p2pastdir)<0)) then
		for i=1, _inputhistor-1, 1 do
			temp[i+1] = inputhistortablep2[i]
		end
		inputhistortablep2 = temp
		if (p2pastinput-p2pastdir~=p2input-p2dir) then
			inputhistortablep2[1] = p2input-(p2pastinput-p2pastdir)
		else
			inputhistortablep2[1] = p2dir
		end
	end
end

function drawpad(padx,pady,padlength)
	gui.box(padx,pady,padx+(padlength*3),pady+padlength,"black","white")
	gui.box(padx+padlength,pady-padlength,padx+(padlength*2),pady+(padlength*2),"black","white")
	gui.box(padx+1,pady+1,padx+(padlength*3)-1,pady+padlength-1,"black")
end

function gameloop()
	--health fill
	if(_healthfill == true) then
		memory.writebyte(0xFF3271, 0x90)
		memory.writebyte(0xFF327B, 0x90)
		memory.writebyte(0xFF3671, 0x90)
		memory.writebyte( 0xFF367B, 0x90)
	end
	--meter fill
	if(_p1meterfill == true) then
		memory.writebyte(0xFF3274, 0x03)
		memory.writebyte(0xFF3A74, 0x03)
	end
	if(_p2meterfill == true) then
		memory.writebyte(0xFF3674, 0x03)
		memory.writebyte(0xFF3E74, 0x03)
	end
end

function inputCheck()
	if (gameinputs["P1 Coin"] == true) then
		if gameinputs["P1 Down"] == true then
			_p1meterfill = not(_p1meterfill)
			frameLockP1 = frame+10
		elseif gameinputs["P1 Up"] == true then
			p1guion = not(p1guion)
			frameLockP1 = frame+10
		elseif gameinputs["P1 Left"] == true then
			p2guion = not(p2guion)
			frameLockP1 = frame+10
		elseif gameinputs["P1 Weak Punch"] == true then
			_healthfill = not(_healthfill)
			frameLockP1 = frame+10
		elseif gameinputs["P1 Medium Punch"] == true then
			_p1meterfill = not(_p1meterfill)
			frameLockP1 = frame+10
		elseif gameinputs["P1 Strong Punch"] == true then
			_p2meterfill = not(_p2meterfill)
			frameLockP1 = frame+10
		end
	end
		if (gameinputs["P2 Coin"] == true) then
		if gameinputs["P2 Down"] == true then
			_p2meterfill = not(_p1meterfill)
			frameLockP1 = frame+10
		elseif gameinputs["P2 Up"] == true then
			p1guion = not(p1guion)
			frameLockP1 = frame+10
		elseif gameinputs["P2 Left"] == true then
			p2guion = not(p2guion)
			frameLockP1 = frame+10
		elseif gameinputs["P2 Weak Punch"] == true then
			_healthfill = not(_healthfill)
			frameLockP1 = frame+10
		elseif gameinputs["P2 Medium Punch"] == true then
			_p1meterfill = not(_p1meterfill)
			frameLockP1 = frame+10
		elseif gameinputs["P2 Strong Punch"] == true then
			_p2meterfill = not(_p2meterfill)
			frameLockP1 = frame+10
		end
	end
end

function guion()
	gui.text(18, 15, p1health)
	gui.text(355,15, p2health)
	gui.text(50, 24, p1meter)
	gui.text(326,24, p2meter)

	if (p1guion) then

		for i = 1, _inputhistor, 1 do
			temptbl=inputhistortablep1[i]
			buttonOffset=0
			if (temptbl-640)>= 0 then
				gui.text(_p1x+offset*4,_p1y-1-((11)*i*scroll), "HK", _inputcolhk)
				temptbl = temptbl-640
				buttonOffset=buttonOffset+6
			end
			if (temptbl-320)>=0 then
				gui.text(_p1x+offset*4+buttonOffset,_p1y-1-((11)*i*scroll), "MK", _inputcolmk)
				temptbl = temptbl-320
				buttonOffset=buttonOffset+6
			end
			if(temptbl-160)>=0 then
				gui.text(_p1x+offset*4+buttonOffset,_p1y-1-((11)*i*scroll),"LK", _inputcollk)
				temptbl = temptbl-160
				buttonOffset=buttonOffset+6
			end
			if(temptbl-80)>=0 then
				gui.text(_p1x+offset*4+buttonOffset,_p1y-1-((11)*i*scroll),"HP", _inputcolhp)
				temptbl = temptbl-80
				buttonOffset=buttonOffset+6
			end
			if(temptbl-40)>=0 then
				gui.text(_p1x+offset*4+buttonOffset,_p1y-1-((11)*i*scroll), "MP", _inputcolmp)
				temptbl = temptbl-40
				buttonOffset=buttonOffset+6
			end
			if(temptbl-20)>=0 then
				gui.text(_p1x+offset*4+buttonOffset,_p1y-1-((11)*i*scroll), "LP", _inputcollp)
				temptbl = temptbl-20
				buttonOffset=buttonOffset+6
			end
			if(temptbl<20 and not(temptbl<=0)) then
				drawpad(_p1x,_p1y-((11)*i*scroll),offset)
			end
			if(temptbl-10)>=0 then
				gui.box(_p1x+offset+1, _p1y-(11*i*scroll), _p1x+offset*2-1, _p1y-offset+1-(11*i*scroll), "red")
				temptbl = temptbl-10
			end
			if(temptbl-5)>=0 then
				gui.box(_p1x+offset*2, _p1y+1-(11*i*scroll), _p1x+offset*3-1, _p1y+offset-1-(11*i*scroll), "red")
				temptbl = temptbl-5
			end
			if(temptbl-3)>=0 then
				gui.box(_p1x+offset+1, _p1y+offset-(11*i*scroll), _p1x+offset*2-1, _p1y+offset*2-(11*i*scroll)-1,"red")
				temptbl = temptbl-3
			end
			if(temptbl-1)>=0 then
				gui.box(_p1x+1, _p1y+1-(11*i*scroll), _p1x+offset, _p1y+offset-1-(11*i*scroll), "red")
			end
		end
	end
end


while true do
	frame = emu.framecount()

	memoryread()
	gameloop()
	inputsort()
	inputCheck()
	inputhsitorrefresh()
	guion()
	infinite_time()
	emu.frameadvance()
end
