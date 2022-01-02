function fish_prompt
    # Define colors inline with Badwolf vim theme
    set -l N1 (set_color -b aeee00)(set_color 141413)
    set -l N2 (set_color -b 45413b)(set_color aeee00)
    set -l N3 (set_color -b 45413b)(set_color f4cf86)
    set -l N4 (set_color -b black)(set_color 45413b)
    set -l N5 (set_color -b ffa724)(set_color 141413)
    set -l N6 (set_color -b aeee00)(set_color ffa724)    

    # User and hostname segment
    set -l host (echo $hostname | sed 's/\..*$//')
    echo -nes $N5 " " $USER "@" $host " " $N6 \uE0B0

    # Current directory segment
    echo -nes $N1 " " (prompt_pwd) " " $N2 \uE0B0

    # Git segment
    if not not set -l git_dir (command git rev-parse --git-dir 2>/dev/null)
        # Get either the branch name or a branch descriptor.
        set -l branch_detached 0
        if not set -l branch (command git symbolic-ref --short HEAD 2>/dev/null)
            set branch_detached 1
            set branch (command git describe --contains --all HEAD 2>/dev/null)
        end
      
        # Get the commit difference counts between local and remote.
        command git rev-list --count --left-right 'HEAD...@{upstream}' 2>/dev/null \
            | read -d \t -l status_ahead status_behind
        if test $status -ne 0
            set status_ahead 0
            set status_behind 0
        end
 
        # Get the stash status.
        set -l status_stashed 0
        if test -f "$git_dir/refs/stash"
            set status_stashed 1
        else if test -r "$git_dir/commondir"
            read -l commondir <"$git_dir/commondir"
            if test -f "$commondir/refs/stash"
                set status_stashed 1
            end
        end
 
        # Get the porcelain status.
        set -l porcelain_status (command git status --porcelain | string sub -l2)
        set -l status_added 0
        if string match -qr '[ACDMT][ MT]|[ACMT]D' $porcelain_status
            set status_added 1
        end
        set -l status_deleted 0
        if string match -qr '[ ACMRT]D' $porcelain_status
            set status_deleted 1
        end
        set -l status_modified 0
        if string match -qr '[MT]$' $porcelain_status
            set status_modified 1
        end
        set -l status_renamed 0
        if string match -qe R $porcelain_status
            set status_renamed 1
        end
        set -l status_unmerged 0
        if string match -qr 'AA|DD|U' $porcelain_status
            set status_unmerged 1
        end
        set -l status_untracked 0
        if string match -qe '\?\?' $porcelain_status
            set status_untracked 1
        end

        echo -nes $N3
        if test $branch_detached -ne 0
            set_color red
        end
        echo -nes " "\uE0A0" " $branch " "
        if test $status_ahead -ne 0
            echo -n '⬆ '
        end
        if test $status_behind -ne 0
            echo -n '⬇ '
        end
        if test $status_stashed -ne 0
            echo -n '✭ '
        end
        if test $status_added -ne 0
            echo -n '✚ '
        end
        if test $status_deleted -ne 0
            echo -n '✖ '
        end
        if test $status_modified -ne 0
            echo -n '✱ '
        end
        if test $status_renamed -ne 0
            echo -n '➜ '
        end
        if test $status_unmerged -ne 0
            echo -n '═ '
        end
        if test $status_untracked -ne 0
            echo -n '◼ '
        end
    end
    echo -nes $N4 \uE0B0

    echo -nes (set_color normal) " "
end
