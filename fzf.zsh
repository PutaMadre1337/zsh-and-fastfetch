export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'bat -n --color=always {}'
  --multi --bind 'ctrl-o:execute(nvim {+})'
  --multi --bind 'ctrl-s:execute(sudoedit {+})'
  --multi --bind 'ctrl-r:become(rm -rf {+})'
  --multi --bind 'ctrl-x:become(chmod +x {+})'"

export FZF_CTRL_R_OPTS="
  --bind 'ctrl-y:execute-silent(echo -n {2..} | wl-copy)'
  # --header 'CTRL-Y to copy command into clipboard'
  --color header:italic"

export FZF_ALT_C_OPTS="
  --walker-skip .git,node_modules,target
  --multi --bind 'ctrl-d:become(rm -rf {+})'
  --multi --bind 'ctrl-o:execute(nvim {+})'
  --preview 'eza --icons=auto --tree {}'"

export FZF_COMPLETION_TRIGGER='~~'
export FZF_COMPLETION_OPTS='--border --info=rounded'
export FZF_COMPLETION_PATH_OPTS='--walker file,dir,follow,hidden'
export FZF_COMPLETION_DIR_OPTS='--walker dir,follow'

_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --icons=auto --tree {} | head -200'   "$@" ;;
    nvim|n)       fzf --preview "'eza --icons=auto --tree {}' --walker dir,follow" "$@" ;;
    export|unset) fzf --preview "eval 'echo \$'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview 'bat -n --color=always {}' "$@" ;;
  esac
}
