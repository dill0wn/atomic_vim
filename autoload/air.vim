function! air#setup(dir, proj)
  let repo = a:dir
  let default_project = a:proj

  " echom "SET TO: ".repo.", ".default_project

  let swd = repo.default_project

  let further_args = ' -load-config='.swd.'/src/'.default_project.'-config.xml'
  let further_args+= ' -output='.swd.'/bin-debug/'.default_project.'.swf'
  let g:syntastic_actionscript_mxmlc_post_args = further_args

  let g:syntastic_actionscript_mxmlc_fname = ' -- '.swd.'/src/'.default_project.'.as'

  let exec_patjuh = "java -jar /Applications/Adobe\ Flash\ Builder\ 4.7/eclipse/plugins/com.adobe.flash.compiler_4.7.0.349722/AIRSDK/lib/mxmlc-cli.jar +flexlib=/Applications/Adobe\ Flash\ Builder\ 4.7/eclipse/plugins/com.adobe.flash.compiler_4.7.0.349722/AIRSDK/frameworks  +configname=air -load-config=/Users/dillon/GitHub/PuzzleTD/ppptd_ios/src/ppptd_ios-config.xml -output=/Users/dillon/Desktop/ppptd_ios.swf -- /Users/dillon/GitHub/PuzzleTD/ppptd_ios/src/ppptd_ios.as" 
endfunction
