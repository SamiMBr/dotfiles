" user defined commands

"" define command to reload vimrc
:command Reload source ~/.vim/vimrc

"" fzf open configuraiton files
:command Conf Files ~/.vim/vimrc.d

"" always open help in new tab
:cabbrev help tab help
:cabbrev h tab help

"" command to remove trailing spaces, and empty lines
:command -range TrimTrail <line1>,<line2> s/\s\+$//
:command -range TrimEmpty <line1>,<line2> g/^$/d
