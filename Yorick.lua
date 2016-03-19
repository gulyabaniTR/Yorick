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
YorickMenu:SubMenu("ksteal", "Killsteal")
YorickMenu.ksteal:Boolean("E", "Use E", true)
YorickMenu.ksteal:Boolean("W", "Use W", true)
YorickMenu.ksteal:Boolean("Q", "Use Q", true)


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

function Killsteal()
	if igniteFound and YorickMenu.ksteal.ignite:Value() and Ready(summonerSpells.ignite) then
    local iDamage = (50 + (20 * GetLevel(myHero)))
      	for _, enemy in pairs(GetEnemyHeroes()) do
        	if ValidTarget(enemy, 600) and GetCurrentHP(enemy) <= iDamage then
          		CastTargetSpell(enemy, summonerSpells.ignite)
          	end
        end
	end
	if igniteFound and YorickMenu.ksteal.ignite:Value() and Ready(summonerSpells.ignite) and (rLevel ~= (nil or 0)) and Ready(_R) and YorickMenu.ksteal.R:Value() then
    	for _, enemy in pairs(GetEnemyHeroes()) do
    	local riDamage = math.ceil(CalcDamage(myHero, enemy, 0, (ultbase + ((GetMaxHP(enemy) - GetCurrentHP(enemy)) * (percent / 100)))) + (50 + (20 * GetLevel(myHero))))
    		if ValidTarget(enemy, 400) and (GetCurrentHP(enemy) <= riDamage) then
    			CastTargetSpell(enemy, summonerSpells.ignite)
    			DelayAction(function() CastTargetSpell(enemy, _R) end, 0.02)
    		end
    	end
	end
	if (eLevel ~= (nil or 0)) and Ready(_E) and YorickMenunu.ksteal.E:Value() then
		for _, enemy in pairs(GetEnemyHeroes()) do
		local eDamage = math.ceil(CalcDamage(myHero, enemy, 0, (ultbase + ((GetMaxHP(enemy) - GetCurrentHP(enemy)) * (percent / 100)))))
			if (GetCurrentHP(enemy) <= eDamage) and Ready(_E) and ValidTarget(enemy, 170) then 
				CastTargetSpell(enemy, _E)
			end
		end
	end
	if (wLevel ~= (nil or 0)) and Ready(_W) and YorickMenunu.ksteal.W:Value() then
		for _, enemy in pairs(GetEnemyHeroes()) do
		local wDamage = math.ceil(CalcDamage(myHero, enemy, 0, (ultbase + ((GetMaxHP(enemy) - GetCurrentHP(enemy)) * (percent / 100)))))
			if (GetCurrentHP(enemy) <= wDamage) and Ready(_W) and ValidTarget(enemy, 170) then 
				CastTargetSpell(enemy, _W)
			end
		end
	end
	if (qLevel ~= (nil or 0)) and Ready(_Q) and YorickMenunu.ksteal.Q:Value() then
		for _, enemy in pairs(GetEnemyHeroes()) do
		local qDamage = math.ceil(CalcDamage(myHero, enemy, 0, (ultbase + ((GetMaxHP(enemy) - GetCurrentHP(enemy)) * (percent / 100)))))
			if (GetCurrentHP(enemy) <= qDamage) and Ready(_Q) and ValidTarget(enemy, 85) then 
				CastTargetSpell(enemy, _Q)
			end
		end
	end
end


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
