import pygame
from pyswip import prolog

pygame.init()

#display resolutions
display_width = 800
display_height = 600

#colors
black = (0,0,0)
white = (255,255,255)

gameDisplay = pygame.display.set_mode((display_width, display_height))
pygame.display.set_caption('The Tale of Amazon')
clock = pygame.time.Clock()

characterImg = pygame.image.load('./resources/images/character.jpg')

def character(x,y):
    gameDisplay.blit(characterImg, (x,y))

x = (display_width * 0.30)
y = (display_height * 0.5)


end = False

#gameloop
while not end:
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            end = True

        #print(event)
    gameDisplay.fill(white)
    character(x,y)
    pygame.display.update()
    clock.tick(60)

#cleaning
pygame.quit()
quit()












