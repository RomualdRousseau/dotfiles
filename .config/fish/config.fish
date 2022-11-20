if status is-interactive
    # Commands to run in interactive sessions can go here
    pyenv init - | source
    pyenv virtualenv-init - | source
end
