if status is-interactive
    set -x PATH ~/.pyenv/bin $PATH

    pyenv init - | source
    pyenv virtualenv-init - | source
end
