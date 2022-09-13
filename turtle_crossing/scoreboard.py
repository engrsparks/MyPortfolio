from turtle import Turtle
FONT = ("Courier", 24, "normal")


class Scoreboard(Turtle):
    def __init__(self):
        super().__init__()
        self.penup()
        self.hideturtle()
        self.score = 1
        self.color("black")
        self.goto(-250, 270)
        self.write(f"Level: {self.score}", align="center", font=("Verdana", 15, "normal"))
        self.update_scoreboard()

    def update_scoreboard(self):
        self.write(f"Level: {self.score}", align="center", font=("Verdana", 15, "normal"))

    def increment_level(self):
        self.score += 1
        self.clear()
        self.update_scoreboard()
