function Image(paragraph)
	local to_string = pandoc.utils.stringify
	if paragraph.classes:find("Pro", 1) then
		local file = io.open("all_collections/_people/" .. paragraph.src, "r")
		local doc = pandoc.read(file:read("*a")).meta
		file:close()
		local caption = to_string(doc.excerpt)
		local title = to_string(doc.title)
		local md = "#### " .. title .. " (κορμού)" .. "\n_" .. caption .. "_  \n "
		return pandoc.RawInline("markdown", md)
	end
end
