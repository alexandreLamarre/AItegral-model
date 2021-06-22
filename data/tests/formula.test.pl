# non relative imports from /usr/bin/perl
use strict;
use warnings;
use FindBin;
use Test;

BEGIN{plan tests => 10, todo => []}

# relative imports from this directory
use lib "$FindBin::RealBin/../Expr";
use Formula;

ok(Formula::testLoad(), 1);

# ======= "static" function tests =============

my ($plus, $minus, $times, $div) = ("\+", "-", "\*", "/");
my @operatorRes = Formula::getOperators();

ok($operatorRes[0], $plus);
ok($operatorRes[1], $minus);
ok($operatorRes[2], $times);
ok($operatorRes[3], $div);

# ========== OOP tests =================
ok(Formula::getOperatorsRegex, "(".$plus."|".$minus."|".$times."|".$div.")");
my $f = Formula::new Formula("ab","c","a*b+c");
ok($f);
ok($f->getVars, "ab");
ok($f->getConsts, "c");
ok($f->getData, "a*b+c");
