JeuState = {}

function JeuState:init()
  
  self.title = {}
  self.title.text = "REVERSI"
  self.title.x = -250
  self.title.y = 15
  self.title.font = listFonts['minecraft'].bigger
  
  self.grille = Grille()
  self.player1 = {}
  self.player2 = {}
  
  self.decalage = 100
  self.endMenu = EndMenu()
  self:initTitle()
end

function JeuState:initTitle()
  flux.to(self.title, 3, { x = 280 })
      :ease("backout")
end

function JeuState:enter(_, _isHuman)
  BACKGROUND_IMAGE = listImages['BG']['game']
  self.isHuman = _isHuman or false  
  self:initDraw()
  
end

function JeuState:initPlayers()
  self.player1 = {}
  self.player1.score = 0
  self.player1.nbPossibilites = 1
  
  self.player2 = {}
  self.player2.score = 0
  self.player2.nbPossibilites = 1
end

function JeuState:initDraw()
  self.gameover = false
  self.ready = true
  self.firstPlayer = true
  
  self.alpha = 0
  self.tempsReflexion = 1
  
  self:initPlayers()
  self.grille:initCases()
  self.grille:placerPionsDepart()
  self.grille:analyserPossibilites(1)
end

function JeuState:update(dt)
  local l,c
  local isReady = true
  if next(flux.tweens) ~= nil then
    flux.update(dt)
  elseif self.gameover == false then
    
    if self.firstPlayer == false and self.isHuman == false and self.ready == true then
      self.tempsReflexion = self.tempsReflexion - dt
    end
    self.alpha = self.alpha + dt * 0.5
    if self.alpha >= 1 then self.alpha = 0 end
    self.player1.score = 0
    self.player2.score = 0
    local nbPossibilites = 0
    
    for l = 0, self.grille.GRILLE_L - 1 do
      for c = 0, self.grille.GRILLE_H - 1 do
        if next(self.grille.cases[l][c]) ~= nil then
          if self.grille.cases[l][c].size < 1 then
            self.grille.cases[l][c].size = self.grille.cases[l][c].size + dt
            isReady = false
          elseif self.grille.cases[l][c].size > 1 then
            self.grille.cases[l][c].size = 1
          end
          if self.grille.cases[l][c].indice == 1 then
            self.player1.score = self.player1.score + 1
          elseif self.grille.cases[l][c].indice == 2 then
            self.player2.score = self.player2.score + 1
          end
        end
        if self.grille.move[l][c] then
          nbPossibilites = nbPossibilites + 1
        end
      end
    end
    self.ready = isReady
    if self.firstPlayer == true then
      self.player1.nbPossibilites = nbPossibilites
    else
      self.player2.nbPossibilites = nbPossibilites
      if self.isHuman == false and self.player2.nbPossibilites ~= 0 and self.tempsReflexion <= 0 and self.ready == true then
        local position = math.random(1,self.player2.nbPossibilites)
        local nbPos = 0
        for l = 0, self.grille.GRILLE_L - 1 do
          for c = 0, self.grille.GRILLE_H - 1 do
            if self.grille.move[l][c] then
              nbPos = nbPos + 1
              if nbPos == position then
                self.grille:placerPionIA(l,c)
                self.tempsReflexion = 1
                self.firstPlayer = true
                self.grille:analyserPossibilites(1)
              end
            end
          end
        end
      end
    end
    if self.player1.nbPossibilites == 0 and self.player2.nbPossibilites == 0 then
      self.gameover = true
    elseif self.firstPlayer == true and self.player1.nbPossibilites == 0 then
      self.firstPlayer = false
      self.grille:analyserPossibilites(2)
    elseif self.firstPlayer == false and self.player2.nbPossibilites == 0 then
      self.firstPlayer = true
      self.grille:analyserPossibilites(1)
    end
  elseif self.gameover == true then
    if self.ready == true then
      self.endMenu.tempsAffichageMessage = self.endMenu.tempsAffichageMessage - dt
      if self.endMenu.tempsAffichageMessage <= 0 then
        self.endMenu.affichageMessage = not self.endMenu.affichageMessage
        self.endMenu.tempsAffichageMessage = 1
      end
    else
      for l = 0, self.grille.GRILLE_L - 1 do
        for c = 0, self.grille.GRILLE_H - 1 do
          if next(self.grille.cases[l][c]) ~= nil then
            if self.grille.cases[l][c].size < 1 then
              self.grille.cases[l][c].size = self.grille.cases[l][c].size + dt
              isReady = false
            elseif self.grille.cases[l][c].size > 1 then
              self.grille.cases[l][c].size = 1
            end
          end
        end
      end
      self.ready = isReady
    end
  end
end 


function JeuState:draw()
  
  -- dessiner le background
  love.graphics.draw(BACKGROUND_IMAGE, self.x, self.y)
  
  love.graphics.setFont(self.title.font)
  love.graphics.print(self.title.text, self.title.x, self.title.y)
  love.graphics.reset()
  
  local l,c
  for l = 0, self.grille.GRILLE_L - 1 do
    for c = 0, self.grille.GRILLE_H - 1 do
      --[[if grilleBombes[l][c] == 1 then
        love.graphics.setColor(1,0,0)
      else
        love.graphics.setColor(1,1,1)
      end]]        
      love.graphics.rectangle('fill', l * self.grille.TAILLE_CASE + self.decalage, c * self.grille.TAILLE_CASE + self.decalage, self.grille.TAILLE_CASE - 1, self.grille.TAILLE_CASE - 1)
      if next(self.grille.cases[l][c]) ~= nil then
        local pion = self.grille.cases[l][c]
        if pion.indice == 1 then
          love.graphics.draw(listImages['pion']['rouge'],
            pion.x * self.grille.TAILLE_CASE + self.decalage + (1-pion.size) * 25,
            pion.y * self.grille.TAILLE_CASE + self.decalage + (1-pion.size) * 25,
            0,
            pion.size,
            pion.size)
        else
          love.graphics.draw(listImages['pion']['blanc'],
            pion.x * self.grille.TAILLE_CASE + self.decalage + (1-pion.size) * 25,
            pion.y * self.grille.TAILLE_CASE + self.decalage + (1-pion.size) * 25,
            0,
            pion.size,
            pion.size)
        end
        love.graphics.reset()
      elseif self.grille.move[l][c] then
          love.graphics.setColor(0,0,0, self.alpha)
          love.graphics.rectangle('fill', l * self.grille.TAILLE_CASE + self.decalage, c * self.grille.TAILLE_CASE + self.decalage, self.grille.TAILLE_CASE - 1, self.grille.TAILLE_CASE - 1)
          love.graphics.reset()
      end
    end
  end
  
  self:afficherScore1()
  self:afficherScore2()
  
  if self.gameover == false then
    self:afficherTour()
    if self.player1.nbPossibilites == 0 then
      self:afficherCantPlay1()
    end
    if self.player2.nbPossibilites == 0 then
      self:afficherCantPlay2()
    end
  else
    love.graphics.setColor(0,1,0)
    love.graphics.setFont(listFonts['orbitron'].normal)
    love.graphics.print("GAMEOVER", love.graphics.getWidth() - 200, 200)
    if self.player1.score > self.player2.score then
      love.graphics.setColor(1,0,0)
      love.graphics.print("Gagnant player 1", love.graphics.getWidth() - 225, 250)
    elseif self.player1.score < self.player2.score then
      love.graphics.setColor(1,1,1)
      love.graphics.print("Gagnant player 2", love.graphics.getWidth() - 225, 250)
    else
      love.graphics.setColor(0,1,0)
      love.graphics.print("EX-AEQUO", love.graphics.getWidth() - 205, 250)
    end
    love.graphics.reset()
    self.endMenu:drawEndMenu()
  end
  
end

function JeuState:afficherTour()
  love.graphics.setFont(listFonts['orbitron'].normal)
  if self.firstPlayer then
    love.graphics.setColor(1,0,0)
    love.graphics.print("Au tour du joueur 1", love.graphics.getWidth() - 230, 140)
  else
    if self.isHuman == true then
      love.graphics.setColor(1,1,1)
      love.graphics.print("Au tour du joueur 2", love.graphics.getWidth() - 230, 140)
    else
      love.graphics.setColor(1,1,1)
      love.graphics.print("Au tour de\nl'ordinateur", love.graphics.getWidth() - 190, 140)
    end
  end
  love.graphics.reset()
end

function JeuState:afficherCantPlay1()
  love.graphics.setColor(1,0,0)
  love.graphics.setFont(listFonts['orbitron'].normal)
  love.graphics.print("Le joueur 1 ne peut\npas jouer", love.graphics.getWidth() - 230, 200)
  love.graphics.reset()
end

function JeuState:afficherCantPlay2()
  love.graphics.setColor(1,1,1)
  love.graphics.setFont(listFonts['orbitron'].normal)
  love.graphics.print("Le joueur 2 ne peut\npas jouer", love.graphics.getWidth() - 230, 200)
  love.graphics.reset()
end

function JeuState:afficherScore1()
  love.graphics.setColor(1,0,0)
  love.graphics.setFont(listFonts['orbitron'].normal)
  love.graphics.print("Player 1 :", love.graphics.getWidth() - 230, 410)
  love.graphics.setFont(listFonts['orbitron'].large)
  love.graphics.print(self.player1.score, love.graphics.getWidth() - 130, 400)
  love.graphics.reset()
end

function JeuState:afficherScore2()
  love.graphics.setColor(1,1,1)
  love.graphics.setFont(listFonts['orbitron'].normal)
  love.graphics.print("Player 2 :", love.graphics.getWidth() - 230, 480)
  love.graphics.setFont(listFonts['orbitron'].large)
  love.graphics.print(self.player2.score, love.graphics.getWidth() - 130, 470)
  love.graphics.reset()
end

function JeuState:keypressed(key)
  if self.gameover == true then
    if key == "up" then
      self.endMenu:selectEndMenu((self.endMenu.endMenuSelected - 1) % self.endMenu.nbEndMenu)
    end
    if key == "down" then
      self.endMenu:selectEndMenu((self.endMenu.endMenuSelected + 1) % self.endMenu.nbEndMenu)
    end
    if key == "return" then
      if self.endMenu.endMenuSelected == 1 then
        self.endMenu.endMenuSelected = 0
        Gamestate.switch(MainMenuState)
      else
        self:initDraw()
      end
    end
  end
end

function JeuState:mousepressed(posX, posY, button)
  if self.gameover == false and self.ready == true then
    if self.firstPlayer == true then
      local reussi = self.grille:placerPion(posX - self.decalage, posY - self.decalage, 1)
      if reussi then
        self.firstPlayer = false
        self.grille:analyserPossibilites(2)
      else
        self.grille:analyserPossibilites(1)
      end
    elseif self.isHuman == true then
      local reussi = self.grille:placerPion(posX - self.decalage, posY - self.decalage, 2)
      if reussi then
        self.firstPlayer = true
        self.grille:analyserPossibilites(1)
      else
        self.grille:analyserPossibilites(2)
      end
    end
  end
end