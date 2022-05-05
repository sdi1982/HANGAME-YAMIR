require "RGItem"

class 'RGItemManager'

function RGItemManager:__init()
	self.item = {}
end

function RGItemManager:CreateItem(kind, i,j)

	local item = RGItem()
	
	if kind == 1 then
		item.animName = "flog"
		local anim = item:CreateAnimation("flog")
		anim:SetLoop(true)
		anim:SetDelay(0.25)
		anim:SetOffset(0,28)
		anim:AddFrame("images/ITEM/flog_01.png")
		anim:AddFrame("images/ITEM/flog_02.png")
		anim:AddFrame("images/ITEM/flog_03.png")
		anim:AddFrame("images/ITEM/flog_04.png")
	elseif kind == 2 then
		item.animName = "jinseng"
		local anim = item:CreateAnimation("jinseng")
		anim:SetLoop(true)
		anim:SetDelay(0.25)
		anim:SetOffset(0,28)
		anim:AddFrame("images/ITEM/jinseng_01.png")
		anim:AddFrame("images/ITEM/jinseng_02.png")
		anim:AddFrame("images/ITEM/jinseng_03.png")
		anim:AddFrame("images/ITEM/jinseng_04.png")
	elseif kind == 3 then
		item.animName = "potion"
		local anim = item:CreateAnimation("potion")
		anim:SetLoop(true)
		anim:SetDelay(0.25)
		anim:SetOffset(0,28)
		anim:AddFrame("images/ITEM/potion_01.png")
		anim:AddFrame("images/ITEM/potion_02.png")
		anim:AddFrame("images/ITEM/potion_03.png")
		anim:AddFrame("images/ITEM/potion_04.png")
	elseif kind == 4 then
		item.animName = "sword"
		local anim = item:CreateAnimation("sword")
		anim:SetLoop(true)
		anim:SetDelay(0.25)
		anim:SetOffset(0,28)
		anim:AddFrame("images/ITEM/sword_01.png")
		anim:AddFrame("images/ITEM/sword_02.png")
		anim:AddFrame("images/ITEM/sword_03.png")
		anim:AddFrame("images/ITEM/sword_04.png")
	elseif kind == 5 then
		item.animName = "dragonpen"
		local anim = item:CreateAnimation("dragonpen")
		anim:SetLoop(true)
		anim:SetDelay(0.25)
		anim:SetOffset(0,28)
		anim:AddFrame("images/ITEM/dragonpen_01.png")
		anim:AddFrame("images/ITEM/dragonpen_02.png")
		anim:AddFrame("images/ITEM/dragonpen_03.png")
		anim:AddFrame("images/ITEM/dragonpen_04.png")
	elseif kind == 6 then
		item.animName = "sunglass"
		local anim = item:CreateAnimation("sunglass")
		anim:SetLoop(true)
		anim:SetDelay(0.25)
		anim:SetOffset(0,28)
		anim:AddFrame("images/ITEM/sunglass_01.png")
		anim:AddFrame("images/ITEM/sunglass_02.png")
		anim:AddFrame("images/ITEM/sunglass_03.png")
		anim:AddFrame("images/ITEM/sunglass_04.png")
	elseif kind == 7 then
		item.animName = "shield"
		local anim = item:CreateAnimation("shield")
		anim:SetLoop(true)
		anim:SetDelay(0.25)
		anim:SetOffset(0,28)
		anim:AddFrame("images/ITEM/shield_01.png")
		anim:AddFrame("images/ITEM/shield_02.png")
		anim:AddFrame("images/ITEM/shield_03.png")
		anim:AddFrame("images/ITEM/shield_04.png")
	end

	item:SetXYPos(MAP_LEFT_OFFSET+(i-1)*32,MAP_TOP_OFFSET+(j-1)*32)
	item.index = i*18+j -- 아이디 값
	item:Show(true)
	self.item[#self.item+1] = item
end

function RGItemManager:Update(elapsed)
	for i = 1,#self.item do
		if self.item[i].exist == true then
			self.item[i]:Update(elapsed)
		end
	end
end

function RGItemManager:RemoveItem(item_index)
	for i = 1,#self.item do
		if self.item[i].index == item_index then
			self.item[i]:DataReset()
			return
		end
	end
end