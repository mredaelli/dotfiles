autocmd FileType cpp,c call SetupCpp()

function! SetupCpp()
	let g:clang_complete_auto = 0
	let g:clang_library_path = '/nix/store/fggspvgd8sw122p322whbhim7k4myv8p-clang-5.0.1-lib/lib/libclang.so.5.0'
	let g:clang_auto_select = 0
	let g:clang_omnicppcomplete_compliance = 0
	let g:clang_make_default_keymappings = 0

	let g:neomake_error_sign = { 'text': 'E', 'texthl': 'NeomakeErrorSign' }
	let g:neomake_warning_sign = { 'text': 'W', 'texthl': 'NeomakeWarningSign' }   
	"let g:neomake_open_list = 0
	"let g:neomake_list_height = 5
	let g:neomake_highlight_lines = 1
	let g:neomake_cpp_enabled_markers=['clangtidy']
	"let g:neomake_cpp_gcc_maker = {
	"\ 'exe': 'g++',
	"\ 'args': ['-Wall', '-Iinclude', '-Wextra'] 
	"\ }
	let g:neomake_cpp_clangtidy_maker = {
	\ 'exe': 'clang-tidy',
	\ 'args': ['-checks=\*'] 
	\ }

	let g:cpp_class_scope_highlight = 1
	let g:cpp_member_variable_highlight = 1
	let g:cpp_class_decl_highlight = 1
	let g:cpp_experimental_simple_template_highlight = 1

	call neomake#configure#automake('rw', 1000)

	ClangFormatAutoEnable
	ClangFormatAutoEnable

	call SetupDev()
endfunction
