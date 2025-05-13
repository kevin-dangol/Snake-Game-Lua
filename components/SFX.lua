local love = require"love"

function SFX()

    local effects = {

        eat = love.audio.newSource("sounds/Eating.mp3", "static"),
        death = love.audio.newSource("sounds/Death.mp3", "static")

    }

    return{

        fx_played = false,

        setFXPlayed = function(self, has_played)
            self.fx_played = has_played
        end,

        stopFX = function(self, effect)
            if effects[effect]:isPlaying() then
                effects[effect]:stop()
            end
        end,

        playFX = function(self, effect, mode)

            if mode == "single" then

                if not self.fx_played then

                    self:setFXPlayed(true)

                    if not effects[effect]:isPlaying() then
                        effects[effect]:play()
                    end

                end
            elseif mode == "slow" then

                if not effects[effect]:isPlaying() then
                    effects[effect]:play()
                end

            else

                self:stopFX(effect)
                effects[effect]:play()

            end

        end

    }

end

return SFX