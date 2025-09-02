:- module(test_rint, [test_rint/0]).

:- use_module(library(plunit)).
:- use_module(library(debug)).
:- use_module(library(rint)).

test_rint :-
    run_tests([r, assignment, colon, binom, normal, t, chisq]).

:- begin_tests(r).

test(r1) :-
    A is 1,
    interval(<-(x, A), _),
    interval(r(x), Res),
    Res = A.

test(r2) :-
    interval(r(1 + 1) + 2...3, Res),
    Res = 4...5.

test(r3) :-
    interval(dbinom(1...2, 10, 0.7), L1...U1),
    interval(r(dbinom(1...2, 10, 0.7)), L2...U2),
    L1 =:= L2,
    U1 =:= U2.

:- end_tests(r).

:- begin_tests(assignment).

test(assign1) :-
    A = 1,
    interval(a <- A, _Res),
    interval(r(a), Res),
    Res =:= A.

test(assign2) :-
    A = 1...2,
    interval(a <- A, _Res),
    interval(r(a), Res),
    Res = A.

:- end_tests(assignment).

:- begin_tests(colon).

test(colon1) :-
    A = 1:10,
    interval(A, A).

:- end_tests(colon).

:- begin_tests(binom).

test(dbinom1) :-
    interval(dbinom(11, 20, 0.6), Res),
    equal(Res, 0.1597...0.1598).

test(dbinom2) :-
    interval(dbinom(11...12, 20, 0.6...0.7), Res),
    equal(Res, 0.0653...0.1798).

test(dbinom3) :-
    interval(dbinom(11...12, 20, 0.6), Res),
    equal(Res, 0.1597...0.1798).

test(dbinom4) :-
    interval(dbinom(11...12, 20...21, 0.6...0.7), Res),
    equal(Res, 0.0411...0.1798).

% left to X / N
test(dbinom5) :- 
    interval(dbinom(10...11, 20...21, 0.6...0.7), Res),
    equal(Res, 0.0176...0.1598).

% right to X / N
test(dbinom6) :- 
    interval(dbinom(15...16, 20...21, 0.6...0.7), Res),
    equal(Res, 0.0349...0.1879).

test(dbinom7) :- 
    interval(dbinom(11, 20...21, 0.6), Res),
    equal(Res, 0.1341...0.1598).

test(dbinom8) :- 
    interval(dbinom(11, 20, 0.6...0.7), Res),
    equal(Res, 0.0653...0.1598).

test(dbinom9) :- 
    interval(dbinom(11...12, 20...21, 0.6), Res),
    equal(Res, 0.1341...0.1798).

test(dbinom10) :- 
    interval(dbinom(11, 20...21, 0.6...0.7), Res),
    equal(Res, 0.0411...0.1598).

test(qbinom1) :-
    interval(qbinom(0.6, 20, 0.3), Res),
    Res = 6.0.

test(qbinom2) :-
    interval(qbinom(0.6...0.7, 20, 0.3), Res),
    Res = 6.0...7.0.

test(qbinom3) :-
    interval(qbinom(0.6, 20...21, 0.3), Res),
    Res = 6.0...7.0.

test(qbinom4) :-
    interval(qbinom(0.6, 20, 0.3...0.4), Res),
    Res = 6.0...9.0.

test(qbinom5) :-
    interval(qbinom(0.6...0.7, 20...21, 0.3), Res),
    Res = 6.0...7.0.

test(qbinom6) :-
    interval(qbinom(0.6, 20...21, 0.3...0.4), Res),
    Res = 6.0...9.0.

test(qbinom7) :-
    interval(qbinom(0.6...0.7, 20...21, 0.3...0.4), Res),
    Res = 6.0...10.0.

test(qbinom8) :-
    interval(qbinom(0.6, 20, 0.3, true), Res),
    Res = 6.0.

test(qbinom9) :-
    interval(qbinom(0.6, 20, 0.3, false), Res),
    Res = 5.0.

test(qbinom10) :-
    interval(qbinom(0.4...0.6, 20, 0.3, true), Res),
    Res = 5.0...6.0.

test(qbinom11) :-
    interval(qbinom(0.4...0.6, 20, 0.3, false), Res),
    Res = 5.0...6.0.

test(qbinom12) :-
    interval(qbinom(0.6, 20...21, 0.3, true), Res),
    Res = 6.0...7.0.

test(qbinom13) :-
    interval(qbinom(0.6, 20...21, 0.3, false), Res),
    Res = 5.0...6.0.

test(qbinom14) :-
    interval(qbinom(0.6, 20, 0.3...0.4, true), Res),
    Res = 6.0...9.0.

test(qbinom15) :-
    interval(qbinom(0.6, 20, 0.3...0.4, false), Res),
    Res = 5.0...7.0.

test(qbinom16) :-
    interval(qbinom(0.4...0.6, 20...21, 0.3, true), Res),
    Res = 5.0...7.0.

test(qbinom17) :-
    interval(qbinom(0.4...0.6, 20...21, 0.3, false), Res),
    Res = 5.0...7.0.

test(qbinom18) :-
    interval(qbinom(0.6, 20...21, 0.3...0.4, true), Res),
    Res = 6.0...9.0.

test(qbinom19) :-
    interval(qbinom(0.6, 20...21, 0.3...0.4, false), Res),
    Res = 5.0...8.0.

test(qbinom19) :-
    interval(qbinom(0.4...0.6, 20, 0.3...0.4, true), Res),
    Res = 5.0...9.0.

test(qbinom20) :-
    interval(qbinom(0.4...0.6, 20, 0.3...0.4, false), Res),
    Res = 5.0...9.0.

test(qbinom21) :-
    interval(qbinom(0.5...0.6, 20...21, 0.6...0.7, true), Res),
    equal(Res, 11.9999...15.0001).

test(qbinom22) :-
    interval(qbinom(0.5...0.6, 20...21, 0.6...0.7, false), Res),
    equal(Res, 10.9999...15.0001).

test(pbinom1) :-
    interval(pbinom(10, 20, 0.6), Res),
    equal(Res, 0.2446...0.2447).

test(pbinom2) :-
    interval(pbinom(10...11, 20, 0.6), Res),
    equal(Res, 0.2446...0.4045).

test(pbinom3) :-
    interval(pbinom(10, 20...21, 0.6), Res),
    equal(Res, 0.1743...0.2447).

test(pbinom4) :-
    interval(pbinom(10, 20, 0.6...0.7), Res),
    equal(Res, 0.0479...0.2447).

test(pbinom5) :-
    interval(pbinom(10...11, 20...21, 0.6), Res),
    equal(Res, 0.1743...0.4045).

test(pbinom6) :-
    interval(pbinom(10...11, 20, 0.6...0.7), Res),
    equal(Res, 0.0479...0.4045).

test(pbinom7) :-
    interval(pbinom(10, 20...21, 0.6...0.7), Res),
    equal(Res, 0.0263...0.2447).

test(pbinom8) :-
    interval(pbinom(10...11, 20...21, 0.6...0.7), Res),
    equal(Res, 0.0263...0.4045).

test(pbinom9) :-
    interval(pbinom(10, 20, 0.6, true), Res),
    equal(Res, 0.2446...0.2447).

test(pbinom10) :-
    interval(pbinom(10, 20, 0.6, false), Res),
    equal(Res, 0.7553...0.7554).

test(pbinom11) :-
    interval(pbinom(10...12, 20, 0.6, true), Res),
    equal(Res, 0.2446...0.5842).

test(pbinom12) :-
    interval(pbinom(10...12, 20, 0.6, false), Res),
    equal(Res, 0.4158...0.7554).

test(pbinom13) :-
    interval(pbinom(10...12, 20...21, 0.6, true), Res),
    equal(Res, 0.1743...0.5842).

test(pbinom14) :-
    interval(pbinom(10...12, 20...21, 0.6, false), Res),
    equal(Res, 0.4158...0.8257).

test(pbinom15) :-
    interval(pbinom(10...12, 20, 0.6...0.7, true), Res),
    equal(Res, 0.0479...0.5842).

test(pbinom16) :-
    interval(pbinom(10...12, 20, 0.6...0.7, false), Res),
    equal(Res, 0.4158...0.9521).

test(pbinom17) :-
    interval(pbinom(10, 20...21, 0.6...0.7, true), Res),
    equal(Res, 0.0263...0.2447).

test(pbinom18) :-
    interval(pbinom(10, 20...21, 0.6...0.7, false), Res),
    equal(Res, 0.7553...0.9737).

test(pbinom18) :-
    interval(pbinom(10...12, 20...21, 0.6...0.7, true), Res),
    equal(Res, 0.0263...0.5842).

test(pbinom19) :-
    interval(pbinom(10...12, 20...21, 0.6...0.7, false), Res),
    equal(Res, 0.4158...0.9737).

:- end_tests(binom).

:- begin_tests(normal).

test(pnorm1) :-
    interval(pnorm(0.5), Res),
    equal(Res, 0.6914...0.6915).

test(pnorm2) :-
    interval(pnorm(0.5...0.7), Res),
    equal(Res, 0.6914...0.7581).

test(pnorm3) :-
    interval(pnorm(90, 100, 10), Res),
    equal(Res, 0.1586...0.1587).

test(pnorm4) :-
    interval(pnorm(90...92, 100, 10), Res),
    equal(Res, 0.1586...0.2119).

test(pnorm5) :-
    interval(pnorm(90, 100...102, 10), Res),
    equal(Res, 0.1150...0.1587).

test(pnorm6) :-
    interval(pnorm(90, 100, 10...12), Res),
    equal(Res, 0.1586...0.2024).

test(pnorm7) :-
    interval(pnorm(90...92, 100...102, 10), Res),
    equal(Res, 0.1150...0.2119).

test(pnorm8) :-
    interval(pnorm(90...92, 100, 10...11), Res),
    equal(Res, 0.1586...0.2336).

test(pnorm8) :-
    interval(pnorm(90, 100...102, 10...11), Res),
    equal(Res, 0.1150...0.1817).

test(pnorm9) :-
    interval(pnorm(90...91, 100...101, 10...11), Res),
    equal(Res, 0.1356...0.2067).

test(pnorm10) :-
    interval(pnorm(90, 100, 10, true), Res),
    equal(Res, 0.1586...0.1587).

test(pnorm11) :-
    interval(pnorm(90, 100, 10, false), Res),
    equal(Res, 0.8413...0.8414).

test(pnorm12) :-
    interval(pnorm(90...92, 100, 10, true), Res),
    equal(Res, 0.1586...0.2119).

test(pnorm13) :-
    interval(pnorm(90...92, 100, 10, false), Res),
    equal(Res, 0.7881...0.8414).

test(pnorm14) :-
    interval(pnorm(90, 100...102, 10, true), Res),
    equal(Res, 0.1150...0.1587).

test(pnorm15) :-
    interval(pnorm(90, 100...102, 10, false), Res),
    equal(Res, 0.8413...0.8850).

test(pnorm16) :-
    interval(pnorm(90, 100, 10...12, true), Res),
    equal(Res, 0.1586...0.2024).

test(pnorm17) :-
    interval(pnorm(90, 100, 10...12, false), Res),
    equal(Res, 0.7976...0.8414).

test(pnorm18) :-
    interval(pnorm(90...92, 100...102, 10, true), Res),
    equal(Res, 0.1150...0.2119).

test(pnorm19) :-
    interval(pnorm(90...92, 100...102, 10, false), Res),
    equal(Res, 0.7881...0.8850).

test(pnorm20) :-
    interval(pnorm(90...92, 100, 10...11, true), Res),
    equal(Res, 0.1586...0.2336).

test(pnorm21) :-
    interval(pnorm(90...92, 100, 10...11, false), Res),
    equal(Res, 0.7664...0.8414).

test(pnorm22) :-
    interval(pnorm(90, 100...102, 10...11, true), Res),
    equal(Res, 0.1150...0.1817).

test(pnorm23) :-
    interval(pnorm(90, 100...102, 10...11, false), Res),
    equal(Res, 0.8183...0.8850).

test(pnorm24) :-
    interval(pnorm(90...91, 100...101, 10...11, true), Res),
    equal(Res, 0.1356...0.2067).

test(pnorm25) :-
    interval(pnorm(90...91, 100...101, 10...11, false), Res),
    equal(Res, 0.7933...0.8644).

test(qnorm1) :-
    interval(qnorm(0.6), Res),
    equal(Res, 0.2533...0.2534).

test(qnorm2) :-
    interval(qnorm(0.6...0.7), Res),
    equal(Res, 0.2533...0.5245).

test(qnorm3) :-
    interval(qnorm(0.6, 100, 10), Res),
    equal(Res, 102.5334...102.5335).

test(qnorm4) :-
    interval(qnorm(0.6...0.8, 100, 10), Res),
    equal(Res, 102.5334...108.4163).

test(qnorm5) :-
    interval(qnorm(0.6, 100...101, 10), Res),
    equal(Res, 102.5334...103.5335).

test(qnorm6) :-
    interval(qnorm(0.6, 100, 10...11), Res),
    equal(Res, 102.5334...102.7869).

test(qnorm7) :-
    interval(qnorm(0.6...0.8, 100...101, 10), Res),
    equal(Res, 102.5334...109.4163).

test(qnorm8) :-
    interval(qnorm(0.6...0.8, 100, 10...11), Res),
    equal(Res, 102.5334...109.2579).

test(qnorm9) :-
    interval(qnorm(0.6...0.7, 100...101, 10...11), Res),
    equal(Res, 102.5334...106.7685).

test(qnorm10) :-
    interval(qnorm(0.6, 100, 10, true), Res),
    equal(Res, 102.5334...102.5335).

test(qnorm11) :-
    interval(qnorm(0.6, 100, 10, false), Res),
    equal(Res, 97.4665...97.4666).

test(qnorm12) :-
    interval(qnorm(0.6...0.8, 100, 10, true), Res),
    equal(Res, 102.5334...108.4163).

test(qnorm13) :-
    interval(qnorm(0.6...0.8, 100, 10, false), Res),
    equal(Res, 91.5837...97.4666).

test(qnorm14) :-
    interval(qnorm(0.6, 100...101, 10, true), Res),
    equal(Res, 102.5334...103.5335).

test(qnorm15) :-
    interval(qnorm(0.6, 100...101, 10, false), Res),
    equal(Res, 97.4665...98.4666).

test(qnorm16) :-
    interval(qnorm(0.6, 100, 10...11, true), Res),
    equal(Res, 102.5334...102.7869).

test(qnorm17) :-
    interval(qnorm(0.6, 100, 10...11, false), Res),
    equal(Res, 97.2131...97.4666).

test(qnorm18) :-
    interval(qnorm(0.6...0.8, 100...101, 10, true), Res),
    equal(Res, 102.5334...109.4163).

test(qnorm19) :-
    interval(qnorm(0.6...0.8, 100...101, 10, false), Res),
    equal(Res, 91.5837...98.4666).

test(qnorm20) :-
    interval(qnorm(0.6...0.8, 100, 10...11, true), Res),
    equal(Res, 102.5334...109.2579).

test(qnorm21) :-
    interval(qnorm(0.6...0.8, 100, 10...11, false), Res),
    equal(Res, 90.7421...97.4666).

test(qnorm22) :-
    interval(qnorm(0.6...0.7, 100...101, 10...11, true), Res),
    equal(Res, 102.5334...106.7685).

test(qnorm23) :-
    interval(qnorm(0.6...0.7, 100...101, 10...11, false), Res),
    equal(Res, 94.2315...98.4666).

test(dnorm1) :-
    interval(dnorm(0.5), Res),
    equal(Res, 0.3520...0.3521).

test(dnorm2) :-
    interval(dnorm(0.5...0.6), Res),
    equal(Res, 0.3332...0.3521).

test(dnorm3) :-
    interval(dnorm(90, 100, 10), Res),
    equal(Res, 0.0241...0.0242).

test(dnorm4) :-
    interval(dnorm(90...92, 100, 10), Res),
    equal(Res, 0.0241...0.029).

test(dnorm5) :-
    interval(dnorm(90, 100...102, 10), Res),
    equal(Res, 0.0194...0.0242).

test(dnorm6) :-
    interval(dnorm(90, 100, 10...12), Res),
    equal(Res, 0.0201...0.0282).

test(dnorm7) :-
    interval(dnorm(90...92, 100...102, 10), Res),
    equal(Res, 0.0194...0.029).

test(dnorm8) :-
    interval(dnorm(90...92, 100, 10...11), Res),
    equal(Res, 0.0219...0.0307).

test(dnorm9) :-
    interval(dnorm(90, 100...102, 10...11), Res),
    equal(Res, 0.0176...0.0264).

test(dnorm10) :-
    interval(dnorm(90...91, 100...101, 10...11), Res),
    equal(Res, 0.0198...0.0286).

test(dnorm11) :-
    interval(dnorm(110...111, 100...101, 10...11), Res),
    equal(Res, 0.0198...0.0286).

test(dnorm12) :-
    interval(dnorm(99...102, 100...101, 10...11), Res),
    equal(Res, 0.0355...0.0399).

:- end_tests(normal).

:- begin_tests(t).

test(pt1) :-
    interval(pt(-0.5, 5), Res),
    equal(Res, 0.3191...0.3192).

test(pt2) :-
    interval(pt(-0.5... -0.2, 5), Res),
    equal(Res, 0.3191...0.4247).

test(pt3) :-
    interval(pt(-0.5, 5...6), Res),
    equal(Res, 0.3191...0.3175).

test(pt4) :-
    interval(pt(-0.5... -0.2, 5...6), Res),
    equal(Res, 0.3191...0.4241).

test(pt5) :-
    interval(pt(-0.5, 5, true), Res),
    equal(Res, 0.3191...0.3192).

test(pt6) :-
    interval(pt(-0.5, 5, false), Res),
    equal(Res, 0.6808...0.6809).

test(pt7) :-
    interval(pt(-0.5... -0.2, 5, true), Res),
    equal(Res, 0.3191...0.4247).

test(pt8) :-
    interval(pt(-0.5... -0.2, 5, false), Res),
    equal(Res, 0.5753...0.6809).

test(pt9) :-
    interval(pt(-0.5, 5...6, true), Res),
    equal(Res, 0.3174...0.3192).

test(pt10) :-
    interval(pt(-0.5, 5...6, false), Res),
    equal(Res, 0.6808...0.6826).

test(pt11) :-
    interval(pt(-0.5... -0.2, 5...6, true), Res),
    equal(Res, 0.3174...0.4247).

test(pt12) :-
    interval(pt(0.5...1, 2...5, false), Res),
    equal(Res, 0.1816...0.3334).

test(pt13) :-
    interval(pt(-0.5...0.2, 2...5, true), Res),
    equal(Res, 0.4999...0.6809).

test(pt14) :-
    interval(pt(-0.5...0.2, 2...5, false), Res),
    equal(Res, 0.3191...0.5001).

test(qt1) :-
    interval(qt(0.4, 5), Res),
    equal(Res, -0.2672... -0.2671).

test(qt2) :-
    interval(qt(0.4...0.7, 5), Res),
    equal(Res, -0.2672...0.5595).

test(qt3) :-
    interval(qt(0.4, 5...6), Res),
    equal(Res, -0.2672... -0.2648).

test(qt4) :-
    interval(qt(0.4...0.7, 2...5), Res),
    equal(Res, -0.2887...0.5595).

test(qt5) :-
    interval(qt(0.4, 5, true), Res),
    equal(Res, -0.2672... -0.2671).

test(qt6) :-
    interval(qt(0.6, 5, true), Res),
    equal(Res, 0.2671... 0.2672).

test(qt6) :-
    interval(qt(0.4, 5, false), Res),
    equal(Res, 0.2671...0.2672).

test(qt7) :-
    interval(qt(0.6, 5, false), Res),
    equal(Res, -0.2672... -0.2671).

test(qt8) :-
    interval(qt(0.3...0.4, 5, true), Res),
    equal(Res, -0.5595... -0.2671).

test(qt9) :-
    interval(qt(0.6...0.7, 5, true), Res),
    equal(Res, 0.2671... 0.5595).

test(qt10) :-
    interval(qt(0.4...0.7, 5, true), Res),
    equal(Res, -0.2672...0.5595).

test(qt11) :-
    interval(qt(0.3...0.4, 5, false), Res),
    equal(Res, 0.2671...0.5595).

test(qt12) :-
    interval(qt(0.6...0.7, 5, false), Res),
    equal(Res, -0.5595... -0.2671).

test(qt13) :-
    interval(qt(0.4...0.7, 5, false), Res),
    equal(Res, -0.5595...0.2672).

test(qt14) :-
    interval(qt(0.4, 5...6, true), Res),
    equal(Res, -0.2672... -0.2648).

test(qt15) :-
    interval(qt(0.6, 5...6, true), Res),
    equal(Res, 0.2648...0.2672).

test(qt16) :-
    interval(qt(0.4, 5...6, false), Res),
    equal(Res, 0.2648...0.2672).

test(qt17) :-
    interval(qt(0.6, 5...6, false), Res),
    equal(Res, -0.2672... -0.2648).

test(qt18) :-
    interval(qt(0.4...0.7, 2...5, true), Res),
    equal(Res, -0.2887...0.5595).

test(qt19) :-
    interval(qt(0.4...0.7, 2...5, false), Res),
    equal(Res, -0.5595...0.2887).

test(dt1) :-
    interval(dt(-0.5, 5), Res),
    equal(Res, 0.3279...0.3280).

test(dt2) :-
    interval(dt(-0.5... -0.4, 5), Res),
    equal(Res, 0.3279...0.3454).

test(dt3) :-
    interval(dt(0.4...0.5, 5), Res),
    equal(Res, 0.3279...0.3454).

test(dt4) :-
    interval(dt(-0.4... 0.5, 5), Res),
    equal(Res, 0.3279...0.3797).

test(dt5) :-
    interval(dt(-0.5, 5...6), Res),
    equal(Res, 0.3279...0.3318).

test(dt6) :-
    interval(dt(0.4, 5...6), Res),
    equal(Res, 0.3453...0.3491).

test(dt7) :-
    interval(dt(-0.5... -0.4, 5...6), Res),
    equal(Res, 0.3279...0.3491).

test(dt8) :-
    interval(dt(0.4...0.5, 5...6), Res),
    equal(Res, 0.3279...0.3491).

test(dt9) :-
    interval(dt(-0.4... 0.5, 5...6), Res),
    equal(Res, 0.3279...0.3828).

:- end_tests(t).

:- begin_tests(chisq).

test(pchisq1) :-
    interval(pchisq(0.3, 5), Res),
    equal(Res, 0.0023...0.0024).

test(pchisq2) :-
    interval(pchisq(0.3...0.4, 5), Res),
    equal(Res, 0.0023...0.0047).

test(pchisq3) :-
    interval(pchisq(0.3, 5, true), Res),
    equal(Res, 0.0023...0.0024).

test(pchisq4) :-
    interval(pchisq(0.3, 5, false), Res),
    equal(Res, 0.9976...0.9977).

test(pchisq5) :-
    interval(pchisq(0.3...0.4, 5, true), Res),
    equal(Res, 0.0023...0.0047).

test(pchisq6) :-
    interval(pchisq(0.3...0.4, 5, false), Res),
    equal(Res, 0.9953...0.9977).

test(pchisq7) :-
    interval(pchisq(0.3, 5...6, true), Res),
    equal(Res, 0.0005...0.0024).

test(pchisq8) :-
    interval(pchisq(0.3, 5...6, false), Res),
    equal(Res, 0.9976...0.9995).

test(pchisq9) :-
    interval(pchisq(0.3...0.4, 5...6, true), Res),
    equal(Res, 0.0005...0.0047).

test(pchisq10) :-
    interval(pchisq(0.3...0.4, 5...6, false), Res),
    equal(Res, 0.9953...0.9995).

test(qchisq1) :-
    interval(qchisq(0.3, 5), Res),
    equal(Res, 2.9999...3).

test(qchisq2) :-
    interval(qchisq(0.3...0.4, 5), Res),
    equal(Res, 2.9999...3.6555).

test(qchisq3) :-
    interval(qchisq(0.3, 5, true), Res),
    equal(Res, 2.9999...3).

test(qchisq4) :-
    interval(qchisq(0.3, 5, false), Res),
    equal(Res, 6.0644...6.0645).

test(qchisq5) :-
    interval(qchisq(0.3...0.4, 5, true), Res),
    equal(Res, 2.9999...3.6555).
    
test(qchisq6) :-
    interval(qchisq(0.3...0.4, 5, false), Res),
    equal(Res, 5.1318...6.0645).

test(qchisq7) :-
    interval(qchisq(0.3, 5...6, true), Res),
    equal(Res, 2.9999...3.8276).

test(qchisq8) :-
    interval(qchisq(0.3, 5...6, false), Res),
    equal(Res, 6.0644...7.2312).

test(qchisq9) :-
    interval(qchisq(0.3...0.4, 5...6, true), Res),
    equal(Res, 2.9999...4.5702).

test(qchisq10) :-
    interval(qchisq(0.3...0.4, 5...6, false), Res),
    equal(Res, 5.1318...7.2312).

test(dchisq1) :-
    interval(dchisq(0.3, 2), Res),
    equal(Res, 0.4303...0.4304).

test(dchisq2) :-
    interval(dchisq(0.3...0.4, 2), Res),
    equal(Res, 0.4093...0.4304).

test(dchisq3) :-
    interval(dchisq(1.3...1.4, 4), Res),
    equal(Res, 0.1696...0.1739).

test(dchisq4) :-
    interval(dchisq(1.3...1.4, 3), Res),
    equal(Res, 0.2344...0.2375).

test(dchisq5) :-
    interval(dchisq(0.9...1.1, 3), Res),
    equal(Res, 0.2413...0.2420).

test(dchisq6) :-
    interval(dchisq(0.3, 1...2), Res),
    equal(Res, 0.4303...0.6270).

test(dchisq7) :-
    interval(dchisq(0.3, 3...4), Res),
    equal(Res, 0.0645...0.1881).

test(dchisq8) :-
    interval(dchisq(1.1, 2...3), Res),
    equal(Res, 0.2414...0.2885).

test(dchisq9) :-
    interval(dchisq(0.9...1.1, 2...3), Res),
    equal(Res, 0.2413...0.5001).

:- end_tests(chisq).

% Helper predicate to check equality
equal(Res0, Res) :-
    interval(round(Res0, 4), Res).