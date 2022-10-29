local menuengine = require "libraries/menuengine"
menuengine.settings.sndMove = love.audio.newSource("sound/ok.wav", "static")
menuengine.settings.sndSuccess = love.audio.newSource("sound/accepttest.wav", "static")
mainmenumusic = love.audio.newSource('music/music.mp3', 'stream')
mainmenumusic:setLooping( true )
NearMP3 = love.audio.newSource("music/Near.mp3", "stream")
Funny = love.audio.newSource("libraries/sti/Secret/Funny.ogg", "stream")
Funny:setLooping(true)
zombienumber1 = love.graphics.newImage("sprite/Zombie-1.png")

enemySpeed = 50
timer1 = 0
spawnTime = 1 -- delay of spawn in seconds

--Gun Variables
MaxBullets = 9
ReloadTime = 4
currentBulletAmount = 9
canShoot = true
Reloading = false
ShootSound = love.audio.newSource("sound/accepttest.wav", "static")
ReloadSound = love.audio.newSource("sound/reloading.mp3", "static") --Фрилм, потом сам выберешь и вставиишь его сюда, а потом идешь на 117 строку и там есть два комментария, их убираешь и всё, звук перезарядки
--вот так они выглядят там:

--ReloadSound:stop()
--ReloadSound:play()

--надеюсь понял...
--end

--Variables that deni needs :D
MusicToggled = true
--end :^

--Tables
bullets = {}
enemies = {}
--end

currentState = 1

text = "Nothing was selected."

-- Mainmenu
local mainmenu, Options, videoOptions


-- Start Game
local function New_game()
    text = "Start Game was selected!"
    currentState = 2
end

-- Options
local function options()
    currentState = 3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
end

-- Quit Game
local function quit_game()
    
    love.event.quit(0)
end

local function Multiplayer()
    text = "coming soon"
end

local function Sound()
    menuengine.disable()
    menu_three:setDisabled(false)
    menu_three.cursor = 1 
end 

function toggleallmusic()
    
    if MusicToggled == true then
        NearMP3:setVolume(0)
        mainmenumusic:setVolume(0)
        Funny:setVolume(0)
        MusicToggled = false
    else
        NearMP3:setVolume(1)
        mainmenumusic:setVolume(1)
        Funny:setVolume(1)
        MusicToggled = true
    end
end

function VideoOptionsMenu()
    currentState = 4
end    

function setResolution(OptionSelected)
    FullScr, fstype = love.window.getFullscreen()
    if OptionSelected == 1 then
        love.window.setMode(1920, 1080)
        love.window.setFullscreen(FullScr, "exclusive")
    elseif OptionSelected == 2 then
       love.window.setMode(1680, 1050)
       love.window.setFullscreen(FullScr, "exclusive")
    elseif OptionSelected == 3 then
       love.window.setMode(1280, 720)
       love.window.setFullscreen(FullScr, "exclusive")
    elseif OptionSelected == 4 then
        if FullScr == true then
            love.window.setFullscreen(false, "exclusive")
        else
            love.window.setFullscreen(true, "exclusive")
        end

    end    
end 

function ReturnMainMenu()
    currentState = 1
end 

Timer = 0

function Reload(dt)
    if Reloading == true then
        ReloadSound:stop()
        ReloadSound:play()
        canShoot = false
        Timer = Timer + dt
        if Timer > ReloadTime then
            canShoot = true
            currentBulletAmount = MaxBullets
            Reloading = false
        end
    end
end

----------------

function love.load()
    camera = require 'libraries/camera' --camera Module
    cam = camera()
    
    sti = require 'libraries/sti' --TileMaps Module
    gameMap = sti('maps/maptest.lua')

    love.window.setTitle("Unnamed Game 0.1.2 alpha")
    love.window.setFullscreen(true, "desktop")

    bulletImage = love.graphics.newImage("sprite/bullet.png")
    player = {}
    player.x = 300
    player.y = 200
    player.speed = 2
    player.sprite = love.graphics.newImage('sprite/player.png')
    heat = 0
	heatp = 0.1

    Something = love.graphics.newImage("libraries/sti/Secret/Red.. Hell, it starts.png")

    mainmenu = menuengine.new(400, 420)
    mainmenu:addEntry("New game", New_game, {}, love.graphics:getFont(), {0, 0, 0}, {1, 1, 1})
    mainmenu:addEntry("Multiplayer", Multiplayer, {}, love.graphics:getFont(), {0, 0, 0}, {1, 1, 1})
    mainmenu:addEntry("Options", options, {}, love.graphics:getFont(), {0, 0, 0}, {1, 1, 1})
    mainmenu:addSep()
    mainmenu:addEntry("Quit Game", quit_game, {}, love.graphics:getFont(), {0.5, 0, 0}, {1, 0, 0})

    optionsM = menuengine.new(400, 400)
    optionsM:addEntry("Toggle Music", toggleallmusic)
    optionsM:addEntry("Video Options", VideoOptionsMenu)
    optionsM:addEntry("Return To Main Menu", ReturnMainMenu)

    videoOptions = menuengine.new(400, 400)
    videoOptions:addEntry("Set Resolution To 1920x1080", setResolution, 1)
    videoOptions:addEntry("Set Resolution To 1680x1050", setResolution, 2)
    videoOptions:addEntry("Set Resolution To 1280x720", setResolution, 3)
    videoOptions:addEntry("Toggle FullScreen", setResolution, 4)
    videoOptions:addEntry("Return To Options", options)
    video = love.graphics.newVideo("videos/job.ogv")
    
    
    TextTimeToDie = menuengine.new(400, 400)
    TextTimeToDie:addEntry("Unnamed_Game", nil, {}, love.graphics:getFont(), {1, 1, 1}, {1, 1, 1})
end

function love.update(dt)
    if currentState == 1 then
        mainmenu:update() 
        video:play()
        Funny:pause()
        mainmenumusic:play()
    elseif currentState == 2 then --game update
        mainmenumusic:stop()
        NearMP3:play()
        local isMoving = false
        Reload(dt)

        

        if love.keyboard.isDown("d") then
            player.x = player.x + player.speed
        end

        if love.keyboard.isDown("a") then
            player.x = player.x - player.speed
        end

        if love.keyboard.isDown("s") then
            player.y = player.y + player.speed
        end

        if love.keyboard.isDown("w") then
            player.y = player.y - player.speed
        end

        cam:lookAt(player.x, player.y)

        local w = love.graphics.getWidth()
        local h = love.graphics.getHeight()

        -- Left border
        if cam.x < w/2 then
            cam.x = w/2
        end

        -- Right border
        if cam.y < h/2 then
            cam.y = h/2
        end

    
        
    

        -- Get width/height of background
        local mapW = gameMap.width * gameMap.tilewidth
        local mapH = gameMap.height * gameMap.tileheight

        -- Right border
        if cam.x > (mapW - w/2) then
            cam.x = (mapW - w/2)
        end
        -- Bottom border
        if cam.y > (mapH - h/2) then
            cam.y = (mapH - h/2)
        end

        --tx = -player.x + 400-32.5
        --ty = -player.y + 300
        --love.graphics.translate(tx,ty)

        --mx, my = love.mouse.getPosition()
        --worldMouseX = mx-tx
        --worldMouseY = my-ty
        --angleBetweenPlayerAndMouse = math.atan2(player.x, player.y, worldMouseX, worldMouseY)

        mx,my = cam:worldCoords(love.mouse.getPosition())
        angle = math.atan2(my-player.y , mx-player.x)

        heat = math.max(0, heat - dt)
        -- update bullets:
        
        for i, o in ipairs(bullets) do
            
            o.x = o.x + math.cos(o.dir) * o.speed * dt
            o.y = o.y + math.sin(o.dir) * o.speed * dt
        end
        -- clean up out-of-screen bullets:
        for i = #bullets, 1, -1 do
            local o = bullets[i]
            if (o.x > mapW + 10) or (o.y > mapH + 10) then
                table.remove(bullets, i)
            end
        end

        timer1 = timer1 + dt
        if timer1 > spawnTime then
            timer1 = 0
            table.insert(enemies, {
                x = love.graphics.getWidth()*0.8,
                y = love.graphics.getHeight()*0.8,
                number = love.math.random(1.2, 1.5)
            })
        end
        


        for i,v in ipairs(enemies) do

            

            dx = (player.x - v.x) + (enemySpeed * dt)
	        dy = (player.y - v.y) + (enemySpeed * dt)
            distance = math.sqrt(dx*dx+dy*dy)
	        v.x = v.x + (dx / distance * (enemySpeed*v.number) * dt)
	        v.y = v.y + (dy / distance * (enemySpeed*v.number) * dt)

            --distance = math.sqrt(enemyDirectionX * enemyDirectionX + enemyDirectionY * enemyDirectionY)
            --playerGlobalX, playerGlobalY = player.x, player.y
            --enemyGlobalX, enemyGlobalY = v.x, v.y
            --angle2 = math.atan2(playerGlobalY-enemyGlobalY, playerGlobalX-enemyGlobalX)
        end




    elseif currentState == 3 then
        optionsM:update()
        NearMP3:stop()
        mainmenumusic:pause()
        Funny:play()
    elseif currentState == 4 then
        videoOptions:update()
        NearMP3:stop()
        mainmenumusic:pause()
        Funny:play()
    end 
end

function love.mousereleased( x, y, button, istouch )
    if currentState == 2 then
        if button == 1 then
            if canShoot == true then --Стрельба
                if heat <= 0 then
                    if currentBulletAmount > 0 then
                        ShootSound:stop()
                        ShootSound:play()
                        local direction = angle
                        currentBulletAmount = currentBulletAmount - 1
                        table.insert(bullets, {
                            x = player.x,
                            y = player.y,
                            dir = direction,
                            speed = 5000
                        })
                        heat = heatp
                    end
                end
            end
        end 
    end
end   


function love.keypressed( key, scancode, isrepeat )
    if key == "escape" then
        love.event.quit()
    end

    if key == "r" then
        if Reloading == false then
            Reloading = true
            Timer = 0
        end
    end    
end

function love.draw()
    if currentState == 1 then --вот меню
        love.graphics.clear()
        love.graphics.draw(video, 0, 0)
        love.graphics.print(text, 0, 0)
        mainmenu:draw()
        TextTimeToDie:draw()
        
    elseif currentState == 2 then --Игра
    cam:attach()  
        gameMap:drawLayer(gameMap.layers["Ground"])
        gameMap:drawLayer(gameMap.layers["Trees"])
        love.graphics.draw(player.sprite, player.x, player.y, angle, 0.1, 0.1, 1170/2, 832/2)
        for i,v in ipairs(bullets) do
            love.graphics.circle("fill", v.x, v.y, 4)
        end

        for p,q in ipairs(enemies) do
            love.graphics.draw(zombienumber1, q.x, q.y, 30)
        end
    cam:detach()
    love.graphics.print("0.1.2 alpha", 0, 0)  
    elseif currentState == 3 then --вот настройки
        love.graphics.clear()
        love.graphics.draw(Something, love.graphics.getWidth()/2, love.graphics.getHeight()/3, 0, 0.1, 0.1, 256, 256)
        optionsM:draw()
    elseif currentState == 4 then
        love.graphics.clear()
        love.graphics.draw(Something, love.graphics.getWidth()/2, love.graphics.getHeight()/3, 0, 0.1, 0.1, 256, 256)
        videoOptions:draw()
    end
end

function love.mousemoved(x, y, dx, dy, istouch)
    menuengine.mousemoved(x, y)
end