:- initialization(main, main).

main(_) :-
    absolute_file_name('test', TestDir, [file_type(directory)]),
    directory_files(TestDir, Files),
    include(is_prolog_file, Files, PrologFiles),
    maplist(run_tests_for_file(TestDir), PrologFiles),
    halt.

is_prolog_file(File) :-
    file_name_extension(_, 'pl', File).

run_tests_for_file(Dir, File) :-
    file_name_extension(ModuleName, _, File),
    atomic_list_concat([Dir, '/', File], FilePath),
    load_files(FilePath, [silent(true)]),
    call(ModuleName),
   
