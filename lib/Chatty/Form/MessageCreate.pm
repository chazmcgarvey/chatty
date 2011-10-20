package Chatty::Form::MessageCreate;

use HTML::FormHandler::Moose;
extends 'HTML::FormHandler::Model::DBIC';
use namespace::autoclean;

has '+item_class' => (default => 'Message');

has_field 'content' => (input_class => 'validate[required]', label => 'Message', required => 1);
has_field 'submit' => (type => 'Submit', value => 'Create');

__PACKAGE__->meta->make_immutable;
1;
