"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""               
"               
"               ██╗   ██╗██╗███╗   ███╗██████╗  ██████╗
"               ██║   ██║██║████╗ ████║██╔══██╗██╔════╝
"               ██║   ██║██║██╔████╔██║██████╔╝██║     
"               ╚██╗ ██╔╝██║██║╚██╔╝██║██╔══██╗██║     
"                ╚████╔╝ ██║██║ ╚═╝ ██║██║  ██║╚██████╗
"                 ╚═══╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝
"               
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""               

"------------------PLUGINS------------------


	call plug#begin()

		Plug 'https://github.com/preservim/nerdtree' " Nerd Tree
		Plug 'https://github.com/ryanoasis/vim-devicons' " Developer Icons
		Plug 'https://github.com/vim-airline/vim-airline' " Status bar
		Plug 'tpope/vim-fugitive' " Git integration
		Plug 'neoclide/coc.nvim', {'branch': 'release'} "for auto complete 


	call plug#end()

"	to do:
"
"		plug:
"			:PlugClean
"			:PlugInstall
"
"		nvim.coc:
"			python->	:CocInstall coc-python
"			python3->	:CocInstall coc-pyright
"			cpp->	:CocInstall coc-clangd





"------------------SETTINGS------------------


" Disable compatibility with vi which can cause unexpected issues.
	set nocompatible

" Disable the vim bell
	set visualbell

" Disable auto commenting in a new line
	autocmd Filetype * setlocal formatoptions-=c formatoptions-=r  formatoptions-=o

" Setting the character encoding of Vim to UTF-8
	set encoding=UTF-8

" Enable type file detection. Vim will be able to try to detect the type of file is use.
	filetype on

" Enable spell check
	set spell

" Smart tab
	set smarttab

" Search down to subfolders
	set path+=**

" Enable plugins and load plugin for the detected file type.
	filetype plugin on

" Load an indent file for the detected file type.
	filetype indent on

" Turn syntax highlighting on.
	syntax on

" Add numbers to the file.
	set number relativenumber

" Mouse functionality
	set mouse=a

" Color scheme
	color slate 

" Highlight cursor line underneath the cursor horizontally.
	set cursorline

" Highlight cursor line underneath the cursor vertically.
	set cursorcolumn

" Set shift width to 4 spaces.Set tab width to 4 columns.
	set shiftwidth=4
	set tabstop=4

" If the current file type is HTML, set indentation to 2 spaces.
	autocmd Filetype html setlocal tabstop=2 shiftwidth=2 expandtab

" Do not save backup files.
	set nobackup

" Do wrap lines.
	set wrap

" While searching though a file incrementally highlight matching characters as you type.
	set incsearch
	set hlsearch

" Ignore capital letters during search.
	set ignorecase

" Show partial command you type in the last line of the screen.
	set showcmd

" Show the mode you are on the last line.
	set showmode

" Show matching words during a search.
	set showmatch

" Set the commands to save in history default number is 20.
	set history=1000

" Setting the split window to open as i like (like in a WM - qtile)
	set splitbelow splitright

" Enable auto completion menu after pressing TAB.
	set wildmenu

" There are certain files that we would never want to edit with Vim.
" Wild menu will ignore files with these extensions.
	set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

" If Vim version is equal to or greater than 7.3 enable undo file.
" This allows you to undo changes to a file even after saving it.
	if version >= 703
    	set undodir=~/.vim/backup
    	set undofile
    	set undoreload=10000
	endif

" Closing compaction in insert mode
	inoremap ' ''<left>
	inoremap ` ``<left>
	inoremap " ""<left>
	inoremap ( ()<left>
	inoremap [ []<left>
	inoremap { {}<left>
	inoremap /* /**/<left><left>


" Status line
	let g:airline_powerline_fonts = 1


" File Browsing settings
	let g:netrw_banner=0
	let g:netrw_liststyle=3
	let g:netrw_showhide=1
	let g:netrw_winsize=20


" Nerd tree settings
	let g:NERDTreeDirArrowExpandable="+"
	let g:NERDTreeDirArrowCollapsible="~"
	let g:NERDTreeShowHidden=1
	let g:NERDTreeWinSize = 20



" Exit Vim if NERD Tree is the only window remaining in the only tab.
	autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

"------------------GVIM - GUI VERSION------------------


	if has('gui_running')

    	" Set the color scheme.
    		color slate

		" Font
			if has("gui_macvim")
    			set guifont=Menlo\ Regular:h14
			elseif has("gui_win32")
				set guifont="Consolas 11"
			else
				set guifont=Consolas\ 14
			endif

		" Hide the toolbar.
			set guioptions-=T

    	" Hide the right-side scroll bar.
    		set guioptions-=r

		" Start NERD Tree and put the cursor back in the other window.
			autocmd VimEnter * NERDTree | wincmd p

	endif


"------------------Hebrew_Toggle_Function------------------


function! ToggleHebrew()
	if &rl
		set norl
		set keymap=
		set spell
		echom "Hebrew mode OFF"
	else
		set rl
		set keymap=hebrew
		set nospell
		echom "Hebrew mod ON"
	endif
endfunction


"------------------KEY_BINDINGS------------------


" Spell-check on\off
	map <C-z> :setlocal spell! spelllang=en_us<CR>


" Type jj to exit insert mode quickly.
	inoremap jj <Esc>


" Format a paragraph into lines
	map Q gq<CR>


" Set the space  as the leader key.
	let mapleader = " "


" Opening a file explore - stay as only window unlike NERD tree
	map <leader>e :Lex<CR>


" Opening a terminal window
	map <c-t> :ter<CR>
" Closing the terminal window
	tnoremap <c-t> exit<CR>
" CTRL+I to make the terminal scrollable and I to input mode
	tnoremap <c-i> <c-w><s-n> 


" You can split the window in Vim. y - in the y access , x - in the x access
	map <leader>y :split<space>
	map <leader>x :vsplit<space>


" Navigate the split view easier by pressing CTRL+j, CTRL+k, CTRL+h, or CTRL+l.
	nnoremap <c-j> <c-w>j
	nnoremap <c-k> <c-w>k
	nnoremap <c-h> <c-w>h
	nnoremap <c-l> <c-w>l


" Resize split windows using arrow keys by pressing:
" Alt+UP, Alt+DOWN, Alt+LEFT, or Alt+RIGHT.
	noremap <a-Up> <c-w>+
	noremap <a-Down> <c-w>-
	noremap <a-Left> <c-w>>
	noremap <a-Right> <c-w><


" Moving between tabs
	map <leader>t gt


" Opening\Creating a file in a new tab - write the tab to open
	nnoremap <leader>c :tabedit<space>


" Saving a file using CTRL+S
	map <C-S> :w<CR>


" Quitting and saving a file using CTRL+S
	map <C-q> :wq<CR>


" Replace all occurrences of a word
	nnoremap <leader>rw :%s/\<<c-r><c-w>\>//g<left><left>


" Toggle Hebrew key maps and Right-to-Left setting
	nnoremap <leader>ht <cmd>call ToggleHebrew()<CR>


" Map V-Block to not confuse with Past
	noremap <leader>v <C-v>

" Opening/closing NERD tree
	map <leader>n :NERDTreeToggle<CR>


" Git integration
	" Git stage all changes
	nnoremap <leader>ga <cmd>w<CR> <cmd>G add .<CR>
	" Git commit
	nnoremap <leader>gc <cmd>G commit<CR>
	" Git push current branch
	nnoremap <leader>gp <cmd>G push<CR>
	" Git status
	"	Keys:
	"		- -> stage and ustage a file
	"		cc -> commit massage
	nnoremap <leader>gs <cmd>G<CR>
	" Git log
	nnoremap <leader>gl <cmd>G log<CR>
	" Git marge conflict: 
	"	:Gvdiffsplit!
	"		to chose what window we want to take: dXo - (X - left-> d2o , right-> d3o)


" Coc functionality
	"Tab and Enter completion
	" Up key: Cycles through completion 
	inoremap <silent><expr> <Up> coc#pum#visible() ? coc#pum#prev(1) : "\<Up>"

	" Down key: Cycles through completion items in reverse order
	inoremap <silent><expr> <Down> coc#pum#visible() ? coc#pum#next(1) : "\<Down>"

	" Tab & Enter key: Accepts the selected completion
	inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
	inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<Tab>"

	" Jump to definition (X and Y for the axis, T for tab)
	nnoremap <leader>dx <cmd>call CocAction('jumpDefinition', 'vsplit')<CR>
	nnoremap <leader>dy <cmd>call CocAction('jumpDefinition', 'split')<CR>
	nnoremap <leader>dt <cmd>call CocAction('jumpDefinition', 'tabe')<CR>


" For copy and past
	map <C-S-V> "+P
	vnoremap <C-C> "*y :let @+=@*<CR>
" If not in Linux replace the keybinding in above line with: vnoremap <C-C> "+y


" Seeing the registers
	nnoremap <leader>r <cmd>registers<CR>


" Moving lines in visual mode
	vnoremap J :m '>+1<CR>gv=gv
	vnoremap K :m '>-2<CR>gv=gv


"------------------END_KEY------------------

