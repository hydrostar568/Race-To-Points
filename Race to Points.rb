require "gosu"
class Game < Gosu::Window
	def initialize
		@start = false
		@movement = false
		@players = false
		@width = 720
		@height = 560
		@x = 200
		@y = 150
		@x2 = 400
		@y2 = 150
		@xspeed2 = 5
		@yspeed2 = 5
		@eaten = false
		@currentFood1 = 0
		@currentFood2 = 0
		@rand_x = Random.rand(200..500)
		@rand_y = Random.rand(100..250)
		@xspeed = 5
		@yspeed = 5
		@up = false
		@down = false
		@right = false
		@left = false
		super(@width, @height, false)
		self.caption = "Snake Game"
		@block = Gosu::Image.new("/home/alexboland/Pictures/Ruby Pictures/Block.png")
		@block2 = Gosu::Image.new("/home/alexboland/Pictures/Ruby Pictures/Block.png")
		@food = Gosu::Image.new("/home/alexboland/Pictures/Ruby Pictures/Food.png")
		@font = Gosu::Font.new(self, Gosu.default_font_name, 18)
		@font_36 = Gosu::Font.new(self, Gosu.default_font_name, 36)
	end
	def update
		def button_down(id)
			if id == Gosu::KbEscape
				close
			end
		end
		if Gosu::button_down? Gosu::KbW and @movement == true
			@up = true
			@down = false
			@right = false
			@left = false
		elsif Gosu::button_down? Gosu::KbD and @movement == true
			@right = true
			@left = false
			@down = false 
			@up = false
		elsif Gosu::button_down? Gosu::KbA and @movement == true
			@left = true
			@right = false 
			@down = false
			@up = false
		elsif Gosu::button_down? Gosu::KbS and @movement == true
			@down = true
			@up = false
			@right = false
			@left = false
		end
		if Gosu::button_down? Gosu::KbUp and @movement == true
			@up2 = true
			@down2 = false
			@right2 = false
			@left2 = false
		elsif Gosu::button_down? Gosu::KbDown and @movement == true
			@down2 = true
			@up2 = false
			@right2 = false
			@left2 = false
		elsif Gosu::button_down? Gosu::KbRight and @movement == true
			@right2 = true
			@down2 = false
			@up2 = false
			@left2 = false
		elsif Gosu::button_down? Gosu::KbLeft and @movement == true
			@left2 = true
			@down2 = false
			@up2 = false
			@right2 = false
		end
		if @up2 == true and @movement == true
			@y2 -= @yspeed2
		elsif @down2 == true and @movement == true
			@y2 += @yspeed2
		elsif @right2 == true and @movement == true
			@x2 += @xspeed2 
		elsif @left2 == true and @movement == true
			@x2 -= @xspeed2
		end
		if @up == true and @movement == true
			@y -= @yspeed
		elsif @down == true and @movement == true
			@y += @yspeed
		elsif @right == true and @movement == true
			@x += @xspeed
		elsif @left == true and @movement == true
			@x -= @xspeed
		end
		if @x >= @rand_x - 10 and @x <= @rand_x + 10 and @y >= @rand_y - 10 and @y <= @rand_y + 10
			@eaten = true 
			@xspeed += 1
			@yspeed += 1
			@currentFood1 += 1
			@rand_x = Random.rand(100..500)
			@rand_y = Random.rand(50..400)
			@eaten = false
		end
		if @x2 >= @rand_x - 10 and @x2 <= @rand_x + 10 and @y2 >= @rand_y - 10 and @y2 <= @rand_y + 10 and @players == true
			@eaten = true
			@xspeed2 += 1
			@yspeed2 += 1
			@currentFood2 += 1
			@rand_x = Random.rand(100..500)
			@rand_y = Random.rand(50..400)
			@eaten = false
		end
	end
	def draw
		if @movement == false
			@font_36.draw("1) 1 Player", 275, 200, 0)
			@font_36.draw("2) 2 Players", 275, 300, 0)
			if Gosu::button_down? Gosu::Kb1
				@movement = true
				@players = false
				@xspeed = 5
				@yspeed = 5
			elsif Gosu::button_down? Gosu::Kb2
				@movement = true
				@players = true
				@xspeed2 = 5
				@yspeed2 = 5
				@xspeed = 5
				@yspeed = 5
			end
		end
		@food.draw(@rand_x, @rand_y, 0) if @eaten == false and @movement == true
		if @x > @width or @x < -100 or @y > @height or @y < -100 and @movement == true
			@font_36.draw("Player 1's high score is #{@currentFood1}!", 200, 100, 0)
			@xspeed = 0
			@yspeed = 0
		end
		if @x2 > @width or @x2 < -100 or @y2 > @height or @y2 < -100 and @movement == true and @players == true
			@font_36.draw("Player 2's high score is #{@currentFood2}!", 200, 200, 0)
			@xspeed2 = 0
			@yspeed2 = 0
		end
		if Gosu::button_down? Gosu::KbR 
			@x = 200
			@y = 150
			@x2 = 400
			@y2 = 150
			@currentFood1 = 0
			@currentFood2 = 0
			@movement = false
			@players = false
		end
		if @movement == false
			@xspeed = 0
			@xspeed2 = 0
			@yspeed = 0
			@yspeed2 = 0
		end
		@block.draw(@x, @y, 0) if @movement == true
		@block2.draw(@x2, @y2, 0) if @players == true and @movement == true
		@font.draw("X/Y: #{@x}/#{@y}", 16, 16, 0) if @movement == true
		@font.draw("Player 1 Food: #{@currentFood1}", 16, 32, 0) if @movement == true
		@font.draw("Player 2 Food: #{@currentFood2}", 16, 48, 0) if @players == true and @movement == true
		@font.draw("Player 1", @x - 4, @y - 20, 0) if @movement == true
		@font.draw("Player 2", @x2 - 4, @y2 - 20, 0) if @players == true and @movement == true
		@font.draw("Created By Alexandre Boland", @width - 250, 16, 0) if @movement == true
		@font.draw("Version: 1.0", @width - 250, 32, 0) if @movement == true
		if @currentFood == 10
			@font_36.draw("Hooray!", @x - 20, @y - 60, 0)
		end
	end
end
window = Game.new
window.show