function fish_prompt
  # Cache exit status

  # Just calculate these once, to save a few cycles when displaying the prompt
  if not set -q __fish_prompt_hostname
    set -g __fish_prompt_hostname (hostname|cut -d . -f 1)
  end
  if not set -q __fish_user
    switch (id -u)
      case 0
	     set -g __fish_user '#'
      case '*'
	     set -g __fish_user '&'
    end
  end
  set -g __fish_prompt_char '~'

  # Setup colors
  set -l normal (set_color normal)
  set -l white (set_color FFFFFF)
  set -l turquoise (set_color 5fdfff)
  set -l orange (set_color df5f00)
  set -l hotpink (set_color df005f)
  set -l blue (set_color 53D1ED)
  set -l green (set_color 87ff00)
  set -l greeno (set_color -o 87ff00)
  set -l purple (set_color af5fff)
  set -l red (set_color FF0000)
  set -l redo (set_color -o FF0000)
  set -l yellow (set_color E0D757)
 
  # Configure __fish_git_prompt
  set -g __fish_git_prompt_char_stateseparator ' '
  set -g __fish_git_prompt_color 5fdfff
  set -g __fish_git_prompt_color_flags df5f00
  set -g __fish_git_prompt_color_prefix white
  set -g __fish_git_prompt_color_suffix white
  set -g __fish_git_prompt_showdirtystate true
  set -g __fish_git_prompt_showuntrackedfiles true
  set -g __fish_git_prompt_showstashstate true
  set -g __fish_git_prompt_show_informative_status true 
 
  # Env
  set -l last_status $status
  set -l __work_dir (string replace $HOME '~' (pwd))
  
  # Last status
  set -l __exit_code -1
  set -l __prompt 'y'
  if test $last_status -eq 0
    set __prompt $greeno$__fish_prompt_char$greeno' ' 
    set __exit_code $white'0'
  else
   set __prompt $redo'x '
   set __exit_code $redo$last_status
  end 
  # Time
  set -l __time $white'['(date +%H:%M:%S)']'


  # Line
  echo -sne '\n'$purple$__fish_user' '$blue$USER$white \
    ' @ '$green$__fish_prompt_hostname$white \
    ' in '$yellow$__work_dir$turquoise \
    (__fish_git_prompt) \
    ' '$__exit_code \
    ' '$__time \
    '\n' \
    $__prompt;

  
end


