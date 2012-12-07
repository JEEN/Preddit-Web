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

    [ $self->resultset('Entry')->search($args, { order_by => { -desc => 'updated_at' } })->all ];
}

sub update {
    my ( $self, $args ) = @_;

    my %row = map { $_ => $args->{$_} } grep { defined $args->{$_} } qw/id title description user_id/; 
    my $r = $self->resultset('Entry')->update_or_create(\%row);
    $r->ext_content($args->{ext_content}) if $args->{ext_content};
    $r->update;
}

__PACKAGE__->meta->make_immutable;

1;