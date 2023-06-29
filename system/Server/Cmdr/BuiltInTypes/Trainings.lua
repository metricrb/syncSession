local ReplicatedStorage = game:GetService('ReplicatedStorage')
local BindableFunction = ReplicatedStorage:WaitForChild('GetLiveSessions')
return function(p1)
	local cards = BindableFunction:Invoke('Trainings')
	local tbl = {}
	for i, v in pairs(cards) do
		table.insert(tbl, v)
	end;
	p1:RegisterType("trainings", p1.Cmdr.Util.MakeEnumType("Trainings", tbl));
end;


