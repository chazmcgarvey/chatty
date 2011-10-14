package Chatty::Schema::Result::Message;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use namespace::autoclean;
extends 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp");

=head1 NAME

Chatty::Schema::Result::Message

=cut

__PACKAGE__->table("message");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 posted

  data_type: 'timestamp'
  default_value: NOW
  is_nullable: 1

=head2 author

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 room

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 content

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "posted",
  { data_type => "timestamp", default_value => \"NOW", is_nullable => 1 },
  "author",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "room",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "content",
  { data_type => "text", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 room

Type: belongs_to

Related object: L<Chatty::Schema::Result::Room>

=cut

__PACKAGE__->belongs_to(
  "room",
  "Chatty::Schema::Result::Room",
  { id => "room" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);

=head2 author

Type: belongs_to

Related object: L<Chatty::Schema::Result::Account>

=cut

__PACKAGE__->belongs_to(
  "author",
  "Chatty::Schema::Result::Account",
  { id => "author" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2011-10-13 18:47:53
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:q1cq2bWftQPoo8huOftzMQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
