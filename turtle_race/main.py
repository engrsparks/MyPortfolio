from turtle import Turtle, Screen
import random

screen = Screen()
screen.setup(height=720, width=1080)
user_bet = screen.textinput(title="Make your bet", prompt="Which turtle will win the race? Enter a color: ")
colors = ["red", "green", "yellow", "blue", "orange"]
random.shuffle(colors)
list_of_turtles = []

y_turtle = [60, 30, 0, -30, -60]

is_race_on = False


for _ in range(0, 5):
    tim = Turtle("turtle", 30)
    tim.penup()
    tim.color(colors[_])
    tim.goto(x=-520, y=y_turtle[_])
    list_of_turtles.append(tim)

if user_bet:
    is_race_on = True

while is_race_on:
    for turtles in list_of_turtles:
        random_distance = random.randint(0, 10)
        turtles.forward(random_distance)
        if turtles.xcor() > 505:
            is_race_on = False
            winning_color = turtles.pencolor()
            if winning_color == user_bet:
                turtles.goto(0, 0)
                turtles.write(f"You've won! The {winning_color} turtle is the winner!", align="center",
                              font=("Verdana", 15, "normal"))
                # screen.textinput(title="Game Over", prompt=f"You've won! The {winning_color} turtle is the winner!")
            else:
                turtles.goto(0, 0)
                turtles.write(f"You've lose! The {winning_color} turtle is the winner!", align="center",
                              font=("Verdana", 15, "normal"))


screen.exitonclick()
