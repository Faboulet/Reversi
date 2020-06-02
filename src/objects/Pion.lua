Pion = Class{}

function Pion:init(_x, _y, _indice, _size)  -- The constructor

	--print("Module / création d'une instance de Pion")
  self.x = _x
  self.y = _y
  self.indice = _indice
  self.size = _size
end

function Pion:initParameters(_x, _y, _indice, _size)
  self.x = _x
  self.y = _y
  self.indice = _indice
  self.size = _size
end