# Defined in - @ line 1
function upgrade --wraps='sudo apt upgrade' --description 'alias upgrade sudo apt upgrade'
  sudo apt upgrade $argv;
end
