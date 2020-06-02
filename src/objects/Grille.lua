Grille = Class{}

function Grille:init()  -- The constructor
  
  --print("Module / création d'une instance vide de Grille")
  self.GRILLE_L = 8
  self.GRILLE_H = 8
  self.TAILLE_CASE = 50
  
  self.cases = {}
  self.couv = {} 
  self.move = {}

end

function Grille:initCases()
  local l
  for l=0, self.GRILLE_L - 1 do
    self.cases[l] = {}
    local c
    for c=0, self.GRILLE_H - 1 do
      self.cases[l][c] = {}
    end
  end
  self:initCouv()
  self:initMove()
end

function Grille:initCouv()
  local l
  for l=0, self.GRILLE_L - 1 do
    self.couv[l] = {}
    local c
    for c=0, self.GRILLE_H - 1 do
      self.couv[l][c] = 0
    end
  end
end

function Grille:initMove()
  local l
  for l=0, self.GRILLE_L - 1 do
    self.move[l] = {}
    local c
    for c=0, self.GRILLE_H - 1 do
      self.move[l][c] = false
    end
  end
end

function Grille:placerPionsDepart()
  local l = 3
  local c = 3
  local pion = Pion(l,c, 1, 0.5)
  self.cases[l][c] = pion
  
  c = 4
  pion = Pion(l,c, 2, 0.5)
  self.cases[l][c] = pion
  
  l=4
  c=3
  pion = Pion(l,c, 2, 0.5)
  self.cases[l][c] = pion
  
  l = 4
  c = 4
  pion = Pion(l,c, 1, 0.5)
  self.cases[l][c] = pion
end

function Grille:flood(pl, x, pc, y, indice, origL, origC, move)
  if pl+x < 0 or pl+x >= self.GRILLE_L or
     pc+y < 0 or pc+y >= self.GRILLE_H or
     next(self.cases[pl+x][pc+y]) == nil then
       return
  end
  if pl+x == origL and pc+y == origC then return end
  --if next(self.couv[pl+x][pc+y]) ~= nil then return end
  pl = pl + x
  pc = pc + y
  local pion = self.cases[pl][pc]
  
  if pion.indice ~= indice then
    self.couv[pl][pc] = self.couv[pl][pc] + 1
    if self.couv[pl][pc] > 1 then
      self.move[origL][origC] = true
      if move then
        if pion.indice == 1 then
          pion.indice = 2
          pion.size = 0
        else
          pion.indice = 1
          pion.size = 0
        end
      end
    end
    self:flood(pl, x, pc, y, indice, origL, origC, move)
  else
    self:flood(pl, -x, pc, -y, indice, origL, origC, move)
  end
end

function Grille:analyserPossibilites(indice)
  local l
  local c
  self:initMove()
  for l=0, self.GRILLE_L - 1 do
    for c=0, self.GRILLE_H - 1 do
      if next(self.cases[l][c]) == nil then
        self:parcourirPions(l,c, indice, false)
      end
    end
  end
end
  
function Grille:parcourirPions(l,c, indice, move)
  self:initCouv()
  self:flood(l,-1, c, -1, indice, l, c, move)
  self:initCouv()
  self:flood(l,-1, c, 0, indice, l, c, move)
  self:initCouv()
  self:flood(l,-1, c, 1, indice, l, c, move)
  self:initCouv()
  self:flood(l, 0, c, -1, indice, l, c, move)
  self:initCouv()
  self:flood(l, 0, c, 1, indice, l, c, move)
  self:initCouv()
  self:flood(l, 1, c, -1, indice, l, c, move)
  self:initCouv()
  self:flood(l, 1, c, 0, indice, l, c, move)
  self:initCouv()
  self:flood(l, 1, c, 1, indice, l, c, move)
end

function Grille:placerPionIA(l, c)
  self:initMove()
  local indice = 2

  if l >= 0 and l < self.GRILLE_L and
     c >= 0 and c < self.GRILLE_H and
     next(self.cases[l][c]) == nil then
       
      self:parcourirPions(l,c, indice, true)
      if self.move[l][c] == true then
        local pion = Pion(l,c, indice, 0.5)
        self.cases[l][c] = pion
      end
  end
end

function Grille:placerPion(posX, posY, indice)
  self:initMove()
  local l = math.floor(posX / self.TAILLE_CASE)
  local c = math.floor(posY / self.TAILLE_CASE)

  if l >= 0 and l < self.GRILLE_L and
     c >= 0 and c < self.GRILLE_H and
     next(self.cases[l][c]) == nil then
       
      self:parcourirPions(l,c, indice, true)
      if self.move[l][c] == true then
        local pion = Pion(l,c, indice, 0.5)
        self.cases[l][c] = pion
        return true
      else return false
      end
  end
  return false
end