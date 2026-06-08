function borg-list --wraps='sudo BORG_PASSCOMMAND="cat /etc/borg-backup.pass" borg list /mnt/backup/Server' --description 'alias borg-list=sudo BORG_PASSCOMMAND="cat /etc/borg-backup.pass" borg list /mnt/backup/Server'
    sudo BORG_PASSCOMMAND="cat /etc/borg-backup.pass" borg list /mnt/backup/Server $argv
end
