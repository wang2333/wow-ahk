-- 初始化变量
aoepingbi = true

-- 特定目标列表
local specificTargets = {
	"腐面", "亡语者女士", "凯雷塞斯王子", 
	"塔达拉姆王子", "瓦拉纳王子", "腐面", "死亡使者萨鲁法尔", 
	"教官拉苏维奥斯", "药剂师诺斯","格罗布鲁斯","格拉斯","迈克斯纳","克尔苏加德",
	"符文大师莫尔基姆","唤雷者布隆迪尔","断钢者","维扎克斯将军","萨隆邪铁畸体","掌炉者伊格尼斯","观察者奥尔加隆","坍缩星","远古监护者",
	"穿刺者戈莫克","维扎克斯将军","萨隆邪铁畸体","护卫鞭笞者","寒冬亡魂","风暴看守者埃玛尔隆","风暴爪牙","托里姆","锋鳞","穿刺者戈莫克",



}

-- 检查当前目标是否为特定目标
local function updateAoepingbi()
	local targetName = UnitName("target")
	aoepingbi = true  -- 默认设置为 false
	if targetName then
		for _, name in ipairs(specificTargets) do
			if targetName == name then
				aoepingbi = false  -- 如果目标在列表中，设置为 true
				break
			end
		end
	end

end

-- 创建一个框架用于监听事件
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_TARGET_CHANGED")  -- 目标变更事件
frame:SetScript("OnEvent", function(self, event, ...)
	if event == "PLAYER_TARGET_CHANGED" then
		updateAoepingbi()  -- 调用函数更新 aoepingbi
	end
end)
