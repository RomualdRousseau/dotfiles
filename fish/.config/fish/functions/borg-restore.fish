function borg-restore --wraps='sudo BORG_PASSCOMMAND="cat /etc/borg-backup.pass" borg extract' --description 'alias borg-restore=sudo BORG_PASSCOMMAND="cat /etc/borg-backup.pass" borg extract'
    sudo BORG_PASSCOMMAND="cat /etc/borg-backup.pass" borg extract $argv
end
