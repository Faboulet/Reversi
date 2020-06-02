-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf('no')

-- Empèche Love de filtrer les contours des images quand elles sont redimentionnées
-- Indispensable pour du pixel art
love.graphics.setDefaultFilter('nearest','nearest')

-- Cette ligne permet de déboguer pas à pas dans ZeroBraneStudio
if arg[#arg] == "-debug" then require("mobdebug").start() end

math.randomseed(love.timer.getTime())

love.window.setTitle(TITLE)
love.window.setMode(ECRAN_LARGEUR, ECRAN_HAUTEUR) -- dimensions de la fenêtre

Gamestate.registerEvents()
Gamestate.switch(MainMenuState)