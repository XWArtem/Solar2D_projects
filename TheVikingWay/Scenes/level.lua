        -- Import

        local composer = require("composer")
        local relayout = require("libs.relayout")
        --local utilities = require("classes.utilities")
        local data = require("classes.data")
        local dataAudio = require("classes.dataAudio")
        local dataInit = require("classes.dataInit")

        -- variables
        local backgrounds = {}
        local barrels = {
            {image = "Assets/game/BARREL.png", width = 177* data.getRatioX(), height = 173* data.getRatioX(), isCoin = false},
            {image = "Assets/game/BARREL.png", width = 177* data.getRatioX(), height = 173* data.getRatioX(), isCoin = false},
            {image = "Assets/game/BARREL.png", width = 177* data.getRatioX(), height = 173* data.getRatioX(), isCoin = false},
            {image = "Assets/game/BARREL.png", width = 177* data.getRatioX(), height = 173* data.getRatioX(), isCoin = false},
          }
        local health_0
        local health_1
        local health_2
        local timer
        local distance = 0
        local gold
        local frameDelay = 10
        local distanceToNextEnemy = 300
        local shootDistanceCooldown = 300
        local fireball_enemy
        local fireball_enemy_is_active
        local enemyIsActive
        local coinsText
        local distanceBarText
        local fireball_distance_to_hit
        local framesToResetFireButton = 50
        local fireButtonOnCooldown
        local buttonFire
        local buttonShield
        local buttonShieldTimer
        local bullets
        local shieldAnim
        local blow

        -- pause
        local buttonClose
        local backgroundPause
        local isPaused
        local buttonImproving
        local buttonQuit
        local buttonSound
        local buttonMusic

        --input
        local isTouching
        local touchX
        local touchY

        -- units
        local mainHero
        local enemy

        -- audio
        local canonSounds = {}
        canonSounds.next = 1
        canonSounds.len = 6

        local coinSound = audio.loadStream("Assets/sound/coin.mp3")
        -- scene
        local scene = composer.newScene()
        
        -- groups
        local _grpMain
        local _UI
        local _pauseLayer

        --function declaration
        local hitBarrel
        local fire

        --sounds
        --local _bgMusic = audio.loadStream("Assets/sound/bg.mp3")

        -- local functions
        local function initLevelScene()
            data.setHeroHealth(3)
            distance = dataInit.getinitDistance()
            gold = data.getGold()

            backgrounds[1].x = relayout._CX
            backgrounds[2].x = relayout._CX
            backgrounds[3].x = relayout._CX
            backgrounds[4].x = relayout._CX
            backgrounds[5].x = relayout._CX
            backgrounds[6].x = relayout._CX
            backgrounds[7].x = relayout._CX

            backgrounds[1].y = display.contentHeight/2
            backgrounds[2].y = display.contentHeight/2 - 1600* data.getRatioX()
            backgrounds[3].y = display.contentHeight/2 - 2* 1600* data.getRatioX()
            backgrounds[4].y = display.contentHeight/2 + 2* 1600* data.getRatioX()
            backgrounds[5].y = display.contentHeight/2 + 1600* data.getRatioX()
            backgrounds[6].y = display.contentHeight/2 + 3* 1600* data.getRatioX()
            backgrounds[7].y = display.contentHeight/2 - 3* 1600* data.getRatioX()
            -- print("1 Y IS: ", backgrounds[1].y)
            -- print("2 Y IS: ", backgrounds[2].y)
            -- print("3 Y IS: ", backgrounds[3].y)
            -- print("4 Y IS: ", backgrounds[4].y)
            -- print("5 Y IS: ", backgrounds[5].y)
            -- print("6 Y IS: ", backgrounds[6].y)
            -- print("7 Y IS: ", backgrounds[7].y)
            
            if (fireball_enemy ~= nil) then
                fireball_enemy:removeSelf()
                fireball_enemy = nil
                fireball_enemy_is_active = false
            end
            

            -- barrels
            barrels[1].y = relayout._CY - display.contentHeight -- it's the top of screen
            barrels[2].y = relayout._CY - 1.5 * display.contentHeight
            barrels[3].y = relayout._CY - 2.2 * display.contentHeight
            barrels[4].y = relayout._CY - 2.7* display.contentHeight

            for i = 1, #barrels do
                barrels[i].isCoin = false
                barrels[i].fill = { type = "image", filename = "Assets/game/BARREL.png" }
                barrels[i].height = 177* data.getRatioX()
                barrels[i].width = 173* data.getRatioX()
                barrels[i].x = relayout._CX + math.random(-3, 3) * display.contentWidth * 0.1
                
                barrels[i]:addEventListener("tap", hitBarrel)
            end
            
            -- barrels
            barrels[1].y = relayout._CY - display.contentHeight -- it's the top of screen
            barrels[2].y = relayout._CY - 1.5 * display.contentHeight
            barrels[3].y = relayout._CY - 2.2 * display.contentHeight
            barrels[4].y = relayout._CY - 2.7* display.contentHeight

            -- health bar
            health_0.x = relayout._CX - display.contentWidth * 0.06
            health_0.y = display.contentCenterY + display.contentHeight * 0.44

            health_1.x = relayout._CX
            health_1.y = display.contentCenterY + display.contentHeight * 0.44

            health_2.x = relayout._CX + display.contentWidth * 0.06
            health_2.y = display.contentCenterY + display.contentHeight * 0.44

            health_2.fill = { type = "image", filename = "Assets/game/LIVE.png" }
            health_1.fill = { type = "image", filename = "Assets/game/LIVE.png" }
            health_0.fill = { type = "image", filename = "Assets/game/LIVE.png" }
            --units
            if (data.getCurrentShipIndex() == 0) then
                mainHero.fill = { type = "image", filename = "Assets/game/SHIP_DEFOLT.png" }
            elseif (data.getCurrentShipIndex() == 1) then
                mainHero.fill = { type = "image", filename = "Assets/game/SHIP_1.png" }
            elseif (data.getCurrentShipIndex() == 2) then
                mainHero.fill = { type = "image", filename = "Assets/game/SHIP_2.png" }
            elseif (data.getCurrentShipIndex() == 3) then
                mainHero.fill = { type = "image", filename = "Assets/game/SHIP_3.png" }
            end

            mainHero.x = relayout._CX
            mainHero.y = display.contentCenterY + display.contentHeight * 0.34
            display.remove(enemy)
            enemy = nil
            --timer
            timer.x = relayout._CX + math.random(-3, 3) * display.contentWidth * 0.1
            timer.y = math.random(-3, -2) * display.contentHeight
            
            -- shieldAnim
            shieldAnim:setFillColor(1, 1, 1, 0)
            shieldAnim.x = mainHero.x
            shieldAnim.y = mainHero.y

            --update some values
            data.setFramesForBlow(0)
            data.setFramesShieldAnim(0)
            data.setMainHeroProtected(false)
            data.setButtonShieldOnCooldown(false, 0)
            buttonShieldTimer:setTextColor(35/255, 18/255, 4/255, 0)
            distanceToNextEnemy = 300
            --bullets
            bullets = {}
            bullets.next = 1
            bullets.len = 16
            
            for i = 1, bullets.len do
                local b = {}
                b.active = 0
                b.framesToReachTarget = 0
                b.x = relayout._CX
                b.y = relayout._CY
                bullets[i] = b
            end

            -- button fire
            if (data.getCurrentShipIndex() ~= 0) then
                buttonFire.fill = { type = "image", filename = "Assets/game/SHOOT-BTN_active.png" }
                buttonFire:addEventListener("tap", fire)
            else
                buttonFire.fill = { type = "image", filename = "Assets/game/SHOOT-BTN.png" }
            end
            fireButtonOnCooldown = false

            -- sound and music
            if (data.getSound() == true) then
                buttonSound.fill = {type = "image", filename = "Assets/setting_pause/SOUND_on.png"}
            else 
                buttonSound.fill = {type = "image", filename = "Assets/setting_pause/SOUND_off.png"}
            end

            if (data.getMusic() == true) then
                buttonMusic.fill = {type = "image", filename = "Assets/setting_pause/MUSIC_on.png"}
            else 
                buttonMusic.fill = {type = "image", filename = "Assets/setting_pause/MUSIC_off.png"}
            end
        end

        local function soundToggle()
            if (isPaused == true) then
                if (data.getSound() == true) then
                    data.setSound(false)
                    buttonSound.fill = {type = "image", filename = "Assets/setting_pause/SOUND_off.png"}
                else data.setSound(true)
                    buttonSound.fill = {type = "image", filename = "Assets/setting_pause/SOUND_on.png"}
                end
                data.save()
            end
        end

        local function musicToggle()
            if (isPaused == true) then
                if (data.getMusic() == true) then
                    data.setMusic(false)
                    buttonMusic.fill = {type = "image", filename = "Assets/setting_pause/MUSIC_off.png"}
                else data.setMusic(true)
                    buttonMusic.fill = {type = "image", filename = "Assets/setting_pause/MUSIC_on.png"}
                end
                data.save()
            end
        end

        local function closePause()
            isPaused = false
            _pauseLayer:toBack()
        end

        local function spawnEnemy()
            enemy = display.newImageRect( _grpMain, "Assets/game/enemy-ship.png", 154* data.getRatioX(), 328* data.getRatioX())
            enemy.x = relayout._CX
            enemy.y = - display.contentHeight * 0.2
            enemyIsActive = true
            data.setEnemyHealth(3)
        end

        local function pause()
            print("SCENE PAUSED")
            _pauseLayer:toFront()
            isPaused = true
            data.save()
            buttonClose:addEventListener("tap", closePause)
        end

        local function touchListener(event)
            if ( event.phase == "began" or event.phase == "moved") then
                isTouching = true
                touchX = event.x
                touchY = event.y
            elseif ( event.phase == "ended" ) then
                isTouching = false
            end

            return true  -- Prevents tap/touch propagation to underlying objects
        end

        local function gotoImproving()
            if isPaused then
                _pauseLayer:toBack()
                composer.gotoScene("Scenes.improving")
            end
        end

        local function gotoMenu()
            if isPaused then
                _pauseLayer:toBack()
                data.save()
                composer.gotoScene("Scenes.menu")
            end
        end

        local function activateShield()
            if (data.getMainHeroProtected() == false) then
                data.setMainHeroProtected(true)
                data.setButtonShieldOnCooldown(true, 120)
                buttonShieldTimer.text = "2s"
                buttonShieldTimer:setTextColor(35/255, 18/255, 4/255, 1)
                shieldAnim:setFillColor(1, 1, 1, 1)
            end
        end

        local function takeTimer()
            print("TIMER")
            timer.y = math.random(-3, -2) * display.contentHeight
            data.setMainHeroProtected(true)
            data.setButtonShieldOnCooldown(true, 600)
            buttonShieldTimer.text = "10s"
            buttonShieldTimer:setTextColor(35/255, 18/255, 4/255, 1)
            shieldAnim:setFillColor(1, 1, 1, 1)
        end

        local function shoot()
            bullets[bullets.next] = display.newImageRect( _grpMain, "Assets/game/fire-ball1/fire-ball_1.png", 37* data.getRatioX(), 64 * data.getRatioX())
            bullets[bullets.next].x = mainHero.x
            bullets[bullets.next].y = mainHero.y - 150 * data.getRatioX()
            bullets[bullets.next].rotation = 180
            bullets[bullets.next].framesToReachTarget = display.contentHeight/2
            bullets[bullets.next].active = 1
            bullets[bullets.next].targetY = bullets[bullets.next].y - relayout._CY - display.contentHeight

            print(bullets[bullets.next].framesToReachTarget)
            -- print(bullets[bullets.next].x)
            if (dataAudio.getIsAudioChannelBusy2() == false) then 
                audio.play(canonSounds[canonSounds.next], { channel = 2, loops = 0 })
                print("AudioChannel2")
            elseif (dataAudio.getIsAudioChannelBusy3() == false) then
                audio.play(canonSounds[canonSounds.next], { channel = 3, loops = 0 })
                print("AudioChannel3")
            elseif (dataAudio.getIsAudioChannelBusy4() == false) then 
                audio.play(canonSounds[canonSounds.next], { channel = 4, loops = 0 })
                print("AudioChannel4")
            elseif (dataAudio.getIsAudioChannelBusy5() == false) then 
                audio.play(canonSounds[canonSounds.next], { channel = 5, loops = 0 })
                print("AudioChannel5")
            end
            canonSounds.next = (canonSounds.next % canonSounds.len) + 1
            bullets.next = (bullets.next % bullets.len) + 1
        end

        function fire()
            if (fireButtonOnCooldown == false) then
                -- cooldown button
                fireButtonOnCooldown = true
                buttonFire.fill = { type = "image", filename = "Assets/game/SHOOT-BTN-PUSH.png" }
                framesToResetFireButton = 60
                -- shoot
                shoot()
            end
        end

        function returnBarrel(barrel)
            local index
            if (barrel == barrels[1]) then index = 1
            elseif (barrel == barrels[2]) then index = 2
            elseif (barrel == barrels[3]) then index = 3
            elseif (barrel == barrels[4]) then index = 4
            end

            barrels[index].fill = { type = "image", filename = "Assets/game/BARREL.png" }
                barrels[index].height = 177* data.getRatioX()
                barrels[index].width = 173* data.getRatioX()
                barrels[index].x = relayout._CX
                barrels[index].y = barrels[index].y - 3* display.contentHeight
                barrels[index].isCoin = false
        end

        function hitBarrel(event)
            local sender = event.target
            local index
            if (sender == barrels[1]) then index = 1
            elseif (sender == barrels[2]) then index = 2
            elseif (sender == barrels[3]) then index = 3
            elseif (sender == barrels[4]) then index = 4
            end

            if (barrels[index].isCoin == false) then
                barrels[index].fill = { type = "image", filename = "Assets/game/coin.png" }
                barrels[index].isCoin = true
                gold = gold + 20

                if (dataAudio.getIsAudioChannelBusy2() == false) then 
                    audio.play(coinSound, { channel = 2, loops = 0 })
                    print("AudioChannel2")
                elseif (dataAudio.getIsAudioChannelBusy3() == false) then
                    audio.play(coinSound, { channel = 3, loops = 0 })
                    print("AudioChannel3")
                elseif (dataAudio.getIsAudioChannelBusy4() == false) then 
                    audio.play(coinSound, { channel = 4, loops = 0 })
                    print("AudioChannel4")
                elseif (dataAudio.getIsAudioChannelBusy5() == false) then 
                    audio.play(coinSound, { channel = 5, loops = 0 })
                    print("AudioChannel4")
                    --canonSounds.next = (canonSounds.next % canonSounds.len) + 1
                end
            end
        end

        local function hitMainHero(damage)
            if (data.getMainHeroProtected() == false) then
                data.setHeroHealth(data.getHeroHealth() - damage)
                if (data.getHeroHealth() == 2)  then
                    health_2.fill = { type = "image", filename = "Assets/game/LIVE-OUT.png" }
                end
                if (data.getHeroHealth() == 1)  then
                    health_1.fill = { type = "image", filename = "Assets/game/LIVE-OUT.png" }
                end
                if (data.getHeroHealth() == 0)  then
                    health_0.fill = { type = "image", filename = "Assets/game/LIVE-OUT.png" }
                end
                if (data.getHeroHealth() <= 0) then
                    print("GAME OVER")
                    isPaused = true
                    gotoMenu()
                    data.save()
                end
                print(data.getHeroHealth())
                            -- for blow
                blow.y = mainHero.y - 150*data.getRatioX()
                blow.x = mainHero.x
                data.setFramesForBlow(25)
            end
        end

        local function moveBg()
            for i = 1, #backgrounds do
                backgrounds[i].y = backgrounds[i].y + data.getSpeed()
            end
        end

        local function onAccelerometer(event)
                data.setAccelSpeed(event.xGravity * 25)
            --  end
        end

        local function moveRect()
            if not isPaused then

                -- ///// backgrounds
                moveBg()
                --Reset the position if the bg goes off the screen
                for i = 1, #backgrounds do
                    if backgrounds[i].y > display.contentHeight + backgrounds[i].height * 3 then
                        print("BACKGROUND CHANGE Y")
                        print("i is: ", i)
                        backgrounds[i].y = display.contentHeight/2 - 3* 1600* data.getRatioX()
                        print("NEW Y IS: ", backgrounds[i].y)
                    end
                end

                -- ////// barrels
                for i = 1, #barrels do
                    if (barrels[i].isCoin == false) then
                        barrels[i].y = barrels[i].y + data.getSpeed()
                    else
                        barrels[i].x = barrels[i].x + (coinsText.x - barrels[i].x) * data.getSpeed() * 0.05
                        barrels[i].y = barrels[i].y + (coinsText.y - barrels[i].y) * data.getSpeed()* 0.05
                        -------------------------------- HERE
                        if (coinsText.x - barrels[i].x < 100 * data.getRatioX() and coinsText.y - barrels[i].y < 100 * data.getRatioX()) then
                            --print("return barrel")
                            returnBarrel(barrels[i])
                        end
                    end
                end
                -- timer
                timer.y = timer.y + data.getSpeed()

                -- Reset the position if the bareel goes off the screen
                for i = 1, #barrels do
                    if (barrels[i].y > display.contentHeight + barrels[i].height) then
                        barrels[i].y = relayout._CY - 3 * display.contentHeight
                        barrels[i].x = relayout._CX + math.random(-3, 3) * display.contentWidth * 0.1
                    end
                end

                -- Reset the position if timer goes off the screen
                if (timer.y > display.contentHeight + timer.height) then
                    timer.y = math.random(-3, -2) * display.contentHeight
                end

                --move the mainHero
                mainHero.x = mainHero.x + data.getSpeed() * data.getAccelSpeed()
                if (mainHero.x < relayout._CX * 0.2) then
                    mainHero.x = relayout._CX * 0.2
                elseif (mainHero.x > relayout._CX * 1.8) then
                    mainHero.x = relayout._CX * 1.8
                else
                    health_0.x = health_0.x + data.getSpeed() * data.getAccelSpeed()
                    health_1.x = health_1.x + data.getSpeed() * data.getAccelSpeed()
                    health_2.x = health_2.x + data.getSpeed() * data.getAccelSpeed()
                end
                    

                --update shieldAnim pos
                shieldAnim.x = mainHero.x
                shieldAnim.y = mainHero.y

                -- update gold and distance
                frameDelay = frameDelay - 1
                if frameDelay <= 0 then
                    gold = gold + 1
                    distance = distance + 1
                    data.setGold(gold)
                    --print(gold)
                    coinsText.text = gold
                    distanceBarText.text = distance
                    distanceToNextEnemy = distanceToNextEnemy - 1
                    if (distanceToNextEnemy < 0) then
                        if (enemyIsActive == false) then
                            spawnEnemy()
                        end
                        distanceToNextEnemy = 300
                    end
                    frameDelay = 10
                end

                --enemy
                if (enemyIsActive == true) then
                    enemy.y = enemy.y + data.getSpeed() * 0.5
                    if (enemy.y > display.contentHeight * 0.05) then
                        shootDistanceCooldown = shootDistanceCooldown - 1
                        if (shootDistanceCooldown < 0 and fireball_enemy_is_active == false and
                        enemy.y < mainHero.y - 400 * data.getRatioX()) then
                            print("Shoot!")
                            audio.play(canonSounds[canonSounds.next], { channel = 6, loops = 0 })
                            fireball_enemy = display.newImageRect( _grpMain, "Assets/game/fire-ball1/fire-ball_1.png", 37* data.getRatioX(), 64 * data.getRatioX())
                            fireball_enemy.x = enemy.x
                            fireball_enemy.y = enemy.y
                            fireball_enemy_is_active = true
                            shootDistanceCooldown = 300
                            -- save hero target X and Y
                            data.setHeroTargetX(mainHero.x)
                            data.setHeroTargetY(mainHero.y)
                            -- calculate the step
                            fireball_distance_to_hit = math.abs(fireball_enemy.y - mainHero.y)/2
                            print(fireball_distance_to_hit)
                        end
                    end

                    -- Reset the position if an enemy goes off the screen
                    if (enemyIsActive == true and enemy.y > display.contentHeight + enemy.height) then
                        enemyIsActive = false
                        enemy:removeSelf()
                    end
                    -- check the collision with mainHero
                    if (enemyIsActive == true and 
                    math.abs(enemy.y - mainHero.y) < 250 * data.getRatioX() and
                    math.abs(enemy.x - mainHero.x) < 120 * data.getRatioX()) then
                        hitMainHero(3)
                        enemyIsActive = false
                        enemy:removeSelf()
                        print ("COLLISION")
                    end
                end
                -- enemy fireball
                if (fireball_enemy_is_active == true) then
                    fireball_enemy.x = fireball_enemy.x + (-(fireball_enemy.x - data.getHeroTargetX())/fireball_distance_to_hit)
                    fireball_enemy.y = fireball_enemy.y + (-(fireball_enemy.y - data.getHeroTargetY())/fireball_distance_to_hit)
                    fireball_distance_to_hit = fireball_distance_to_hit - 1
                    if (math.abs(fireball_enemy.x - mainHero.x) < 50 * data.getRatioX()
                        and math.abs(fireball_enemy.y - mainHero.y) < 150 * data.getRatioX()) then
                        print("HIT!")
                        hitMainHero(1)
                        fireball_enemy:removeSelf()
                        fireball_enemy = nil
                        fireball_enemy_is_active = false
                    end
                    if (fireball_enemy ~= nil) then
                        if (fireball_enemy.y > display.contentHeight) then
                            print("Fireball is out of range!")
                            fireball_enemy:removeSelf()
                            fireball_enemy = nil
                            fireball_enemy_is_active = false
                        end
                    end
                end

                -- Fire button cooldown coroutine
                if (fireButtonOnCooldown) then
                    framesToResetFireButton = framesToResetFireButton - 1
                    if (framesToResetFireButton < 45) then
                        buttonFire.fill = { type = "image", filename = "Assets/game/SHOOT-BTN.png" }
                    end

                    if (framesToResetFireButton < 1) then
                        fireButtonOnCooldown = false
                        buttonFire.fill = { type = "image", filename = "Assets/game/SHOOT-BTN_active.png" }
                    end
                end

                for i = 1, #bullets do
                    -- move
                    if (bullets[i].active == 1) then
                        if (bullets[i].framesToReachTarget > 0) then
                            -- bullets[i].x = bullets[i].x + (-(bullets[i].x - enemy.x)/bullets[i].framesToReachTarget)
                            bullets[i].y = bullets[i].y + (-(bullets[i].y - bullets[i].targetY)/bullets[i].framesToReachTarget)
                            bullets[i].framesToReachTarget = bullets[i].framesToReachTarget - 1
                        end
                        -- check the collision if enemy is alive
                        if (enemy ~= nil and enemyIsActive == true and
                        math.abs(enemy.x - bullets[i].x) < 50 * data.getRatioX() and
                        math.abs(enemy.y - bullets[i].y) < 150 * data.getRatioX()) then
                            print("enemy.x" .. enemy.x)
                            print("enemy.y" .. enemy.y)
                            print("HIT THE ENEMY!")
                            -- destroy the bullet
                            bullets[i].active = false
                            bullets[i]:removeSelf()
                            --bullets[i] = nil

                            -- Take damage: enemy
                            data.setEnemyHealth(data.getEnemyHealth() - data.getCurrentShipIndex())
                                if (data.getEnemyHealth() < 1) then
                                    enemyIsActive = false
                                    enemy:removeSelf()
                                    print("Enemy is dead")
                                end
                        end
                        -- check if cross the screen top boundary
                        if (bullets[i] ~= nil and bullets[i].y < bullets[i].targetY) then
                            -- destroy the bullet
                            bullets[i].active = false
                            bullets[i]:removeSelf()
                        end
                    end
                end

                -- blow animation
                if (data.getFramesForBlow() > 0) then
                    data.setFramesForBlow(data.getFramesForBlow() - 1)
                    if (data.getFramesForBlow() > 20) then
                        blow:setFillColor(1, 1, 1, 1)
                        blow.width = 44* data.getRatioX()
                        blow.height = 42* data.getRatioX()
                    elseif (data.getFramesForBlow() > 15) then
                        blow:setFillColor(1, 1, 1, 0.8)
                        blow.width = 53* data.getRatioX()
                        blow.height = 50* data.getRatioX()
                    elseif (data.getFramesForBlow() > 10) then
                        blow:setFillColor(1, 1, 1, 0.6)
                        blow.width = 64* data.getRatioX()
                        blow.height = 60* data.getRatioX()
                    elseif (data.getFramesForBlow() > 5) then
                        blow:setFillColor(1, 1, 1, 0.4)
                        blow.width = 70* data.getRatioX()
                        blow.height = 66* data.getRatioX()
                    end
                else
                    blow:setFillColor(1, 1, 1, 0)
                end

                -- button shield cooldown
                if (data.getButtonShieldOnCooldown() == true) then
                    if (data.getFramesToResetBtnShield() > 1) then
                        data.setFramesToResetBtnShield(data.getFramesToResetBtnShield() - 1)
                        -- if (data.getFramesToResetBtnShield() < 60) then
                            buttonShieldTimer.text = math.ceil(data.getFramesToResetBtnShield()/60) .. "s"
                        -- end
                    else
                        data.setButtonShieldOnCooldown(false, 0)
                        data.setMainHeroProtected(false)
                        buttonShieldTimer:setTextColor(35/255, 18/255, 4/255, 0)
                        shieldAnim:setFillColor(1, 1, 1, 0)
                    end
                end
                -- shieldAnimation
                if (data.getMainHeroProtected() == true)then
                    if (data.getFramesShieldAnim() > 1) then
                        data.setFramesShieldAnim(data.getFramesShieldAnim() - 1)
                    else
                        if (data.getShieldAnimIndex() == 1) then
                            data.setShieldAnimIndex(2)
                            shieldAnim.fill = {type = "image", filename="Assets/game/shuield_anim/2.png"}
                        elseif (data.getShieldAnimIndex() == 2) then
                            data.setShieldAnimIndex(3)
                            shieldAnim.fill = {type = "image", filename="Assets/game/shuield_anim/3.png"}
                        elseif (data.getShieldAnimIndex() == 3) then
                            data.setShieldAnimIndex(1)
                            shieldAnim.fill = {type = "image", filename="Assets/game/shuield_anim/1.png"}
                        end
                        data.setFramesShieldAnim(10)
                    end
                end
            end
        end

        -- scene events functions

        function scene:create( event )
            print("scene:create - level")
            --sounds
            for i = 1, canonSounds.len do
                canonSounds[i] = audio.loadSound("Assets/sound/canon.mp3")
            end

            -- 
            _pauseLayer = display.newGroup()
            _grpMain = display.newGroup()
            _UI = display.newGroup()
            ---------------------------------------------------PAUSE-----------------------------
            backgroundPause = display.newImageRect(_pauseLayer, "Assets/start/start_bg.png", display.actualContentWidth, display.actualContentHeight)
            --backgroundPause = display.newImageRect(_pauseLayer, "Assets/start/start_bg.png", display.actualContentWidth* data.getRatioX(), display.actualContentHeight* data.getRatioX())
            backgroundPause.x = relayout._CX
            backgroundPause.y = relayout._CY
            
            buttonClose = display.newImageRect(_pauseLayer, "Assets/setting_pause/CLOSE-BTN.png", 106* data.getRatioX(), 106* data.getRatioX())
            buttonClose.x = relayout._CX + display.contentWidth * 0.42
            buttonClose.y = display.contentCenterY - display.contentHeight * 0.44

            local pauseTitle = display.newText("PAUSE", relayout._CX, relayout._CY - relayout._CY * 0.4, "Assets/font/DALEK__.ttf", 204* data.getRatioX())
            pauseTitle:setTextColor(255, 216, 0)
            _pauseLayer:insert(pauseTitle)

            buttonImproving = display.newImageRect(_pauseLayer, "Assets/setting_pause/improving-BTN.png", 472* data.getRatioX(), 157* data.getRatioX())
            buttonImproving.x = relayout._CX
            buttonImproving.y = relayout._CY

            buttonQuit = display.newImageRect(_pauseLayer, "Assets/setting_pause/quit-BTN.png", 472* data.getRatioX(), 157* data.getRatioX())
            buttonQuit.x = relayout._CX
            buttonQuit.y = relayout._CY + relayout._CY * 0.2

            buttonSound = display.newImageRect(_pauseLayer, "Assets/setting_pause/SOUND_on.png", 209* data.getRatioX(), 209* data.getRatioX())
            buttonSound.x = relayout._CX + relayout._CX * 0.22
            buttonSound.y = relayout._CY + relayout._CY * 0.46

            buttonMusic = display.newImageRect(_pauseLayer, "Assets/setting_pause/MUSIC_on.png", 209* data.getRatioX(), 209* data.getRatioX())
            buttonMusic.x = relayout._CX - relayout._CX * 0.22
            buttonMusic.y = relayout._CY + relayout._CY * 0.46

            ---------------------------------------MAIN--------------------------------------
            --bg
            backgrounds[1] = display.newImageRect(_grpMain, "Assets/game/sea_bg.png", 1200* data.getRatioX(), 1600* data.getRatioX())
            backgrounds[2] = display.newImageRect(_grpMain, "Assets/game/sea_bg.png", 1200* data.getRatioX(), 1600* data.getRatioX())
            backgrounds[3] = display.newImageRect(_grpMain, "Assets/game/sea_bg.png", 1200* data.getRatioX(), 1600* data.getRatioX())
            backgrounds[4] = display.newImageRect(_grpMain, "Assets/game/sea_bg.png", 1200* data.getRatioX(), 1600* data.getRatioX())
            backgrounds[5] = display.newImageRect(_grpMain, "Assets/game/sea_bg.png", 1200* data.getRatioX(), 1600* data.getRatioX())
            backgrounds[6] = display.newImageRect(_grpMain, "Assets/game/sea_bg.png", 1200* data.getRatioX(), 1600* data.getRatioX())
            backgrounds[7] = display.newImageRect(_grpMain, "Assets/game/sea_bg.png", 1200* data.getRatioX(), 1600* data.getRatioX())

            --barrels   
            for i = 1, #barrels do
                barrels[i] = display.newImageRect(_grpMain, barrels[i].image, barrels[i].width, barrels[i].height)
                --barrels[i]:addEventListener("tap", hitBarrel)
            end

            --units
                --units
            if (data.getCurrentShipIndex() == 0) then
                mainHero = display.newImageRect(_grpMain, "Assets/game/SHIP_DEFOLT.png", 278* data.getRatioX(), 389* data.getRatioX())
            elseif (data.getCurrentShipIndex() == 1) then
                mainHero = display.newImageRect(_grpMain, "Assets/game/SHIP_1.png", 278* data.getRatioX(), 389* data.getRatioX())
            elseif (data.getCurrentShipIndex() == 2) then
                mainHero = display.newImageRect(_grpMain, "Assets/game/SHIP_2.png", 278* data.getRatioX(), 389* data.getRatioX())
            elseif (data.getCurrentShipIndex() == 3) then
                mainHero = display.newImageRect(_grpMain, "Assets/game/SHIP_3.png", 278* data.getRatioX(), 389* data.getRatioX())
            end

            shieldAnim = display.newImageRect(_grpMain, "Assets/game/shuield_anim/1.png", 368* data.getRatioX(), 390* data.getRatioX())
            scene.view:insert(_grpMain)

            --blow
            blow = display.newImageRect(_grpMain, "Assets/game/fire-ball1/blow.png", 44* data.getRatioX(), 42* data.getRatioX())
            blow:setFillColor(1, 1, 1, 0)
            blow.rotation = 180
            -------------------------------------------UI----------------------------------------I

            local buttonPause = display.newImageRect(_UI, "Assets/game/pause_btn.png", 106* data.getRatioX(), 106* data.getRatioX())
            buttonPause.x = relayout._CX - display.contentWidth * 0.42
            buttonPause.y = display.contentCenterY - display.contentHeight * 0.44

            local distanceBar = display.newImageRect(_UI, "Assets/game/DISTANCE-BAR.png", 339* data.getRatioX(), 127* data.getRatioX())
            distanceBar.x = relayout._CX
            distanceBar.y = display.contentCenterY - display.contentHeight * 0.44

            distanceBarText = display.newText('0', distanceBar.x, distanceBar.y, "Assets/font/DALEK__.ttf", 50* data.getRatioX())
            _UI:insert(distanceBarText)

            local coinsBar = display.newImageRect(_UI, "Assets/game/COINS-BAR.png", 340* data.getRatioX(), 113* data.getRatioX())
            coinsBar.x = relayout._CX + display.contentWidth * 0.31
            coinsBar.y = display.contentCenterY - display.contentHeight * 0.438

            coinsText = display.newText('0', coinsBar.x + 20 * data.getRatioX(), coinsBar.y, "Assets/font/DALEK__.ttf", 50* data.getRatioX())
            _UI:insert(coinsText)

            buttonFire = display.newImageRect(_UI, "Assets/game/SHOOT-BTN.png", 190* data.getRatioX(), 184* data.getRatioX())
            buttonFire.x = relayout._CX + display.contentWidth * 0.36
            buttonFire.y = display.contentCenterY + display.contentHeight * 0.4

            if (data.getCurrentShipIndex() ~= 0) then
                buttonFire.fill = { type = "image", filename = "Assets/game/SHOOT-BTN_active.png" }
                --buttonFire:addEventListener("tap", fire)
                fireButtonOnCooldown = false
            end

            buttonShield = display.newImageRect(_UI, "Assets/game/shield.png", 175* data.getRatioX(), 185* data.getRatioX())
            buttonShield.x = relayout._CX - display.contentWidth * 0.36
            buttonShield.y = display.contentCenterY + display.contentHeight * 0.4

            buttonShieldTimer = display.newText('2s', buttonShield.x, buttonShield.y, "Assets/font/DALEK__.ttf", 60* data.getRatioX())
            _UI:insert(buttonShieldTimer)
            buttonShieldTimer:setTextColor(35/255, 18/255, 4/255, 0)

            -- timer
            timer = display.newImageRect(_UI, "Assets/game/shield_timer.png", 198* data.getRatioX(), 222* data.getRatioX())
            

            health_0 = display.newImageRect(_UI, "Assets/game/LIVE.png", 61* data.getRatioX(), 27* data.getRatioX())
            health_0.x = relayout._CX - display.contentWidth * 0.06
            health_0.y = display.contentCenterY + display.contentHeight * 0.44

            health_1 = display.newImageRect(_UI, "Assets/game/LIVE.png", 61* data.getRatioX(), 27* data.getRatioX())
            health_1.x = relayout._CX
            health_1.y = display.contentCenterY + display.contentHeight * 0.44

            health_2 = display.newImageRect(_UI, "Assets/game/LIVE.png", 61* data.getRatioX(), 27* data.getRatioX())
            health_2.x = relayout._CX + display.contentWidth * 0.06
            health_2.y = display.contentCenterY + display.contentHeight * 0.44

            scene.view:insert(_pauseLayer)
            scene.view:insert(_grpMain)
            scene.view:insert(_UI)

            ------------------------------- INIT VALUES -----------------------------------
            isPaused = false
            isTouching = false
            enemyIsActive = false
            fireball_enemy_is_active = false

            ----------------------------------- RUNTIME -----------------------------------
            Runtime:addEventListener("enterFrame", moveRect)
            Runtime:addEventListener( "touch", touchListener) 
            
            ------------------------------------ EVENTS -----------------------------------------
            buttonPause:addEventListener("tap", pause)
            buttonImproving:addEventListener("tap", gotoImproving)
            buttonQuit:addEventListener("tap", gotoMenu)
            
            _pauseLayer:toBack()
            _UI:toFront()
        end

        function scene:show( event )
            if (event.phase == "will") then
                initLevelScene()
                enemyIsActive = false
                buttonShield:addEventListener("tap", activateShield)
                buttonSound:addEventListener("tap", soundToggle)
                buttonMusic:addEventListener("tap", musicToggle)
                timer:addEventListener("tap", takeTimer)
                Runtime:addEventListener("accelerometer", onAccelerometer)

                isPaused = false
            elseif (event.phase == "did") then
            end
        end

        function scene:hide( event )
            if (event.phase == "will") then
                buttonFire:removeEventListener("tap", fire)
                buttonShield:removeEventListener("tap", activateShield)
                barrels[1]:removeEventListener("tap", hitBarrel)
                barrels[2]:removeEventListener("tap", hitBarrel)
                barrels[3]:removeEventListener("tap", hitBarrel)
                barrels[4]:removeEventListener("tap", hitBarrel)
                buttonSound:removeEventListener("tap", soundToggle)
                buttonMusic:removeEventListener("tap", musicToggle)
                timer:removeEventListener("tap", takeTimer)
                Runtime:removeEventListener("accelerometer", onAccelerometer)
                for i = 1, #bullets do
                    
                    display.remove(bullets[i])
                    bullets[i] = nil
                end

            elseif (event.phase == "did") then
            end
        end

        function scene:destroy( event )
            if (event.phase == "will") then
            elseif (event.phase == "did") then
            end
        end

        -- scene event listeners
        scene:addEventListener("create", scene)
        scene:addEventListener("show", scene)
        scene:addEventListener("hide", scene)
        scene:addEventListener("destroy", scene)

        return scene