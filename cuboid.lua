--Made by Nikdoge 20140825
--version 5
local tArgs = {...}
local lenght = tonumber(tArgs[1])
local width = tonumber(tArgs[2])
local depth = tonumber(tArgs[3])
local safety = tArgs[4]
if width==nil or lenght==nil or depth==nil or (safety~="unsafe" and safety~=nil) then
  print("Error: Wrong usage!")
  print("cuboid.p [lenght] [width] [depth] <unsafe>")
  return
end
if lenght<1 or width<1 or depth<1 then
  print("Error: Values should be more than 0!")
  return
end
local function tryDig()
  if safety=="unsafe" then
    turtle.Up()
  else
    while turtle.detect() do
      turtle.dig()
      sleep(1)
    end
  end
end
local function tryDigUp()
  if safety=="unsafe" then
    turtle.digUp()
  else
    while turtle.detectUp() do
      turtle.digUp()
      sleep(1)
    end
  end
end
print("Program Cuboid")
print("Version: 5")
print("Initializing data...")
print("Lenght (x) = "..lenght)
print("Width (y) = "..width)
print("Depth (z) = "..depth)
if safety=="unsafe" then
  print("Unsafe mode: fallen block check is disabled")
end
local layers=(depth-depth%3)/3 --Triple layers
turtle.turnRight()
if layers>0 then
  turtle.digDown()
  turtle.down()
  for k=1,layers,1 do
    if depth%3>0 then
      print("Layer "..k.."/"..layers+1)
    else
      print("Layer "..k.."/"..layers)
    end
    for j=1,lenght,1 do
      for i=1,width,1 do
        turtle.digDown()
        if i>1 or j>1 then tryDigUp() end
        if i<width then
          tryDig()
          turtle.forward()
        end --if
      end --width
      if j<lenght then
        if j%2==1 then
          turtle.turnLeft()
          tryDig()
          turtle.forward()
          turtle.turnLeft()
        else
          turtle.turnRight()
          tryDig()
          turtle.forward()
          turtle.turnRight()
        end
      end --if lenght
    end --lenght
    if k<layers or depth%3>0 then
      if lenght%2==1 then
        turtle.turnRight()
        turtle.turnRight()
      else
        for i=1,width-1,1 do turtle.back() end
      end
    end
    if k<layers then
      turtle.down()
      turtle.digDown()
      turtle.down()
      turtle.digDown()
      end
    turtle.down()
  end --depth
end --depth/3~=0
--last part
if depth%3>0 then
  turtle.digDown()
  turtle.down()
  print("Layer "..(layers+1).."/"..layers+1)
  for j=1,lenght,1 do
    for i=1,width,1 do
      if depth%3==2 then turtle.digDown() end
      if i<width then
        tryDig()
        turtle.forward()
      end --if
    end --width
    if j<lenght then
      if j%2==1 then
        turtle.turnLeft()
        tryDig()
        turtle.forward()
        turtle.turnLeft()
      else
        turtle.turnRight()
        tryDig()
        turtle.forward()
        turtle.turnRight()
      end
    end --if lenght
  end --lenght
end --depth%3>0
print("End of work")
