EndMenu = Class{}

function EndMenu:init()  -- The constructor
  
	-- print("Module / création d'une instance de EndMenu")
  self.x = 250
  self.y = 180
  self.image = listImages['BG']['small']
  
  self.title = {}
  self.title.text = "GAME OVER"
  self.title.x = 310
  self.title.y = 220

  self.endMenus = {}
  self.nbEndMenu = 2
  self.endMenus[0] = self:initButton("REJOUER", 325, 260, 360, 280)
  self.endMenus[1] = self:initButton("RETOUR MENU", 325, 320, 345, 340)
  
  self.endMenuSelected = 0
  
  self.affichageMessage = false
  self.tempsAffichageMessage = 1
  
end

function EndMenu:initButton(_text, _x, _y, _labelX, _labelY)
  local button = {}
  button.x = _x
  button.y = _y
  button.label = {}
  button.label.x = _labelX
  button.label.y = _labelY
  button.label.text = _text
  return button
end

function EndMenu:selectEndMenu(number)
  self.endMenuSelected = number
end

function EndMenu:drawButtons()
  local i
  for i = 0, self.nbEndMenu - 1 do
    if i == self.endMenuSelected and self.affichageMessage then
      love.graphics.draw(listImages['button'].smallSelected, self.endMenus[i].x, self.endMenus[i].y)
      --love.graphics.setColor(112, 112, 33) -- on met la couleur jaune si sélectionnée
      love.graphics.setColor(196, 196, 0) -- on met la couleur jaune si sélectionnée
    else
      love.graphics.draw(listImages['button'].small, self.endMenus[i].x, self.endMenus[i].y)
      love.graphics.setColor(1, 1, 1) -- on met la couleur blanche
    end
    love.graphics.setFont(listFonts['minecraft'].small)
    love.graphics.print(self.endMenus[i].label.text, self.endMenus[i].label.x, self.endMenus[i].label.y)
    love.graphics.reset()
  end
end

function EndMenu:drawEndMenu()
    -- dessiner le background
  love.graphics.draw(self.image, self.x, self.y)
  love.graphics.setFont(listFonts['minecraft'].big)
  love.graphics.print(self.title.text, self.title.x, self.title.y)
  
  self:drawButtons()
end