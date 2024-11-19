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
     update_file(FilePath, replace(ModuleName, _, _), true).
    load_files(FilePath, [silent(true)]),
    call(ModuleName),
     update_file(FilePath, replace(ModuleName, _, _), false).
   
replace(test_interval, A, B) :-
    A = ':- use_module(library(interval)).',
    B = ':- use_module(''prolog/interval'').'.

replace(test_interval, A, B) :-
    A = ':- use_module(library(mcclass)).',
    B = ':- use_module(''prolog/mcclass'').'.

replace(test_interval, A, B) :-
    A = ':- use_module(library(rint)).',
    B = ':- use_module(''prolog/rint'').'.

update_file(FilePath, ReplacePredicate, ApplyReplace) :-
    setup_call_cleanup(
        open(FilePath, read, In),
        read_string(In, _, Content),
        close(In)
    ),
    split_string(Content, "\n", "", Lines),
    maplist(apply_replace(ReplacePredicate, ApplyReplace), Lines, NewLines),
    atomic_list_concat(NewLines, "\n", NewContent),
    setup_call_cleanup(
        open(FilePath, write, Out),
        write(Out, NewContent),
        close(Out)
    ).


apply_replace(ReplacePredicate, true, Line, NewLine) :-
    (   call(ReplacePredicate, Line, NewLine)
    ->  true
    ;   NewLine = Line).

apply_replace(ReplacePredicate, false, Line, NewLine) :-
    (   call(ReplacePredicate, NewLine, Line)
    ->  true
    ;   NewLine = Line).
