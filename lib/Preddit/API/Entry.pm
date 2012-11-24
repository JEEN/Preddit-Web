package Preddit::API::Entry;
use Moose;
use namespace::autoclean;
with qw/Preddit::Trait::WithDBIC/;

sub find_entry {
    my ( $self, $args ) = @_;

    $self->resultset('Entry')->find($args);
}

sub get_entries {
    my ( $self, $args ) = @_;

    [ $self->resultset('Entry')->search($args)->all ];
}

sub update {
    my ( $self, $args ) = @_;

    $self->resultset('Entry')->update_or_create({
        title => $args->{title},
        description => $args->{description},
    });
}

__PACKAGE__->meta->make_immutable;

1;