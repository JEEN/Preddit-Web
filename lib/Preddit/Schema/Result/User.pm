use utf8;
package Preddit::Schema::Result::User;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Preddit::Schema::Result::User

=cut

use strict;
use warnings;

=head1 BASE CLASS: L<Preddit::Schema::ResultBase>

=cut

use Moose;
use MooseX::NonMoose;
use namespace::autoclean;
extends 'Preddit::Schema::ResultBase';

=head1 TABLE: C<user>

=cut

__PACKAGE__->table("user");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 email

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 1
  size: 128

=head2 passwd

  data_type: 'varchar'
  default_value: (empty string)
  encode_args: {algorithm => "SHA-1",format => "hex"}
  encode_check_method: 'check_password'
  encode_class: 'Digest'
  encode_column: 1
  is_nullable: 0
  size: 64

=head2 name

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 64

=head2 creaed_at

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  default_value: '0000-00-00 00:00:00'
  is_nullable: 0

=head2 updated_at

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  default_value: '0000-00-00 00:00:00'
  inflate_datetime: 1
  is_nullable: 0
  set_on_create: 1
  set_on_update: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "email",
  { data_type => "varchar", default_value => "", is_nullable => 1, size => 128 },
  "passwd",
  {
    data_type           => "varchar",
    default_value       => "",
    encode_args         => { algorithm => "SHA-1", format => "hex" },
    encode_check_method => "check_password",
    encode_class        => "Digest",
    encode_column       => 1,
    is_nullable         => 0,
    size                => 64,
  },
  "name",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 64 },
  "creaed_at",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    default_value => "0000-00-00 00:00:00",
    is_nullable => 0,
  },
  "updated_at",
  {
    data_type                 => "datetime",
    datetime_undef_if_invalid => 1,
    default_value             => "0000-00-00 00:00:00",
    inflate_datetime          => 1,
    is_nullable               => 0,
    set_on_create             => 1,
    set_on_update             => 1,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07033 @ 2012-12-07 23:27:25
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:aj83/rCVH6wmVU6n663Rcg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
