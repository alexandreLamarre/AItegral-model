package Shape;

sub new {     # constructor
   my $class = shift;
   my $self = {
   # member variables 
      name  => shift,
      sides => shift,
   };
   
   bless $self, $class;
   return $self;
}


sub Description {
  my ($self) = @_;
  print "A $self->{name} has $self->{sides} sides.";
}

sub setname {
   my ($self, $value) = @_;
   $self->{name} = $value; 
   return $self->{name};
}

sub setsides {
   my ($self, $value) = @_;
   $self->{sides} = $value; 
   return $self->{sides};
}
1;

$Square = new Shape("square", 4);
$Square->Description();

$Square->setname("Triangle");
$Square->setsides("3");
$Square->Description();

