listFonts={
  ['barcade'] = {},
  ['minecraft'] = {},
  ['arial'] = {},
  ['orbitron'] = {},
  ['hack'] = {}
}

listFonts['barcade'].normal = love.graphics.newFont("assets/fonts/barcade.ttf", 50)
listFonts['minecraft'].small = love.graphics.newFont("assets/fonts/Minecrafter.Reg.ttf", 14)
listFonts['minecraft'].normal = love.graphics.newFont("assets/fonts/Minecrafter.Reg.ttf", 20)
listFonts['minecraft'].big = love.graphics.newFont("assets/fonts/Minecrafter.Reg.ttf", 28)
listFonts['minecraft'].bigger = love.graphics.newFont("assets/fonts/Minecrafter.Reg.ttf", 48)
listFonts['minecraft'].biggest = love.graphics.newFont("assets/fonts/Minecrafter.Reg.ttf", 64)
listFonts['minecraft'].huge = love.graphics.newFont("assets/fonts/Minecrafter.Reg.ttf", 78)
listFonts['arial'].normal = love.graphics.newFont("assets/fonts/arial.ttf",12)
listFonts['orbitron'].normal = love.graphics.newFont("assets/fonts/orbitron.ttf",15)
listFonts['orbitron'].idle = love.graphics.newFont("assets/fonts/orbitron.ttf",20) 
listFonts['orbitron'].medium = love.graphics.newFont("assets/fonts/orbitron.ttf",24)
listFonts['orbitron'].large = love.graphics.newFont("assets/fonts/orbitron.ttf",40)
listFonts['orbitron'].scoreFont = love.graphics.newFont("assets/fonts/orbitron.ttf",32)
listFonts['orbitron'].huge = love.graphics.newFont("assets/fonts/orbitron.ttf",60)
listFonts['hack'].italic = love.graphics.newFont("assets/fonts/Hack-BoldItalic.ttf",10)

listImages={
  -- Background
  ['BG'] = {},
  -- Limites
  ['limite'] = {},
  -- GUI
  ['vie'] = {},
  -- Vaisseau
  ['pion']={},
  -- Menu images
  ['menu'] = {},
  -- Button images
  ['button'] = {},
  -- Item images
  ['item'] = {}
}

listImages['pion']['rouge'] = love.graphics.newImage("assets/images/Sprites/rouge.png")
listImages['pion']['blanc'] = love.graphics.newImage("assets/images/Sprites/blanc.png")

listImages['BG']['intro'] = love.graphics.newImage("assets/images/BG/bg.png")
listImages['BG']['game'] = love.graphics.newImage("assets/images/BG/reversi.png")
listImages['BG']['small'] = love.graphics.newImage("assets/images/BG/small.png")
-- le background peut être modifié
BACKGROUND_IMAGE = listImages['BG']['intro']

listImages['menu'].rules = love.graphics.newImage("assets/images/Menu/Rules.png")

listImages['button'].normal = love.graphics.newImage("assets/images/Boutons/Button.png")
listImages['button'].small = love.graphics.newImage("assets/images/Boutons/Button_small.png")
listImages['button'].selected = love.graphics.newImage("assets/images/Boutons/ButtonSelect.png")
listImages['button'].smallSelected = love.graphics.newImage("assets/images/Boutons/ButtonSelect_small.png")
listImages['button'].leftSelect = love.graphics.newImage("assets/images/Boutons/LeftSelect.png")
listImages['button'].rightSelect = love.graphics.newImage("assets/images/Boutons/RightSelect.png")

listMusics = {
    ['game'] = love.audio.newSource('assets/sounds/music.mp3','stream'),
}

musicManager.addAllMusics(listMusics)