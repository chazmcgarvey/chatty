package Chatty::Schema::Result::Account;

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

Chatty::Schema::Result::Account

=cut

__PACKAGE__->table("account");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 email

  data_type: 'text'
  is_nullable: 1

=head2 username

  data_type: 'text'
  is_nullable: 1

=head2 password

  data_type: 'text'
  is_nullable: 0

=head2 status

  data_type: 'text'
  default_value: 'active'
  is_nullable: 1

=head2 current_room

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "email",
  { data_type => "text", is_nullable => 1 },
  "username",
  { data_type => "text", is_nullable => 1 },
  "password",
  { data_type => "text", is_nullable => 0 },
  "status",
  { data_type => "text", default_value => "active", is_nullable => 1 },
  "current_room",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint("username_unique", ["username"]);

=head1 RELATIONS

=head2 current_room

Type: belongs_to

Related object: L<Chatty::Schema::Result::Room>

=cut

__PACKAGE__->belongs_to(
  "current_room",
  "Chatty::Schema::Result::Room",
  { id => "current_room" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);

=head2 messages

Type: has_many

Related object: L<Chatty::Schema::Result::Message>

=cut

__PACKAGE__->has_many(
  "messages",
  "Chatty::Schema::Result::Message",
  { "foreign.author" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2011-10-17 20:21:50
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:jbeLiaDPsjHNHj5O11tPFA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
