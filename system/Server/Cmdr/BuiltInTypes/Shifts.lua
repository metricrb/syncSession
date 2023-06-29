local ServerScriptService = game:GetService("ServerScriptService")

return function(p1)
	local cards = nil 
	local tbl = {}
	for i, v in pairs(cards) do
		table.insert(tbl, v)
	end;
	p1:RegisterType("shifts", p1.Cmdr.Util.MakeEnumType("Shifts", tbl));
end;

