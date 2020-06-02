-- Le futur musicManager
local musicManager = {}

musicManager.listMusics = {} -- Liste des musiques du mixer
musicManager.currentMusic = "" -- Label de la musique en cours

-- Méthode pour ajouter une musique à la liste
function musicManager.addMusic(_label, _pMusic)
  local newMusic = {}
  newMusic.source = _pMusic
  -- S'assure de faire boucler la musique
  newMusic.source:setLooping(true)
  -- Coupe le volume par défaut
  newMusic.source:setVolume(0)
  musicManager.listMusics[_label] = newMusic
end

-- Méthode pour ajouter une liste de musiques à la liste
function musicManager.addAllMusics(listMusics)
  for index, value in pairs(listMusics) do
    musicManager.addMusic(index, value)
  end
end

-- Méthode pour mettre à jour le mixer (à appeler dans update)
function musicManager.update()
  -- Parcours toutes les musiques pour s'assurer
  -- 1) que la musique en cours à son volume à 1, sinon on l'augmente
  -- 2) que si une ancienne musique n'a pas son volume à 0, on le baisse
  for index, music in pairs(musicManager.listMusics) do
    if index == musicManager.currentMusic then
      if music.source:getVolume() < 1 then
        music.source:setVolume(music.source:getVolume()+0.01)
      end
    else
      if music.source:getVolume() > 0 then
        music.source:setVolume(music.source:getVolume()-0.01)
      end
    end
  end
end

-- Méthode pour démarrer une musique de la liste (par son ID)
function musicManager.playMusic(label)
  -- Vérifie que la musique existe
  if musicManager.listMusics[label] == nil then
    print("The music with label "..label.." doesn't exist")
    return
  end
  -- Récupère la musique dans la liste et la démarre
  local music = musicManager.listMusics[label]
  
  if music.source:getVolume() == 0 and musicManager.currentMusic ~= label then
    print("Start music with label "..label)
    music.source:play()
  end
  -- Prend note de la nouvelle musique
  -- Pour que la méthod update prenne le relai
  musicManager.currentMusic = label
end
  
return musicManager