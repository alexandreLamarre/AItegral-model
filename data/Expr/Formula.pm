=head1 Formula

    Formula package : a package for encapsulating data and functions
    related to symbolic formulas and their manipulation.

=cut

package Formula;
# non relative imports from /usr/bin/perl
use strict;
use warnings;
# relative imports from current directory

sub testLoad{
    print "Formula package successfully loaded!\n";
    return 1;
}

=head1 Formula
    Constructor for formula object:
    @param class Object<Name>: the class name
    @param data <String>: the formula
=cut
sub new {
    my $class = shift();
    my $vars = shift();
    my $consts = shift();
    my $data = shift();
    my $nesting = shift();
    if(!defined($vars) || !defined($consts) || !defined($data)){
        die "Expected defined vars,consts and data for Formula Object\n";
    }
    if(! defined($nesting)){
        $nesting = 1;
    }
    my $self = {
        _vars => $vars,
        _consts => $consts,
        _data => $data,
        _nesting => $nesting
    };

    bless $self, $class;
    return $self;
}

=head1 getVars
    Method for formula object that returns the variables for the formula
    @returns <String>: variables in the formula object
=cut
sub getVars{
    my ($self) = @_;
    return $self ->{_vars};
}

=head1 getConsts
    Method for formula object that returns the constants for the formula
    @returns <String>: constants in the formula object
=cut
sub getConsts{
    my ($self) = @_;
    return $self -> {_consts};
}

=head1 getData
    Method for formula object that returns the "data" for the formula
    @returns <String>: the actual symbolic information of 
=cut
sub getData{
    my ($self) = @_;
    return $self -> {_data};
}

=head1 getNesting
    Method for formula object that returns the nesting parameter of
    the formula. Useful as a hyperparameter.
=cut
sub getNesting{
    my ($self) = @_;
    return $self -> {_nesting};
}

=head1 isValid
    Method for formula object that checks if the formula is indeed valid,
    according to the following criteria:
        - No two consecutive variable/constants
        - No alphabetical strings that don't match builtin functions
        - 
    @returns <bool> : True if formula is valid OR False is formula is invalid
=cut
sub isValid{
    my ($self) = @_;
    #TODO: IMPLEMENT using symbolic operator stacks
    return 0;
}


#=========== "static" package functions ==============

=head1 getOperators
    returns valid operators for symbolic formulas
    @returns Array<String> : valid operators for symbolic formulas
=cut
sub getOperators{
    return ("\+", "-", "\*", "/"); # '^'' is excluded from this since it can also produce 
                #complex functions, and should be considered a function not an operator 
}

=head1 getOperatorsRegex
    Returns the valid operators as regex matcher string
    @returns regex <String> : 
=cut
sub getOperatorsRegex{
    return "(\+|-|\*|/|\^)"; # $ is included here since we want to match valid operators, 
                    # and it is difficult to integrate it with standardFuncsRegex subroutine.
}

=head1 getStandardFuncs
    Gets all standard mathematical functions that are used in integrals
    @param n int: nesting factor placeholder, starting at 1 
                  (For later use when generating random formulas)
    @returns <Array> : contains all the symbolic elementary functions with placeholder '__vars$n__'
=cut
sub getStandardFuncs{
    my $n = shift();
    if(!defined($n) || $n <= 0){
        $n = 1;
    }
    my $p = "\_\_VAR$n\_\_"; 
    # (polynomials/exponentials, roots, sin, cos, tan, log,
    #  arccos, arcsin, arctan, 
    #  sec, csc, cot
    #  arcsec, arccsc, arccot
    #  sinh, cosh, tanh,
    #  sech, cosh, tanh,
    #  arcsinh, arccosh, arctanh,
    #  arcsech, arccsch, arccoth)
    my @funcs = ("$p\^\($p\)", "$p\^\(1\/$p\)", "sin\($p\)", "cos\($p\)", "tan\($p\)", "log\($p\)",
                "arcsin\($p\)", "arccos\($p\)", "arctan\($p\)",
                "sec\($p\)", "csc\($p\)", "cot\($p\)",
                "arcsec\($p\)", "arccsc\($p\)", "arccot\($p\)",
                "sinh\($p\)", "cosh\($p\)", "tanh\($p\)",
                "sech\($p\)", "csch\($p\)", "coth\($p\)",
                "arcsinh\($p\)", "arccosh\($p\)", "arctanh\($p\)",
                "arcsech\($p\)", "arccsch\($p\)", "arccoth\($p\)");
}

=head1 getStandardFuncsRegex
    Used for matching valid 'string' symbolic functions so it excludes ^ exponentionation operator. 
    This operator is included in getOperatorsRegex
    @returns regexMatching <string> : matches 'string' symbolic functions used in Aitegral
=cut
sub getStandardFuncsRegex{
    return "(sin|cos|tan|log|arcsin|arccos|arctan|sec|csc|cot|arcsec|arccsc|arccot|sinh|cosh|tanh|arcsinh|arccosh|arctanh|arcsech|arccsch|arccoth)";
}

1;

=head1 Author(s)
    Alexandre Lamarre
=cut