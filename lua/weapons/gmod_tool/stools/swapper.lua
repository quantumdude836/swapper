
TOOL.Category = "Construction"
TOOL.Name = "#tool.swapper.name"

if CLIENT then
    language.Add("tool.swapper.name", "Swapper")
    language.Add("tool.swapper.desc", "Swaps two things")
    language.Add("tool.swapper.0", "Click the first thing to swap")
    language.Add("tool.swapper.1", "Click the second thing to swap")
end

function TOOL:LeftClick(tr)
    -- world entity counts as not valid
    if !IsValid(tr.Entity) || tr.Entity:IsPlayer() then return false end
    
    local stage = self:GetStage()
    if stage == 0 then
        if CLIENT then return true end
        self.FirstThing = tr.Entity
        self:SetStage(1)
        return true
    elseif stage == 1 then
        if CLIENT then return true end
        if tr.Entity != self.FirstThing then -- no need to swap a thing with itself
            local thing1 = self.FirstThing
            local thing2 = tr.Entity
            -- swap position
            local tmp = thing1:GetPos()
            thing1:SetPos(thing2:GetPos())
            thing2:SetPos(tmp)
            -- TODO: swap other attributes
        end
        self.FirstThing = nil
        self:SetStage(0)
        return true
    else
        stage = 0
    end
end

function TOOL:RightClick(tr)
    return false
end

function TOOL:Reload(tr)
    return false
end

function TOOL:Holster()
    self.FirstThing = nil
    self:SetStage(0)
end

function TOOL.BuildCPanel(panel)
    panel:AddControl("Header", { Text = "#tool.swapper.name", Description = "#tool.swapper.desc" })
end
