import time
from turtle import Screen
from player import Player
from car_manager import CarManager
from scoreboard import Scoreboard

screen = Screen()
screen.setup(width=600, height=600)
screen.tracer(0)
player = Player()
car_manager = CarManager()


screen.listen()
screen.onkey(player.move, "Up")

timer = 0.5
game_is_on = True

scoreboard = Scoreboard()

while game_is_on:
    time.sleep(timer)
    screen.update()
    car_manager.create_cars()
    car_manager.move_cars()
    if player.ycor() > 280:
        player.goto(0, -280)
        scoreboard.increment_level()
        timer *= 0.5

    for _ in car_manager.all_cars:
        if player.distance(x=_, y=_) < 20:
            game_is_on = False
            player.game_over()
screen.exitonclick()
