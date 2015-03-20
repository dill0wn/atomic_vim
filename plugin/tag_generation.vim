function! RegenTags()
  let exclude_list = join(g:vim_ignore, "|")
  let ext_list = join(g:taggable_extensions, "|")

  if has("win32")
    let ruby_generate_tags = "!ruby '" . $HOME . "/vimfiles/tools/generate_tags.rb'"
  else
    let ruby_generate_tags = "!ruby ~/.vim/tools/generate_tags.rb"
  endif

  if exists("g:tag_options")
    execute ruby_generate_tags . " '" . ext_list . "' '". exclude_list ."' '". g:tag_options ."'"
  else
    execute ruby_generate_tags . " '" . ext_list . "' '". exclude_list ."'"
  endif

  silent execute ":redraw!"
endfunction

command! RegenTags call RegenTags()|FufRenewCache
