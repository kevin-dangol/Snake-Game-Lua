local love = require"love"

function SFX()

    local effects = {

        bgs = love.audio.newSource("sounds/Background.ogg", "static"),
        eat = love.audio.newSource("sounds/Eating.ogg", "static"),
        death = love.audio.newSource("sounds/Death.ogg", "static")

    }

    return{

        fx_played = false,
        effects.bgs:setLooping(true),
        effects.bgs:setVolume(0.1),
        effects.eat:setVolume(0.2),
        effects.death:setVolume(0.2),
        effects.bgs:play(),

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