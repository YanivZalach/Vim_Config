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

		Plug 'https://github.com/vim-airline/vim-airline' " Status bar
		Plug 'tpope/vim-fugitive' " Git integration
		Plug 'neoclide/coc.nvim', {'branch': 'release'} "for auto complete 
		Plug 'YanivZalach/mini-harpoon' " Adding VIM file Navigate


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
	inoremap [ []<left>
	inoremap ( ()<left>
	inoremap { {}<left>
	inoremap /* /**/<left><left>


" Status line
	let g:airline_powerline_fonts = 1


" File Browsing settings
	let g:netrw_banner=1
	let g:netrw_liststyle=3
	let g:netrw_showhide=1
	let g:netrw_winsize=20


"------------------GVIM - GUI VERSION------------------


	if has('gui_running')

    	" Set the color scheme.
    		color slate

		" Font
			if has("macvim")
    			set guifont=Menlo\ Regular:h14
			elseif has("win32")
				set guifont="Consolas 14"
			else
				set guifont=Consolas\ 14
			endif

		" Hide the toolbar.
			set guioptions-=T

    	" Hide the right-side scroll bar.
    		set guioptions-=r

		" Opening Netrw on the side
			autocmd VimEnter * Lex | wincmd p


	endif

"------------------Hex_Toggle_Functions------------------

function! DoHex()
    " Get the current buffer name
    let current_file = expand('%')

    " New file name
	let new_file = current_file . '.hex'

    " Save the current buffer as a hex file
    execute 'w !xxd > ' . new_file

    echo "Hex file created and saved as " . new_file
endfunction

function! UndoHex()
    " Get the current buffer name
    let current_file = expand('%')

	" Name stage 1: Remove the .hex extension if it exists
    let new_file_stage1 = substitute(current_file, '\.hex$', '', '')

	" Get the file name without extension
	let file_name = substitute(new_file_stage1, '\(.*\)\.\(\w\+\)$', '\1', '')

	" Get the file extension
	let file_extension = substitute(new_file_stage1, '\(.*\)\.\(\w\+\)$', '\2', '')

	" Add 'M' before the extension(M = Modded)
	let new_file = file_name . 'M.' . file_extension

    " Save the current buffer as a reversed hex file
    execute 'w !xxd -r > ' . new_file

    echo "Reversed Hex file created and saved as " . new_file
endfunction

" Function to toggle between hex and original states
function! HexState()
    " Get user input to choose the operation (0 for DoHex, 1 for UndoHex)
    let operation = input("Choose operation (0 for DoHex, 1 for UndoHex): ")

    if operation == 0
        " Execute the DoHex function
        call DoHex()
    elseif operation == 1
        " Execute the UndoHex function
        call UndoHex()
    else
        echo "Invalid choice. Aborting."
    endif
endfunction

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

" Set the space  as the leader key.
	let mapleader = " "


" ---Code_runner--- ( Leader + rr)
		" Markdown
		autocmd Filetype markdown nnoremap <leader>rr <cmd>!echo \n\n\n"Compiling to pdf..."\n && pandoc -f markdown-implicit_figures --highlight-style=tango -t pdf % -o %:r.pdf && zathura %:r.pdf &<CR>
		" Python
		autocmd FileType python nnoremap <leader>rr <cmd>!echo \n\n\n"Output:"\n && python3 %<CR>
		" JavaScript with Node.js
		autocmd FileType javascript nnoremap <leader>rr <cmd>!echo \n\n\n"Output:"\n && node %<CR>
		" HTML in default browser
		autocmd FileType html nnoremap <leader>rr <cmd>!echo \n\n\n"Opening:"\n && open % &<CR>
		" C
		autocmd FileType c nnoremap <leader>rr <cmd>!echo \n\n\n"Compiling:"\n && gcc % -o %:r && echo \n\n\n"Success"\n"The Output:"\n\n && %:p:r<CR>
		" C++
		autocmd FileType cpp nnoremap <leader>rr <cmd>!echo \n\n\n"Compiling:"\n && g++ % -o %:r -pthread -std=c++17 && echo \n\n\n"Success"\n"The Output:"\n\n && %:p:r<CR>
		" Rust
		autocmd FileType rust nnoremap <leader>rr <cmd>!echo \n\n\n"Compiling:"\n && cargo run<CR>
		" LaTeX
		autocmd FileType tex nnoremap <leader>rr <cmd>!echo \n\n\n"Compiling:"\n && xelatex %<CR>

" Spell-check on\off
	map <C-z> :setlocal spell! spelllang=en_us<CR>


" Type jj to exit insert mode quickly.
	inoremap jj <Esc>

" Source the vim config
	nnoremap <leader>sc <cmd>source $MYVIMRC<CR>

" Format a paragraph into lines
	map Q gq<CR>

	" Select all the text
	nnoremap <leader>a ggVG

" Opening a file explore
	map <leader>e :Lex<CR>

" Opening a file from file explore
	map <leader>o :Explore<CR>

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


" Saving all file using CTRL+S
	map <C-S> :wa<CR>


" Quitting and saving all file using CTRL+S
	map <C-q> :wqa<CR>


" Replace all occurrences of a word
	nnoremap <leader>rw :%s/\<<c-r><c-w>\>//g<left><left>


" Toggle Hebrew key maps and Right-to-Left setting
	nnoremap <leader>ht <cmd>call ToggleHebrew()<CR>


" Toggle between creating a Hex conversion file and reversing the conversion
	nnoremap <leader>hx <cmd>call HexState()<CR>


" Map V-Block to not confuse with Past
	noremap <leader>v <C-v>


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

	" Organizing imports
	nnoremap <leader>ci <cmd>call CocAction('organizeImport')<CR>
	" Quick fix
	nnoremap <leader>cf <cmd>call CocAction('doQuickfix')<CR>


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

