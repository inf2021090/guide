function Image(paragraph)
	local to_string = pandoc.utils.stringify
	if paragraph.classes:find("labs", 1) then
		local file = io.open("all_collections/_groups/" .. paragraph.src, "r")
		local content = file:read("*a")
		file:close()

		local doc = pandoc.read(content)

		-- Metadata
		local meta = doc.meta
		local link = to_string(meta.link)
		local title = to_string(meta.title)

		-- process content after metadata
		local body = doc.blocks

		local md = "#### " .. title .. "\n\n" .. link .. "\n\n"

		-- process content blocks
		for _, block in ipairs(body) do
			if block.t == "Para" then
				md = md .. to_string(block)
			elseif block.t == "Header" then
				md = md .. "#" .. string.rep("#", block.level) .. " " .. to_string(block.content) .. "\n"
			elseif block.t == "BulletList" then
				for _, item in ipairs(block.content) do
					md = md .. "- " .. to_string(item) .. "\n\n"
				end
			elseif block.t == "OrderedList" then
				for _, item in ipairs(block.content) do
					md = md .. "1. " .. to_string(item) .. "\n"
				end
			end
		end
		return pandoc.RawInline("markdown", md)
	end
end
