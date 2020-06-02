Class=require 'lib/hump/class'
Gamestate = require 'lib/hump/gamestate'
require 'src/parameters/constants'
musicManager = require 'src/parameters/musicManager'
flux = require 'lib/flux'

--require pour les objets globaux
require 'src/parameters/resources'
require 'src/parameters/util'

--require pour les objets
require 'src/objects/EndMenu'
require 'src/objects/Grille'
require 'src/objects/Jeu'
require 'src/objects/Pion'

--require pour les differents Etats
--require 'src/state/IntroState'
require 'src/state/JeuState'
require 'src/state/MainMenuState'
require 'src/state/RuleState'