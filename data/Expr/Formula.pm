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
    my $self = {
        _vars => shift(),
        _consts => shift(),
        _data => shift()
    };

    bless $self, $class;
    return $self;
}

=head1 getVars
    Method for formula object that returns the variables for the formula
    @returns String: variables in the formula object
=cut
sub getVars{
    my ($self) = @_;
    return $self ->{_vars};
}

=head1 getConsts
    Method for formula object that returns the constants for the formula
    @returns String: constants in the formula object
=cut
sub getConsts{
    my ($self) = @_;
    return $self -> {_consts};
}

=head1 getData
    Method for formula object that returns the "data" for the formula
    @returns String: the actual symbolic information of 
=cut
sub getData{
    my ($self) = @_;
    return $self -> {_data};
}

=head1 isValid
    Method for formula object that checks if the formula is indeed valid,
    according to the following criteria:
        - No two consecutive variable/constants
        - No alphabetical strings that don't match builtin functions
        - 
    @returns bool : True if formula is valid OR False is formula is invalid
=cut
sub isValid{
    my ($self) = @_;
    #TODO: IMPLEMENT
    return 0;
}


#=========== "static" package functions ==============

=head1 getOperators
    returns valid operators for symbolic formulas
    @returns Array<String> : valid operators for symbolic formulas
=cut
sub getOperators{
    return ("\+", "-", "\*", "/"); 
}

=head1 getOperatorsRegex
    Returns the valid operators as regex matcher string
    @returns regex String : 
=cut
sub getOperatorsRegex{
    return "(\+|-|\*|/)";
}

=head1 getStandardFuncs
    Gets all standard mathematical functions that are used in integrals
    @param n int: nesting factor placeholder, starting at 1 
                  (For later use when generating random formulas)
=cut
sub getStandardFuncs{
    my $n = shift();
    if(!defined($n) || $n <= 0){
        $n = 1;
    }
    my $p = "\_\_VAR$n\_\_"; 
    #TODO: return array of standard functions
}

=head1 getStandardFuncsRegex

=cut
sub getStandardFuncsRegex{
    #TODO: return regex matcher of standard functions
}

1;

=head1 Author
    Alexandre Lamarre
=cut