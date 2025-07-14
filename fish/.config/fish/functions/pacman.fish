function pacman --wraps='sudo pacman --color=auto' --description 'alias pacman sudo pacman --color=auto'
  sudo pacman --color=auto $argv; 
end
