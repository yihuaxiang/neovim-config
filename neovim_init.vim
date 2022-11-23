"=============================================================================
" init.vim --- Entry file for neovim
" Copyright (c) 2016-2017 Wang Shidong & Contributors
" Author: Wang Shidong < wsdjeg at 163.com >
" URL: https://spacevim.org
" License: GPLv3
"=============================================================================

execute 'source' fnamemodify(expand('<sfile>'), ':h').'/config/main.vim'


" For startify
let g:startify_custom_header = [
\ '',
\ '                       __         _    _        _    _      _         _      ',
\ '                      / /    ___ | |_ ( ) ___  | |_ | |__  (_) _ __  | | __  ',
\ '                     / /    / _ \| __||/ / __| | __|| |_ \ | || |_ \ | |/ /  ',
\ '                    / /___ |  __/| |_    \__ \ | |_ | | | || || | | ||   <   ',
\ '                    \____/  \___| \__|   |___/  \__||_| |_||_||_| |_||_|\_\  ',
\ '                                                                             ',
\ '                                 [ ThinkVim   Author:fudongdong ]            ',
\ '',
\]


let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_flow = 1
let javascript_enable_domhtmlcss = 1
let mapleader = ","
let g:deoplete#enable_at_startup = 0

" 通过 ESC 退出 :te 打开的终端模拟器
:tnoremap <Esc> <C-\><C-n>

map <Leader>e :History<CR>
map <Leader>f :Ag<CR>
map <Leader>wc <C-w><C-c><Esc>
map <Leader>ws <C-w><C-s><Esc>
map <Leader>wv <C-w><C-v><Esc>
map <Leader>ww <C-w><C-w><Esc>
map <Leader>wh <C-w><C-h><Esc>
map <Leader>s :w<CR>

" 取消<C-c>复制文件名的功能
unmap <C-c>

" 打开 shell
map <Leader>sh <Space>'
map <Leader>q :q<CR>
map <Leader>cp :q<CR>
map <Leader>z <C-z>
map <Leader>new :!touchr <C-%>
map <Leader>dlt :!rm <C-r>%
map <Leader>n :bn<CR>
map <Leader>p :bp<CR>
map <silent> <Leader>on :on<CR>
map <Leader>b :b<Space>
map <Leader>rn :!run_file<Space>%<Space>`pwd`<CR>
" 使用 spaceVim 的 git 更方便
" map <Leader>hs :!git log --abbrev-commit %<CR>
map <Leader>lg :Git log --all --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit<CR>
map <Leader>gc <Plug>(coc-git-commit)
map <Leader>ck :te gck<CR>
map <Leader>fix <Plug>(coc-fix-current)
" 引入光标所在单词的js依赖
map <Leader>imjs :ImportJSWord<CR>
" 将 vue 组件引入当前 vue 组件内
map <Leader>im :!impvue $PWD %
nmap <silent> gd <Plug>(coc-definition)
" Symbol renaming.
" nmap <leader>rm <Plug>(coc-rename)
" nnoremap <Leader>s :<C-u>call gitblame#echo()<CR>
nnoremap <Leader>an :Git blame<CR>
nnoremap <Leader>df :Git diff
" 使用 ydiff 进行对比
nnoremap <Leader>ydf :te ydiff -s
nnoremap <Leader>aj :call AceJumpWord("")<CR>
nnoremap <Leader>cm :!git commit % -m ""<LEFT>
nnoremap <Leader>rs :!git restore %<CR>
nnoremap <Leader>ad :!git add %<CR>

" 打开光标所在的文件
nnoremap <F9> gf
" 打开提示信息
nnoremap <Leader>h :call CocActionAsync('doHover')<CR>
"
"
" 用于复制当前文件相对于项目根路径的路径，用于vue项目
map <Leader>path :!echo -n \"@\/%\" \| pbcopy<CR>


" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" 历史位置跳转函数
" 支持在历史位置之间进行跳转
" 调用方法：:call GotoJump()
function! GotoJump()
  jumps
  let j = input("Please select your jump: ")
  if j != ''
    let pattern = '\v\c^\+'
    if j =~ pattern
      let j = substitute(j, pattern, '', 'g')
      execute "normal " . j . "\<c-i>"
    else
      execute "normal " . j . "\<c-o>"
    endif
  endif
endfunction

" 历史位置跳转映射
map <Leader>j :call GotoJump()<CR>

unmap s

" 开启语法高亮
syntax on


" 将 space.vim 的默认文件管理器替换成nerdtree，默认快捷键 f3
" map <F2> :NERDTreeToggle<CR>
noremap <silent> <C-p> :Files<CR>
noremap <silent> <S-f> :Ag<CR>
" noremap <silent> <C-;> :call AceJumpWord("")<CR>







call plug#begin()
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips' " 该插件会整合deoplete，导致coc提示异常, 2020-11-25 21:43:58
Plug 'preservim/nerdtree'
Plug 'MattesGroeger/vim-bookmarks'
Plug 'Galooshi/vim-import-js'
Plug 'kristijanhusak/vim-js-file-import'
" Plug 'dense-analysis/ale'
Plug '907th/vim-auto-save'
Plug 'itchyny/lightline.vim'                                " better look of vim status line
Plug 'Xuyuanp/nerdtree-git-plugin'                          " show git status in file tree view
Plug 'editorconfig/editorconfig-vim'                        " Editorconfig file support. see https://editorconfig.org/
Plug 'posva/vim-vue'                                        " Vue JS syntax highlighting
Plug 'prettier/vim-prettier'                                " Prettier - automatically format file according to rules/editorconfig
Plug 'cakebaker/scss-syntax.vim'                            " SCSS syntax
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'zivyangll/git-blame.vim' 暂时不可用，有bug ： https://github.com/zivyangll/git-blame.vim/issues/18
Plug 'tpope/vim-fugitive'
Plug 'MaryHal/AceJump.vim'
" 图片是字符形式的，而且会影响nerdTree的使用
" Plug 'ashisha/image.vim'
" Plug 'ap/vim-buftabline'
Plug 'ruanyl/vim-fixmyjs'
Plug 'preservim/nerdcommenter'
Plug 'vim-airline/vim-airline'
Plug 'christoomey/vim-run-interactive'
" Plug 'kassio/neoterm' 不好用啊

" vim-netranger 文件浏览工具
Plug 'ipod825/vim-netranger'

" # ncm2
" install ncm2 document: https://github.com/ncm2/ncm2
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()

Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'

" IMPORTANT: :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect

" ranger https://github.com/francoiscabrol/ranger.vim
" 控制台文件管理器
Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim'

Plug 'Shougo/vimproc.vim', {'do' : 'make'}

call plug#end()

let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/UltiSnips']
let g:auto_save = 1  " enable AutoSave on Vim startup

" 安装 ncm2 需要的配置
let g:python3_host_prog="/usr/local/bin/python3"

" https://www.bha.ee/neovim-config-for-frontend-development/
"



" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c


" Apply AutoFix to problem on the current line.
map <leader>fix  <Plug>(coc-fix-current)
" Formatting selected code.
map <leader>fm  :Format<CR>

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

let g:coc_global_extensions = ['coc-json','coc-css']





" 关闭默认映射，避免冲突，仅开启 cc 快捷映射
" https://github.com/preservim/nerdcommenter#settings
" Create default mappings
let g:NERDCreateDefaultMappings = 0
nnoremap ,cc :call NERDComment(0,"toggle")<CR>
vnoremap ,cc :call NERDComment(0,"toggle")<CR>


" https://www.vim.org/scripts/script.php?script_id=1071
function! BufOnly(buffer, bang)
	if a:buffer == ''
		" No buffer provided, use the current buffer.
		let buffer = bufnr('%')
	elseif (a:buffer + 0) > 0
		" A buffer number was provided.
		let buffer = bufnr(a:buffer + 0)
	else
		" A buffer name was provided.
		let buffer = bufnr(a:buffer)
	endif

	if buffer == -1
		echohl ErrorMsg
		echomsg "No matching buffer for" a:buffer
		echohl None
		return
	endif

	let last_buffer = bufnr('$')

	let delete_count = 0
	let n = 1
	while n <= last_buffer
		if n != buffer && buflisted(n)
			if a:bang == '' && getbufvar(n, '&modified')
				echohl ErrorMsg
				echomsg 'No write since last change for buffer'
							\ n '(add ! to override)'
				echohl None
			else
				silent exe 'bdel' . a:bang . ' ' . n
				if ! buflisted(n)
					let delete_count = delete_count+1
				endif
			endif
		endif
		let n = n+1
	endwhile

	if delete_count == 1
		echomsg delete_count "buffer deleted"
	elseif delete_count > 1
		echomsg delete_count "buffers deleted"
	endif

endfunction

command! -nargs=? -complete=buffer -bang BufOnly
    \ :call BufOnly('<args>', '<bang>')


" kite 配置
" JavaScript
" let g:kite_supported_languages = ['javascript']


" https://github.com/vim-airline/vim-airline
let g:airline#extensions#tabline#enabled = 1

let g:spacevim_enable_vimfiler_welcome = 0

" from https://github.com/preservim/nerdtree
" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | wincmd p | endif
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

" 关闭 ranger 的默认 key map
let g:ranger_map_keys = 0
let g:NERDTreeHijackNetrw = 0
let g:ranger_replace_netrw = 1


" 避免json文件中的双引号被隐藏
" 参考文档： https://vi.stackexchange.com/questions/7258/how-do-i-prevent-vim-from-hiding-symbols-in-markdown-and-json
let g:indentLine_fileTypeExclude = ['json']

execute "set ic"
execute "highlight NonText guibg=none"
execute "highlight Normal guibg=none"


" 解决 NERDCommenter 在 vue 文件中注释格式错误的问题
" 参考链接：https://github.com/posva/vim-vue#how-can-i-use-nerdcommenter-in-vue-files
" 不生效，哎
let g:ft = ''
function! NERDCommenter_before()
  if &ft == 'vue'
    let g:ft = 'vue'
    let stack = synstack(line('.'), col('.'))
    if len(stack) > 0
      let syn = synIDattr((stack)[0], 'name')
      if len(syn) > 0
        exe 'setf ' . substitute(tolower(syn), '^vue_', '', '')
      endif
    endif
  endif
endfunction
function! NERDCommenter_after()
  if g:ft == 'vue'
    setf vue
    let g:ft = ''
  endif
endfunction
