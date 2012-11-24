package Preddit::Schema::ResultBase;
use Moose;
use MooseX::NonMoose;
use namespace::autoclean;

extends 'DBIx::Class::Core';

__PACKAGE__->load_components(qw/
    EncodedColumn
    InflateColumn::Serializer
    InflateColumn::DateTime
    TimeStamp
/);

__PACKAGE__->meta->make_immutable;

1;