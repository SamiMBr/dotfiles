CYAN='%F{#64ffff}'
LIGHT_RED='%F{#ff6464}'
MINT_GREEN='%F{#98ff98}'
RESET='%f'

BOLD='%B'
NO_BOLD='%b'

#CYAN='%F{#8ec07c}'        # gruvbox aqua (soft cyan-green)
#LIGHT_RED='%F{#fb4934}'   # gruvbox bright red
#MINT_GREEN='%F{#b8bb26}'  # gruvbox bright green

autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats ' (%b)'
setopt PROMPT_SUBST

PROMPT='${MINT_GREEN}%n@%m ${RESET}${CYAN}%~${RESET}${LIGHT_RED}${vcs_info_msg_0_}${RESET} \$ '
