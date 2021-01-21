local bombCoop = RegisterMod( "Golden Bomb Co-Op" ,1 );

local debug = false;


local function console(stuff)
  if debug then
    Isaac.ConsoleOutput(tostring(stuff))
  end
end

function bombCoop:onPlayerInit(player)
  console("player init");
  local player0 = Isaac.GetPlayer(0);
  console("got player 0");
  if not (player.ControllerIndex == player0.ControllerIndex) and player0:HasGoldenBomb() then
    player:AddGoldenBomb();
  end
  console("player init done");
end

bombCoop:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, bombCoop.onPlayerInit);


--[[
  On entering a new Level, the player has no golden key, add Callback to wait for golden Key Pickup
--]]
function bombCoop:onNewLevel()
  bombCoop:AddCallback(ModCallbacks.MC_POST_UPDATE, bombCoop.onUpdate);
  -- Debug code to ease getting golden bombs
  if debug then
    Isaac.ExecuteCommand("spawn 5.40.4");
  end
end
bombCoop:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, bombCoop.onNewLevel);


--[[
    Wait for the player to pickup a Golden Bomb, on Pickup give all other babies a Golden Bomb and disable the Callback until next level.
--]]
function bombCoop:onUpdate(entity)
  if Isaac.GetPlayer(0):HasGoldenBomb() then
    for i = 1, 3 do
      Isaac.GetPlayer(i):AddGoldenBomb();
    end
    bombCoop:RemoveCallback(ModCallbacks.MC_POST_UPDATE, bombCoop.onUpdate);
  end
end

-- Debug code to ease getting golden bombs

if debug then
  Isaac.ExecuteCommand("restart");
end