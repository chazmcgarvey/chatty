package Chatty::Form::Register;

use HTML::FormHandler::Moose;
extends 'HTML::FormHandler::Model::DBIC';
use namespace::autoclean;

has '+item_class' => (default => 'Account');
has '+unique_messages' => (default => sub {
		{username => 'Username is already registered'};
});

has_field 'username' => (input_class => 'validate[required,ajax[register_validate]]', label => 'Username', required => 1, unique => 1);
has_field 'password' => (input_class => 'validate[required]', type => 'Password', required => 1);
has_field 'password_confirm' => (input_class => 'validate[required,equals[password]]', type => 'PasswordConf', required => 1);
has_field 'submit' => (type => 'Submit', value => 'Register');
has_field 'reset' => (type => 'Reset', value => 'Reset');

__PACKAGE__->meta->make_immutable;
1;
