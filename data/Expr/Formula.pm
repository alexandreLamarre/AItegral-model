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
    @returns <bool> : True if formula is valid OR False if formula is invalid
=cut
sub isValid{
    my ($self) = @_;
    #TODO: IMPLEMENT using symbolic operator stacks
    my $stackIndex = 0;
    my $curFormula = $self->getData();


    my @stack = ();
    # my $temp = $curFormula =~ "(.*)\("; # extract anything before parentheses
    # if(length($temp) eq length($curFormula)){ #there are no parentheses so formula has nesting 1
    #     return _isValidSubformula($curFormula);
    # }
    my $temp = "";
    if($curFormula =~ /(.*)\(/){
        my $temp = $1;
    } else{ #only one level of nesting
        return _isValidSubformula($curFormula);
    }

    push (@stack, $temp);
    $stackIndex ++; #use to track the current stack index
    # now we have one open parantheses.
    $curFormula = substr($curFormula, length($temp));

    while($curFormula ne ""){
        my $newOpen = "";
        my $newClose = "";
        #check next parenthesis type
        if($curFormula =~ /(.*)\(/){
            $newOpen = $1;
        }
        if($curFormula =~ /(.*)\)/){
            $newClose = $1;
        }

        # handle no more parentheses to match, i.e. left over formula after nesting
        if($newOpen eq "" && $newClose eq ""){
          if($stackIndex ne 1){
            print "Mismatched parentheses : unmatched open parentheses";
            return 0;
          } else{
            $stack[0] .= "\|" . $temp;
            last; #perl's syntax for break
          }
        }

        if(length($newOpen) < length($newClose)){#new open parentheses
            $temp = $newOpen;
            if($stackIndex == $stack){ # new nesting
                push(@stack, $temp);
            } else{ #append to existing nesting level
                $stack[$stackIndex - 1] .= "\|" . $temp;
            }
            $stackIndex ++;
        } else{ #new closed parentheses
            $temp = $newClose;
            if($stackIndex <= 0){
                print "Mismatched parentheses : not enough open parentheses\n";
                return 0;
            }
            @stack[$stackIndex -1] .= "\|" . $temp;
            $stackIndex --;
        }
        #trim formula with previously matched string
        $curFormula = substr($curFormula , length($temp));
    }

    if($stackIndex){
        print "Mismatched parentheses : not enough closed parentheses \n";
        return 0;
    }

    #now check each subformula is correct
    foreach my $subFormula (@stack){
        if(!_isValidSubFormula($subFormula, $self->getVarsRegex(), $self->getConstsRegex())){
          return 0;
        }
    }

    return 1; #each subformula at each nesting level was found to be valid

}

=head1 _isValidSubFormula
    subFormulas cannot have
    - two adjacent operators of the same type :
        `++` is invalid and so is `//` but `*+` or `*-` is valid
    - two adjacent variables/constants/elemetary functions:
        `logsin is invalid`, `aa` where a is a variable is invalid,
        `ac` where a is a variable and c is a constant is invalid.
=cut
sub _isValidSubformula{
    my ($subFormula, $varsRegex, $constRegex) = @_;
    if(!defined($subFormula)){
      return 0; # no subFormula passed, which means either error or invalid
                # formula nesting.
    }
    if(!defined($varsRegex) || $varsRegex eq ""){
      return 0; # no variables passed which means either error or or invalid
                # in our data generation having no starting variables would be pointless.
    }

    # $hasConsts variable used to track whether or not to use constsRegex expression.
    my $hasConsts = 1;
    if(!defined($constsRegex) || $constsRegex eq ""){
      $hasConsts = 0;
    }

    #TODO : split around operators and for loop.
    #split over high precedence operators \* and \/ first
    # any whitespace means sequential operators, which is not allowed.


    #TODO: then split by \+ operator, again whitespace means sequential
    #operators which is not allowed

    #TODO: then parse each individually checking for mistakes. -- is allowed.
    # handle the cases where there is new nesting.
    # elementary functions must be followed by nesting.
    # if not preceded by functions, nesting must be preceded by an operator or be
    # at the start of the formula
    # nesting must be followed by nothing OR an operator 
}

=head1 _checkTerm

=cut
sub _checkTerm{
  my ($curFormula,$hasVars)
}


sub _getVarsRegex{
    my ($self) = @_;
    my $variables = $self->getVars();
    if(length($variables) == 0){
      return "";
    }
    my $regGroup = "(";
    for(my $i = 0; $i < length($variables); $i++){
        if($regGroup ne "("){
            $regGroup.= "|";
        }
        $regGroup.= substr($variables, $i, 1);
    }
    $regGroup .= ")";
    return "(\-)?".$regGroup;
}

sub _getConstsRegex{
    my ($self) = @_;
    my $consts = $self->getConsts();
    if(length($consts) == 0){
      return "";
    }
    my $regGroup = "(";
    for(my $i = 0; $i < length($consts); $i++){
        if($regGroup ne "("){
            $regGroup.="|";
        }
        $regGroup .= substr($consts, $i, 1);
    }
    $regGroup .= ")";
    return "(\-)?".$regGroup;
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
    This operator is included in getOperatorsRegex.
    Includes the operator '-'.
    @returns regexMatching <string> : matches 'string' symbolic functions used in Aitegral
=cut
sub getStandardFuncsRegex{
    return "(\-)?(sin|cos|tan|log|arcsin|arccos|arctan|sec|csc|cot|arcsec|arccsc|arccot|sinh|cosh|tanh|arcsinh|arccosh|arctanh|arcsech|arccsch|arccoth)";
}

1;

=head1 Author(s)
    Alexandre Lamarre
=cut
