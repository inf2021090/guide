function Image(paragraph)
    local to_string = pandoc.utils.stringify
    if paragraph.classes:find('labs', 1) then
        local file = io.open("all_collections/_groups/" .. paragraph.src, 'r')
        local content = file:read('*a')
        file:close()

        local doc = pandoc.read(content)

        -- Extract Metadata
        local meta = doc.meta
        local link = to_string(meta.link)
        local title = to_string(meta.title)

        -- Process content after metadata
        local body = doc.blocks  -- This will contain the content after metadata
        
        local md = '#### ' .. title .. '\n_' .. link .. '_\n'

        -- Process content blocks (e.g., concatenate paragraphs)
        for _, block in ipairs(body) do
            if block.t == "Para" then
                md = md .. to_string(block)
            elseif block.t == "Header" then
                md = md .. '#' .. string.rep('#', block.level) .. ' ' .. to_string(block.content) .. '\n'
            -- Add more conditions to handle other block types if needed
            end
        end

        return pandoc.RawInline('markdown', md)
    end
end
