function fish_prompt
  # Cache exit status
  set -l last_status $status
  set -l __work_dir (string replace $HOME '~' (pwd))

  # Just calculate these once, to save a few cycles when displaying the prompt
  if not set -q __fish_prompt_hostname
    set -g __fish_prompt_hostname (hostname|cut -d . -f 1)
  end
  if not set -q __fish_prompt_char
    switch (id -u)
      case 0
	set -g __fish_prompt_char '#'
      case '*'
	set -g __fish_prompt_char '~'
    end
  end

  # Setup colors
  set -l normal (set_color normal)
  set -l white (set_color FFFFFF)
  set -l turquoise (set_color 5fdfff)
  set -l orange (set_color df5f00)
  set -l hotpink (set_color df005f)
  set -l blue (set_color 53D1ED)
  set -l green (set_color -o 87ff00)
  set -l purple (set_color af5fff)
  set -l red (set_color -o FF0000)
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
 

  # Line 1
  echo -n $green'╭ '$blue$USER$white' @ '$green$__fish_prompt_hostname$white' in '$yellow$__work_dir$turquoise
  __fish_git_prompt " (%s)"
  echo

  # Line 2
  echo -n $green'╰'
  # support for virtual env name
  if set -q VIRTUAL_ENV
      echo -n "($green"(basename "$VIRTUAL_ENV")"$green)"
  end
  
  if test $last_status -eq 0
    echo -n $green' '$__fish_prompt_char $green
  else
    echo -n $red' 'x $red
  end
end


