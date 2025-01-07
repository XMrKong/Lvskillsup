function LvSkillUps(searchValue)
    local r = gg.getResults(gg.getResultsCount())
    local totalResults = #r
    local processedResults = 0

    for i, v in ipairs(r) do
        if v.value == searchValue then
            local S = {}
            for j = 1, 8 do
                S[j] = {}
                S[j].address = v.address + 0x28 + 8 * (j - 1)
                S[j].flags = gg.TYPE_DWORD

                if j % 2 == 0 then
                    S[j].value = 9
                else
                    local currentValue = gg.getValues({{address = S[j].address, flags = S[j].flags}})
                    S[j].value = currentValue[1].value
                end

                S[j].freeze = true
                S[j].freezeType = gg.FREEZE_NORMAL
            end

            gg.setValues(S)
            gg.addListItems(S)
            gg.toast('Processing: Adjusting monster skill levels...')
            processedResults = processedResults + 1
        end
    end

    gg.clearList()
    gg.clearResults()
    gg.toast('Skill level adjustment completed!')
end
