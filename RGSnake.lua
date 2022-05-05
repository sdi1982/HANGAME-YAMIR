require "go.util.GameObject"
require "CharAnimation"

class 'RGSnake' (GameObject)

function RGSnake:__init() super()
	self.anim = {}	
	
	--self.show = false

	self:DataReset()
end

function RGSnake:DataReset()
	self:Show(false)
	self.exist = true
	self.dir = "down"
	self.animName = "down"
	self.pos = Vector2(0,0)
	self.moveEnable = true
	self.attackEnable = true

	self.attackPower = 1
	self.spdWalk = Vector2(4, 4)	-- 걷는 속도
	self.attackSpeed = 1

	self.bFlog = false
	self.bJinseng = false
	self.bPotion = false
	self.bSword = false
	self.bDragonPen = false
	self.bSunGlass = false
	self.bShield = false
end

function RGSnake:CreateOnImage()
	self.onImage = StaticImage()
	self.onImage:LoadStaticImage("images/ITEM/on_flog.png", 1, 1, nil, UIConst.Black)
	Scene.latestScene:AddChild(self.onImage)
	self.onImage:Show(false)
end

function RGSnake:OnStartFlogAck()
	self.bFlog = true
	self.onImage = StaticImage()
	self.onImage:LoadStaticImage("images/ITEM/on_flog.png", 1, 1, nil, UIConst.Black)
	Scene.latestScene:AddChild(self.onImage)
	self.onImage:Show(true)
end

function RGSnake:OnEndFlogAck()
	self.bFlog = false
	self.onImage:Show(false)
end

function RGSnake:OnStartJinsengAck()
	self.bJinseng = true
	self.attackPower = 2
	self.onImage:Show(false)
	self.onImage = StaticImage()
	self.onImage:LoadStaticImage("images/ITEM/on_attackUp.png", 1, 1, nil, UIConst.Black)
	Scene.latestScene:AddChild(self.onImage)
	self.onImage:Show(true)
end

function RGSnake:OnEndJinsengAck()
	self.bJinseng = false
	self.onImage:Show(false)
end

function RGSnake:OnStartPotionAck()
	self.bPotion = true
	self.spdWalk = Vector2(8,8)
	self.onImage:Show(false)
	self.onImage = StaticImage()
	self.onImage:LoadStaticImage("images/ITEM/on_speedUp.png", 1, 1, nil, UIConst.Black)
	Scene.latestScene:AddChild(self.onImage)
	self.onImage:Show(true)
end

function RGSnake:OnEndPotionAck()
	self.bPotion = false
	self.onImage:Show(false)
end

function RGSnake:OnStartSwordAck()
	self.bSword = true
	self.anim["attack_up"]:SetDelay(0.12)
	self.anim["attack_down"]:SetDelay(0.12)
	self.anim["attack_left"]:SetDelay(0.12)
	self.anim["attack_right"]:SetDelay(0.12)

	self.onImage:Show(false)
	self.onImage = StaticImage()
	self.onImage:LoadStaticImage("images/ITEM/on_attackSpeedUp.png", 1, 1, nil, UIConst.Black)
	Scene.latestScene:AddChild(self.onImage)
	self.onImage:Show(true)
end

function RGSnake:OnEndSwordAck()
	self.bSword = false
	self.onImage:Show(false)
end

function RGSnake:OnStartDragonPenAck()
	self.bDragonPen = true
	self.onImage:Show(false)
	self.onImage = StaticImage()
	Scene.latestScene:AddChild(self.onImage)
	self.onImage:Show(false)
end

function RGSnake:OnEndDragonPenAck()
	self.bDragonPen = false
end

function RGSnake:OnStartSunGlassAck()
	self.bSunGlass = true
	self.onImage:Show(false)
	self.onImage = StaticImage()
	self.onImage:LoadStaticImage("images/ITEM/on_sunglass.png", 1, 1, nil, UIConst.Black)
	Scene.latestScene:AddChild(self.onImage)
	self.onImage:Show(true)
end

function RGSnake:OnEndSunGlassAck()
	self.bSunGlass = false
	self.onImage:Show(false)
end

function RGSnake:OnStartShieldAck()
	self.bShield = true
	self.onImage:Show(false)
	self.onImage = StaticImage()
	self.onImage:LoadStaticImage("images/ITEM/on_shield.png", 1, 1, nil, UIConst.Black)
	Scene.latestScene:AddChild(self.onImage)
	self.onImage:Show(true)
end

function RGSnake:OnEndShieldAck()
	self.bShield = false
	self.onImage:Show(false)
end

function RGSnake:Show(show)
	if self.anim[self.animName] then
		self.anim[self.animName]:Reset()
	end
	self.show = show ~= false
end

function RGSnake:CreateAnimation(animName)
	local anim = CharAnimation(animName, self)
	self.anim[animName] = anim
	return anim
end

function RGSnake:SetXYPos(x, y)
	self.pos = Vector2(x, y)
	if self.onImage:IsShown() then
		self.onImage:SetXYPos(x-15, y-100)
	end
end

function RGSnake:BringToTop()
	for k in pairs(self.anim) do
		self.anim[k]:BringToTop()
	end
end

function RGSnake:Update(elapsed)
	if not self.show then return end
	local anim = self.anim[self.animName]
	if anim == nil then return end
	
	anim:Update(elapsed)
end

function RGSnake:ChangeState(animName, force)
	--현재와 같은 상태로의 변화이면 무시
	if self.animName == animName then 
		return
	end
	
	if not force then
		if not self.anim[self.animName].loop then
			return
		end
	end
	
	if self.anim[self.animName] then
		self.anim[self.animName]:Reset()
	end
	 
	self.animName = animName
	self.anim[self.animName]:Reset()
end

function RGSnake:OnAnimationEnd(elapsed)
	if self.animName == "attack_up" then
		self:ChangeState("up", true)
	elseif self.animName == "attack_down" then
		self:ChangeState("down", true)
	elseif self.animName == "attack_left" then
		self:ChangeState("left", true)
	elseif self.animName == "attack_right" then
		self:ChangeState("right", true)
	elseif self.animName == "dead" then
		self.exist = false
		self:Show(false)
	end

	self.attackEnable = true

	self:Update(elapsed)
end

function RGSnake:ChangeImg(color,kind)
	local color_name

	if color == 1 then
		color_name = "red"
	elseif color == 2 then
		color_name = "yellow"
	elseif color == 3 then
		color_name = "green"
	elseif color == 4 then
		color_name = "blue"
	elseif color == 5 then
		color_name = "black"
	elseif color == 6 then
		color_name = "grey"
	elseif color == 7 then
		color_name = "white"
	end
	
	self.anim["down"]:ChangeImg(1,"images/SNAKE/" .. color_name .. "0" .. kind .. "_walk_down01.png")
	self.anim["down"]:ChangeImg(2,"images/SNAKE/" .. color_name .. "0" .. kind .. "_walk_down02.png")
	
	self.anim["up"]:ChangeImg(1,"images/SNAKE/" .. color_name .. "0" .. kind .. "_walk_up01.png")
	self.anim["up"]:ChangeImg(2,"images/SNAKE/" .. color_name .. "0" .. kind .. "_walk_up02.png")

	self.anim["left"]:ChangeImg(1,"images/SNAKE/" .. color_name .. "0" .. kind .. "_walk_left01.png")
	self.anim["left"]:ChangeImg(2,"images/SNAKE/" .. color_name .. "0" .. kind .. "_walk_left02.png")

	self.anim["right"]:ChangeImg(1,"images/SNAKE/" .. color_name .. "0" .. kind .. "_walk_right01.png")
	self.anim["right"]:ChangeImg(2,"images/SNAKE/" .. color_name .. "0" .. kind .. "_walk_right02.png")

	self.anim["dead"]:ChangeImg(1,"images/SNAKE/" .. color_name .. "0" .. kind .. "_walk_dead01.png")
	self.anim["dead"]:ChangeImg(2,"images/SNAKE/" .. color_name .. "0" .. kind .. "_walk_dead02.png")
	self.anim["dead"]:ChangeImg(3,"images/SNAKE/" .. color_name .. "0" .. kind .. "_walk_dead03.png")
	self.anim["dead"]:ChangeImg(4,"images/SNAKE/" .. color_name .. "0" .. kind .. "_walk_dead04.png")

	self.anim["attack_up"]:ChangeImg(1,"images/SNAKE/attack_" .. color_name .. kind .. "_up1.png")
	self.anim["attack_up"]:ChangeImg(2,"images/SNAKE/attack_" .. color_name .. kind .. "_up2.png")
	self.anim["attack_up"]:ChangeImg(3,"images/SNAKE/attack_" .. color_name .. kind .. "_up3.png")

	self.anim["attack_down"]:ChangeImg(1,"images/SNAKE/attack_" .. color_name .. kind .."_down1.png")
	self.anim["attack_down"]:ChangeImg(2,"images/SNAKE/attack_" .. color_name .. kind .."_down2.png")
	self.anim["attack_down"]:ChangeImg(3,"images/SNAKE/attack_" .. color_name .. kind .."_down3.png")

	self.anim["attack_left"]:ChangeImg(1,"images/SNAKE/attack_" .. color_name .. kind .. "_left1.png")
	self.anim["attack_left"]:ChangeImg(2,"images/SNAKE/attack_" .. color_name .. kind .. "_left2.png")
	self.anim["attack_left"]:ChangeImg(3,"images/SNAKE/attack_" .. color_name .. kind .. "_left3.png")

	self.anim["attack_right"]:ChangeImg(1,"images/SNAKE/attack_" .. color_name .. kind .. "_right1.png")
	self.anim["attack_right"]:ChangeImg(2,"images/SNAKE/attack_" .. color_name .. kind .. "_right2.png")
	self.anim["attack_right"]:ChangeImg(3,"images/SNAKE/attack_" .. color_name .. kind .. "_right3.png")				
end