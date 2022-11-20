function update --wraps='pacman -Syyu --color auto' --wraps='sudo pacman -Syyu --color auto' --wraps='sudo pacman -Syu --color auto' --description 'alias update sudo pacman -Syu --color auto'
  sudo pacman -Syu --color auto $argv; 
end
