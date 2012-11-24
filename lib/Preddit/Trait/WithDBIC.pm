package Preddit::Trait::WithDBIC;
use Moose::Role;
use namespace::autoclean;

has schema => (
    is => 'ro',
    lazy_build => 1,
    handles => {
        txn_guard => 'txn_scope_guard',
        resultset => 'resultset',
    }
);

has connect_info => (
    is => 'ro',
    isa => 'HashRef',
);

no Moose::Role;

1;