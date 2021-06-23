# non relative imports from /usr/bin/perl
use strict;
use warnings;
use FindBin;
use Test;

BEGIN{plan tests => 17, todo => []}

# relative imports from this directory
use lib "$FindBin::RealBin/../Expr";
use Formula;

=head1 Test suite 0: Loading package
    (1). Load the Formula package
=cut

=head1 Test suite 1: Symbolic operators static functions
    (2)-(5). getOperators tests
    (6). getOperatorsRegex test
=cut

=head1 Test suite 2: Formula object tests 
    (7) Constructor test
    (8)-(14). Getter method tests 
=cut

=head1 Test suite 3: Symbolic elementary functions

    (15). getStandardFuncsRegex test
    (16) getStandardFuncs test

=cut

# ========== LOAD test ===========
#(1)
ok(Formula::testLoad(), 1);

# =========== SYMBOLIC operator test =========
my ($plus, $minus, $times, $div) = ("\+", "-", "\*", "/");
my @operatorRes = Formula::getOperators();

ok($operatorRes[0], $plus); #(2)
ok($operatorRes[1], $minus); #(3)
ok($operatorRes[2], $times); #(4)
ok($operatorRes[3], $div); #(5)
ok(Formula::getOperatorsRegex, "(".$plus."|".$minus."|".$times."|".$div."|\^)"); #(6)

# ========== Formula Object tests =================

my $f = Formula::new Formula("ab","c","a*b+c");
ok($f); #(7)
ok($f->getVars, "ab"); #(8)
ok($f->getConsts, "c"); #(9)
ok($f->getData, "a*b+c"); #(10)
ok($f->getNesting, 1); #(11)
my$f1 = Formula::new Formula("ab", "c", "a*b+c", 3);
ok($f1->getNesting, 3); #(12)

ok($f->_getVarsRegex(), "(a|b)"); #(13)
ok($f->_getConstsRegex(), "(c)"); #(14)
my $passed = 1;
my $funcsRegex = Formula::getStandardFuncsRegex();
my @testCases = ("sin", "cos","log","arccos","arcsin","tan","arctan","sec","csc","cot","arcsec",
                "arccsc","arccot","sinh","cosh","tanh","sech","csch","coth","arcsinh","arccosh",
                "arctanh","arcsech","arccsch","arccoth)");
foreach my $testVar (@testCases){
    if(!$testVar =~ m/$funcsRegex/){
        $passed = 0;
        print "$testVar failed getStandardFuncsRegex match\n";
    }
}
ok($passed, 1); #(15)
ok(Formula::getStandardFuncs(14)); #TODO: make non lazy test for this (16)

=head1 Author(s)
    Alexandre Lamarre
=cut
