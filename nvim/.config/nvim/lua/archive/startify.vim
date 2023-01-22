let g:startify_session_persistence = 1
let g:startify_session_dir='~/.config/nvim/startify_sessions'

let g:startify_custom_header=['']
" let g:startify_custom_header=[
" \'⠨⡈⡂⡂⠌⡂⠅⠂⠡⠐⢀⠂⠄⡑⠀⠀⠀⡀⠠⠀⠠⠀⠄⠂⠀⣂⣨⡠⡬⣤⢬⢤⢤⣠⣠⣀⠐⠀⠠⠀⠠⠀⠠⠀⠄⢀⠀⠄⠂⡁⠄⠂⠐⠈⡐⢀⠂⡐⠠⠠⠁⡂',
" \'⠡⢐⠐⠌⡂⠂⠅⡡⠨⠐⡀⠂⡂⠂⠀⠀⠁⠀⠀⡀⡤⡲⡪⡫⣝⢞⣺⡺⣝⡮⡯⡿⡽⣞⣾⢺⢿⢽⢯⣗⡷⡦⣦⣠⠐⠀⠀⠄⠂⡀⠅⠨⠀⡁⠄⠐⡀⠂⠄⡁⡂⡂',
" \'⠡⠨⠂⡂⠅⠡⢂⠂⠅⠠⠁⠄⠀⠀⠐⢀⢔⢎⢇⣳⣍⣯⣺⣪⣳⡵⣽⢵⢯⣻⡽⣽⣳⣫⡯⡯⣯⣗⢷⣫⣟⡾⣾⣻⢷⣦⡄⠂⠠⠈⠄⠡⠐⠈⠄⠂⡁⠂⠄⢂⢐⠠',
" \'⢌⠌⡌⠰⠐⡈⡊⡀⠂⠄⠅⡁⠀⠀⢐⡰⡵⣕⡿⣝⣧⡳⣧⣳⣵⣳⢽⡽⣝⣯⢾⣽⣗⣷⢯⡯⣯⢷⢽⣻⣺⣗⡿⣷⢿⣽⡾⣟⣿⣤⡁⡊⡐⡈⢀⠂⡁⠄⠅⢅⠂⡂',
" \'⠰⡐⠨⠀⡅⠡⠠⠠⠑⡈⠐⠀⠀⢠⢣⡳⣝⣞⢮⣳⢷⢿⣻⡷⣿⣾⣿⣿⢿⣯⣿⣻⣿⢿⢵⣿⢿⣽⡻⣞⡾⣞⢿⣳⢿⣷⣿⣯⣿⣽⣿⣦⡀⡂⡐⡀⡂⠅⢡⢑⠨⢀',
" \'⠐⠠⠁⡅⠔⠈⡀⢁⠐⠠⠁⢀⢰⢱⢱⡳⣕⢗⡽⣺⢝⡯⡿⣽⣻⣷⣿⣿⣿⣿⣿⣿⣿⣽⣿⣿⣿⣷⣿⣿⣿⣾⣷⣯⣿⣞⣷⣟⣿⡿⣿⣿⣿⡄⡐⡀⡂⠡⢘⠌⡌⡐',
" \'⠅⠅⡂⡂⡁⢁⠐⠠⢈⢐⠅⢢⢱⢕⡕⣗⣕⢯⡺⣕⢯⣫⢯⢯⢷⡿⣷⣿⣿⣽⣿⣾⣷⣿⣿⣷⣿⣿⡿⣿⣾⣿⣻⣿⣻⣿⣟⣿⣽⣿⣿⣻⣿⣿⣆⠂⠢⠡⠐⠥⡑⡀',
" \'⢈⠐⡀⢂⠂⡐⠈⡀⡐⠠⠨⢢⡣⡳⣕⡕⡮⡳⣝⢮⡳⡳⣝⢽⢽⢽⣻⣷⣿⣿⢿⣿⣻⣿⣟⣿⣿⡿⣿⣿⣟⣿⣟⣿⣟⣿⣟⣿⣿⣯⣿⣿⢿⣻⣽⣎⠨⡈⠌⡪⢐⠨',
" \'⠅⢐⠐⢀⠂⡀⠃⡀⢂⠡⠡⢱⡹⡸⡲⣹⡪⡳⣕⢗⡝⡞⡮⡳⡹⣕⣯⢷⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⣟⣿⣿⣽⣯⢿⣳⣿⣻⣷⣿⢿⣻⣿⣿⣿⣿⡔⠠⢑⠸⡀⡊',
" \'⠅⡀⠂⠄⢂⠐⢀⠂⠠⠨⡨⡢⡇⡧⡳⡵⡽⣹⢜⢕⠁⢁⠠⠈⠑⢕⢽⡽⣿⣾⣿⣟⣯⣿⣯⣿⣾⣿⣿⡿⡿⣞⡷⣯⢿⣽⡾⣿⣯⣿⣿⣿⡿⣿⣻⣷⣷⡑⡐⡱⡐⡨',
" \'⠠⠀⠅⠐⡀⢐⠀⡀⠅⢅⢪⢪⡺⣜⢽⢽⢽⣺⢕⣇⠡⠀⢀⠁⠂⢈⡳⣽⢿⣽⣾⣿⣿⣿⣿⣿⣿⣻⣷⢯⠫⠃⡉⠫⠻⣞⣿⣻⣽⣿⣯⣷⣿⣿⣿⣿⣟⣇⠐⢔⢐⠄',
" \'⡈⠐⡈⠠⠀⠄⢀⠀⠪⡐⢜⢼⡺⣜⢵⢯⣟⣾⣝⡮⣂⠄⠂⠀⠂⠠⣝⣾⣻⣿⣿⣿⣽⣿⣯⣿⣿⣻⡗⢁⠂⠃⠕⡐⠨⣺⢾⣿⣿⣿⢿⣿⣿⢿⣿⣯⣿⡧⠈⠔⡡⠨',
" \'⠂⡁⠀⠂⢁⠠⠀⠨⡨⡊⡎⣟⢮⣺⢽⢯⡷⣷⢯⣯⡯⣯⢯⡳⣕⡑⣗⣗⣿⣯⣷⣿⣿⣿⣻⣿⣽⣷⡣⡀⡂⢁⠂⣂⣵⣿⣿⣿⣿⣾⣿⣿⣿⣿⣿⣟⣿⣽⡨⠐⢌⠌',
" \'⡁⢀⠁⡈⠀⢀⠀⡑⡐⢅⢫⣯⣳⢽⡽⣯⢿⣽⣻⢾⡽⡯⣯⢟⡮⡪⣺⡳⣯⣿⣟⣿⣯⣿⣿⣿⢿⣳⢽⣿⣿⣷⣿⣿⣿⣟⣯⣷⣿⣿⣿⣿⣿⣻⣽⣿⣿⣽⡆⠡⡈⠆',
" \'⠄⠂⠀⠄⠐⢀⠠⠐⡨⢂⠧⣗⡯⣗⣯⡿⣽⡾⣽⢯⢿⢽⣫⢟⡼⣕⢗⡽⣻⣾⣻⣿⣿⣻⣿⣾⡿⣽⣻⣿⣾⣿⣿⣽⣾⣿⣿⣿⣿⣿⣿⣯⣿⣿⣿⣿⢿⣺⡇⡂⡂⠅',
" \'⠨⠀⠂⠐⢈⠠⢀⠂⡂⢕⢘⢞⢿⢽⣺⡯⣿⣽⣻⡽⣽⣳⢽⢵⢝⢮⡳⣯⡿⣾⣽⣿⣟⣿⣿⣽⣾⣳⡿⣿⣽⣾⣿⣿⣿⣿⣿⣿⣿⣿⣻⣿⣿⣿⣻⣾⣿⡿⣇⠢⠨⢂',
" \'⠄⠐⠀⡁⠠⢐⠠⠐⠠⡑⡐⢝⢽⣳⢽⡽⣷⣻⣾⣻⣽⢾⣫⡯⣯⡳⡽⣕⢟⣽⣻⣾⣻⢯⡷⣷⢯⣷⢿⣻⣿⣟⣿⣷⣿⣿⣷⣿⣿⣿⣿⣿⣯⣿⣿⡿⣿⣻⡗⡨⢨⠠',
" \'⠂⡈⠠⠀⠌⠄⡂⠌⢐⠐⠌⡌⢷⢝⡵⡻⡽⣞⡷⣯⣟⣯⡷⣟⡷⣝⣗⣕⢗⢵⣻⣾⣻⢽⣯⣿⣻⣿⣿⣿⣿⣿⣿⡿⣟⣯⣿⣿⣿⣾⣿⣟⣿⡿⣷⣿⣿⣿⠃⠔⡐⠌',
" \'⡁⠀⠄⢈⠠⢁⠂⠌⠠⠈⢌⠢⡑⡳⡽⣹⢝⢯⣟⣗⣯⡷⣟⣯⣟⣷⣳⣳⢝⡵⣻⣽⣽⣿⣯⣿⣿⣿⣯⣷⣿⣷⣿⣿⣿⣿⣿⣿⣟⣿⣿⣻⣿⣿⡿⣟⣯⡯⢈⢂⠢⡁',
" \'⠠⠀⠐⢀⠐⠠⢈⠄⠡⢈⢀⢂⠪⡐⢝⡺⡽⣕⢟⣞⣷⣻⣯⡷⣟⣾⣺⢾⣝⣞⣽⣾⢷⣿⣟⣿⣷⣿⣿⣿⣿⣿⣿⡿⣿⣽⣷⣿⣿⣿⣻⣿⡿⣾⡿⣟⣿⠡⠐⡐⠔⠠',
" \'⠂⡀⠁⠄⢂⠁⡂⠌⠨⠠⢐⢀⢂⢊⠢⡪⡙⠼⣕⢧⣳⡻⣞⣿⣻⡷⣿⡽⣾⣺⢷⡿⣿⣻⣿⣿⣻⣯⣿⣯⣿⣾⢿⣻⣟⣿⢿⣟⣯⣿⣿⣯⡿⣯⢿⣽⠯⠠⢁⠢⠈⠄',
" \'⠄⢀⠂⠐⡀⢐⠠⠡⠨⢐⠐⡐⡐⡐⡑⢌⢪⠱⡩⡢⡪⢯⢟⡾⣟⣿⣯⣿⣿⣽⢿⡿⣿⣿⣯⣿⣿⢿⣿⣻⣽⣾⣟⣿⣽⢿⣿⡿⣿⣿⣷⣿⡽⣯⢿⣾⠃⡁⠢⠨⢐⢀',
" \'⠐⠀⠄⠁⠄⠂⠌⠄⠅⢂⠅⠢⡑⡨⠨⡂⡅⡣⡱⢸⢨⢢⠫⡪⡳⡳⡯⣷⣿⡿⣟⣯⢿⢗⡿⡿⣽⡻⣯⣫⡿⣾⢾⡷⣟⣿⢯⡿⣟⣷⣿⢾⣻⣟⣿⠏⡀⠢⢑⢁⢂⢐',
" \'⢁⠐⢈⠠⠁⢅⠡⠨⠨⠠⡡⢑⡐⢌⠪⡂⢎⠢⣊⢪⢸⢘⢜⢜⢜⢜⠬⡳⡹⡝⣝⢕⢯⡫⣞⣝⣞⣞⣗⣷⣟⣿⣻⢯⡿⣞⡿⡽⣯⢷⢯⣿⣻⣿⠟⠐⡈⠌⢀⠢⠐⠄',
" \'⠄⠀⠂⡠⠁⡂⠌⠨⢈⢂⠜⢔⢌⠆⢕⠸⡨⡊⢆⢕⠜⡜⡌⡆⡇⡇⡇⡇⡗⡵⡱⣝⢵⢝⣞⢼⡺⡮⣷⢿⣾⣻⣞⣯⢯⣷⣻⣽⣳⣟⣿⣿⣻⡯⠨⠐⡀⡁⠄⢅⠑⡐',
" \'⠄⢁⠡⢀⢂⢐⠌⡌⡂⢆⠣⡣⡑⡅⡣⡑⡌⡪⢢⠱⡑⡕⡜⢜⢜⢜⢜⢜⡕⣝⢜⢮⡳⣝⢮⡳⣝⢽⢽⣻⣞⣗⡯⣞⣟⣞⣗⣯⣷⣿⢯⡿⡝⡀⠂⢁⠠⠐⠨⢐⠐⡠',
" \'"Finn" by Robert Fuller'
" \]



let g:startify_bookmarks = [
			\'~/notes.txt'
			\]
let g:startify_lists = [
			\ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
			\ { 'type': 'sessions',  'header': ['   Sessions']       },
			\ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
			\ { 'type': 'commands',  'header': ['   Commands']       },
			\ ]
"g:startify_bookmarks
"g:startify_change_to_dir
"g:startify_change_to_vcs_root
"g:startify_change_cmd
"g:startify_custom_header
"g:startify_enable_special
"g:startify_list_order
"g:startify_skiplist
"g:startify_update_oldfiles

"MISC OPTIONS
"g:startify_commands|
"g:startify_custom_footer|
"g:startify_custom_header_quotes|
"g:startify_custom_indices|            
"g:startify_disable_at_vimenter|
"g:startify_enable_unsafe|
"g:startify_files_number|
"g:startify_fortune_use_unicode|
"g:startify_padding_left|
"g:startify_relative_path|
"g:startify_skiplist_server|
"g:startify_use_env|


"SESSIONS 				
"g:startify_session_autoload
"g:startify_session_before_save
"g:startify_session_delete_buffers
"g:startify_session_number
"g:startify_session_remove_lines
"g:startify_session_savecmds
"g:startify_session_savevars
"g:startify_session_sort}}}
