package Preddit::API;
use Moose;
use namespace::autoclean;
use Preddit::Schema;
use Module::Find ();
with qw/Preddit::Trait::WithAPI Preddit::Trait::WithDBIC/;

sub _build_schema {
    my $self = shift;

    Preddit::Schema->connect( $self->connect_info );
}

sub _build_apis {
    my $self = shift;

    my %apis;

    for my $class (Module::Find::findsubmod(__PACKAGE__)) {
        my ($name) = $class =~ /::([A-Za-z_]+)$/;

        if (!Class::MOP::is_class_loaded($class)) {
            Class::MOP::load_class($class);
        }   
        $apis{$name} = $class->new( schema => $self->schema );
    }

    return \%apis;
}

1;
