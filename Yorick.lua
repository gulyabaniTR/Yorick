if GetObjectName(GetMyHero()) ~= "Yorick" then 
	return 
end

require('Inspired')

local manaQ = GetCastMana(myHero, _Q, GetCastLevel(myHero,_Q))
local manaW = GetCastMana(myHero, _W, GetCastLevel(myHero,_W))
local manaE = GetCastMana(myHero, _E, GetCastLevel(myHero,_E))

local YorickMenu = MenuConfig("Yorick", "Yorick")

YorickMenu:Menu("Drawings", "Drawings")
YorickMenu:SubMenu("Combo", "Combo")
YorickMenu.Combo:Boolean("Q", "Use Q", true)
YorickMenu.Combo:Boolean("W", "Use W", true)
YorickMenu.Combo:Boolean("E", "Use E", true)


 YorickMenu.Drawings:Boolean("Q", "Draw Q Range", true)
 YorickMenu.Drawings:Boolean("W", "Draw W Range", true)
 YorickMenu.Drawings:Boolean("E", "Draw E Range", true)

local manaQ = GetCastMana(myHero, _Q, GetCastLevel(myHero,_Q))
local manaW = GetCastMana(myHero, _W, GetCastLevel(myHero,_W))
local manaE = GetCastMana(myHero, _E, GetCastLevel(myHero,_E))




OnDraw(function(myHero)
local pos = GetOrigin(myHero)
if YorickMenu.Drawings.Q:Value() then DrawCircle(pos,175,1,10,GoS.Red) end
if YorickMenu.Drawings.W:Value() then DrawCircle(pos,600,1,10,GoS.Yellow) end
if YorickMenu.Drawings.E:Value() then DrawCircle(pos,550,1,10,GoS.Pink) end
end)

OnTick(function(myHero)
    local target = GetCurrentTarget()
	
	
    if  GetCurrentMana(myHero) > manaQ + manaW + manaE and IOW:Mode() == "Combo" then
	
	
    	if YorickMenu.Combo.Q:Value() and Ready(_Q) and ValidTarget(target, 175) then  
    		CastSpell(_Q)
    	end

    	if YorickMenu.Combo.W:Value() and Ready(_W) and ValidTarget(target, 550) then
    			local targetPos = GetOrigin(target)
    			CastSkillShot(_W , targetPos)
    	end

    	if YorickMenu.Combo.E:Value() and Ready(_E) and ValidTarget(target, 550) then
    		local targetPos = GetOrigin(target)
    			CastTargetSpell(target, _E)
        end
	end
end)
