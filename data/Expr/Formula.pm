package Expr::Formula;
use Exporter 'import';
our @EXPORT_OK = qw(new, getOperators);

=head1 NAME

    Expr::Formula - A module for encapsulating formula data

=head1 SYNOPSIS

    This module defines an Expr::Formula class for encapsulating
    symbolic mathematical formulas as strings

=cut

=head1 Formula

    Constructor for formula object:
    @param 0: the class name
    @param 1: the formula

=cut
sub new {
    my $class = @_[0];
    my $self = {
        _data = @_[1];
    };

    bless $self $class;
    return $self;
}

=head1 getOperators

    Returns the mathematical operators that can be
    used in a formula.

=cut
sub getOperators{
    return ("+", "-", "/", "*"); 
}

1;

