package Chatty::Form::RoomCreate;

use HTML::FormHandler::Moose;
extends 'HTML::FormHandler::Model::DBIC';
use namespace::autoclean;

has '+item_class' => (default => 'Room');
has '+unique_messages' => (default => sub {
	{name => 'Room name is already taken'};
});

has_field 'name' => (input_class => 'validate[required]', label => 'Room name', required => 1, unique => 1);
has_field 'submit' => (type => 'Submit', value => 'Create');

__PACKAGE__->meta->make_immutable;
1;
