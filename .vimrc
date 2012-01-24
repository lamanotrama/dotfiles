" Vundle
set nocompatible
filetype off
set rtp+=~/.vim/vundle/
call vundle#rc()
let g:vundle_default_git_proto = 'git'

Bundle 'Align'
Bundle 'mileszs/ack.vim'
Bundle 'eregex.vim'
Bundle 'YankRing.vim'
Bundle 'L9'
Bundle 'FuzzyFinder'
Bundle 'mru.vim'
Bundle 'minibufexpl.vim'
Bundle 'banyan/Nonopaste.vim'
Bundle 'Puppet-Syntax-Highlighting'
Bundle 'sudo.vim'
Bundle 'scrooloose/syntastic'
Bundle 'tpope/vim-fugitive'
Bundle 'Markdown'

syntax on
filetype plugin on
filetype indent on

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" show the cursor position all the time
set ruler

" always set autoindenting on
set autoindent

" keep 50 lines of command line history
set history=150

" dictionary
set dict=/usr/share/dict/words

" encode
set encoding=utf-8
if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
   set fileencodings=utf-8,euc-jp,iso-2022-jp,latin1
endif

" :も単語の一部とみなす(module名補完用)
set iskeyword+=:

" 右クリックペーストあり
" set paste

" タブ幅の設定
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" psgiもperlとして
au BufRead,BufNewFile *.psgi  set filetype=perl

" rubyはtab幅2
au FileType ruby set ts=2 sts=2 sw=2

" puppetはtab幅2
au FileType puppet set ts=2 sts=2 sw=2

" モードライン無効
set modelines=0

"インデントはスマートインデント
set smartindent

"検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase

"検索文字列に大文字が含まれている場合は区別して検索する
set smartcase

"検索時に最後まで行ったら最初に戻る
set wrapscan

"検索文字列入力時に順次対象文字列にヒットさせない
set noincsearch

"タブの左側にカーソル表示
"set listchars=tab:\\ 

"タブや改行を表示しない
set nolist

"入力中のコマンドをステータスに表示する
set showcmd

"カーソル上の括弧をハイライトしない。
let loaded_matchparen = 1

"括弧入力時の対応する括弧を表示
"set showmatch

"検索結果文字列のハイライトを有効
set hlsearch

"ステータスラインを常に表示
set laststatus=2

"ステータスラインに文字コードと改行文字を表示する
function! GetB()
  let c = matchstr(getline('.'), '.', col('.') - 1)
  let c = iconv(c, &enc, &fenc)
  return String2Hex(c)
endfunction

" :help eval-examples
" The function Nr2Hex() returns the Hex string of a number.
func! Nr2Hex(nr)
  let n = a:nr
  let r = ""
  while n
    let r = '0123456789ABCDEF'[n % 16] . r
    let n = n / 16
  endwhile
  return r
endfunc

" The function String2Hex() converts each character in a string to a two
" character Hex string.
func! String2Hex(str)
  let out = ''
  let ix = 0
  while ix < strlen(a:str)
    let out = out . Nr2Hex(char2nr(a:str[ix]))
    let ix = ix + 1
  endwhile
  return out
endfunc

" set statusline=%<[%n]%m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']['.&ft.']'}\ %F%=%l,%c%V%8P
if winwidth(0) >= 120
  set statusline=%<[%n]%m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}%y\ %F%=[%{GetB()}]\ %l,%c%V%8P
else
  set statusline=%<[%n]%m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}%y\ %f%=[%{GetB()}]\ %l,%c%V%8P
endif

function! GetB()
  let c = matchstr(getline('.'), '.', col('.') - 1)
  let c = iconv(c, &enc, &fenc)
  return String2Hex(c)
endfunction

" :help eval-examples
" The function Nr2Hex() returns the Hex string of a number.
func! Nr2Hex(nr)
  let n = a:nr
  let r = ""
  while n
    let r = '0123456789ABCDEF'[n % 16] . r
    let n = n / 16
  endwhile
  return r
endfunc

" The function String2Hex() converts each character in a string to a two
" character Hex string.
func! String2Hex(str)
  let out = ''
  let ix = 0
  while ix < strlen(a:str)
    let out = out . Nr2Hex(char2nr(a:str[ix]))
    let ix = ix + 1
  endwhile
  return out
endfunc

" コマンドライン補間をシェルっぽく
set wildmode=list:longest

" バッファが編集中でもその他のファイルを開けるように
set hidden

" 外部のエディタで編集中のファイルが変更されたら自動で読み直す
set autoread

"表示行単位で行移動する
nmap j gj
nmap k gk
vmap j gj
vmap k gk

",w でそのコマンドを保存
nmap ,w :w<CR>
" nmap ,ww :w<CR>
",e でそのコマンドを保存実行
nmap ,e :w<CR>:execute '!' &ft '%'<CR>
",r でperl実行。
nmap ,r :w<CR>:!perl -I lib/ %<CR>
",t でprove実行。
nmap ,t :w<CR>:!prove -lv %<CR>
",c でperlのシンタックスチェック
nmap ,c :w<CR>:!perl -I lib/ -c %<CR>
",g でcをコンパイル、実行
nmap ,g :w<CR>:!gcc -o ./%.out %<CR>:! ./%.out<CR>
",d で日付挿入
nmap ,d :r !LANG=C date '+\%Y-\%m-\%d \%T\n'<CR>

" 一発リネーム
"09/06/08 http://vim-users.jp/2009/05/hack17/
command! -nargs=1 -complete=file Rename f <args>|call delete(expand('#'))

" mru open履歴
"10/09/05 http://nanasi.jp/articles/vim/mru_vim.html
let MRU_Max_Entries=30
let MRU_Window_Height=20

" 全削除
nnoremap da :<C-u>%d<CR>

" Ctrl-J/K で上下左右のWindowへ移動
nmap <C-J> <C-W>j
nmap <C-K> <C-W>k
nmap <C-H> <C-W>h
nmap <C-K> <C-W>k

" 初期状態を自動生成
autocmd BufNewFile *.pl 0r ~/.vim/skel/pl
autocmd BufNewFile *.pm 0r ~/.vim/skel/pm
autocmd BufNewFile *.sh 0r ~/.vim/skel/sh
autocmd BufNewFile *.pp 0r ~/.vim/skel/pp

"挿入モード時、ステータスラインの色を変更
"http://sites.google.com/site/fudist/Home/vim-nihongo-ban/vim-color
let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=blue ctermbg=yellow cterm=none'

if has('syntax')
  augroup InsertHook
    autocmd!
    autocmd InsertEnter * call s:StatusLine('Enter')
    autocmd InsertLeave * call s:StatusLine('Leave')
  augroup END
endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
  if a:mode == 'Enter'
    silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
    silent exec g:hi_insert
  else
    highlight clear StatusLine
    silent exec s:slhlcmd
  endif
endfunction

function! s:GetHighlight(hi)
  redir => hl
  exec 'highlight '.a:hi
  redir END
  let hl = substitute(hl, '[\r\n]', '', 'g')
  let hl = substitute(hl, 'xxx', '', '')
  return hl
endfunction

"全角スペースを表示
highlight ZenkakuSpace ctermbg=white
match ZenkakuSpace /　/

"Tab、行末の半角スペースを明示的に表示する。
set list
set listchars=tab:^\ ,trail:~

" for Fugitive {{{
""nnoremap ,gd    : <C-u>Gdiff<Enter>
nnoremap ,gd    :<C-u>w<CR>:Git diff<Enter>
nnoremap ,gdc   :<C-u>w<CR>:Git diff --cached<Enter>
nnoremap ,gs    :<C-u>Gstatus<Enter>
nnoremap ,gst   :<C-u>Gstatus<Enter>
nnoremap ,gl    :<C-u>Glog<Enter>
nnoremap ,ga    :<C-u>Gwrite<Enter>
nnoremap ,gci   :<C-u>Gcommit -a<Enter>
nnoremap ,gc    :<C-u>Gcommit<Enter>
nnoremap ,gC    :<C-u>Git commit --amend<Enter>
nnoremap ,gb    :<C-u>Gblame<Enter>
" }}}

" hasekoのやつ。http://d.hatena.ne.jp/bannyan/20111024/1319420124
let g:nonopaste_url = "http://192.168.25.37/nonopaste/"

"minibufexpl
let g:miniBufExplMapWindowNavVim=1 "hjklで移動
let g:miniBufExplSplitBelow=0  " Put new window above
let g:miniBufExplMapWindowNavArrows=1
let g:miniBufExplMapCTabSwitchBufs=1
let g:miniBufExplModSelTarget=1 
let g:miniBufExplSplitToEdge=1
nnoremap <C-d>    : bd<CR>
nmap <Space>      : MBEbn<CR>
nmap <C-n>        : MBEbn<CR>
nmap <C-p>        : MBEbp<CR>
" yankringとかぶるので、yankringの方を変更
let g:yankring_replace_n_nkey = '<S-n>'
let g:yankring_replace_n_pkey = '<S-p>'

" fuf *set pasteと共存不可
let g:fuf_modesDisable = ['mrucmd']
let g:fuf_file_exclude = '\v\~$|\.(o|exe|bak|swp|gif|jpg|png)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])'
let g:fuf_dir_exclude = '\v\~$|(blib|extlib)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])'
let g:fuf_mrufile_exclude = '\v\~$|\.bak$|\.swp|\.howm$|\.(gif|jpg|png)$'
let g:fuf_mrufile_maxItem = 10000
let g:fuf_enumeratingLimit = 30
let g:fuf_keyPreview = '<C-]>'
let g:fuf_previewHeight = 0
nmap fb :FufBuffer<CR>
nmap fc :FufFileWithCurrentBuffer<CR>
nmap ff :FufFile <C-r>=expand('%:~:.')[:-1-len(expand('%:~:.:t'))]<CR><CR>
nmap fF :FufFile **/<CR>
nmap fL :FufFile ./lib/**/<CR>
nmap fm :FufMruFile<CR>
nmap fq :FufQuickfix<CR>
nmap fl :FufLine<CR>
nnoremap <silent> <C-]> :FufTag! <C-r>=expand('<cword>')<CR><CR>

" GNU screen likeなキーバインド
let mapleader = "\<C-]>"
nnoremap <Leader>n          <C-w><C-w>
nnoremap <Leader><Space>    <C-w><C-w>
nnoremap <Leader>j          <C-w>j
nnoremap <Leader>k          <C-w>k
nnoremap <Leader>h          <C-w>h
nnoremap <Leader>l          <C-w>l
nnoremap <Leader>K          : q<CR>
nnoremap <Leader>s          : sp<CR>
nnoremap <Leader><Tab>      : wincmd w<CR>
nnoremap <Leader>Q          : only<CR>
nnoremap <Leader>w          : ls<CR>
nnoremap <Leader><C-w>      : ls<CR>
nnoremap <Leader>a          : e #<CR>
nnoremap <Leader>"          : BufExp<CR>
nnoremap <Leader>1          : e #1<CR>
nnoremap <Leader>2          : e #2<CR>
nnoremap <Leader>3          : e #3<CR>
nnoremap <Leader>4          : e #4<CR>
nnoremap <Leader>5          : e #5<CR>
nnoremap <Leader>6          : e #6<CR>
nnoremap <Leader>7          : e #7<CR>
nnoremap <Leader>8          : e #8<CR>
nnoremap <Leader>9          : e #9<CR>
let mapleader = '\'


