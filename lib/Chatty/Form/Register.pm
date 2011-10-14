package Chatty::Form::Register;

use HTML::FormHandler::Moose;
extends 'HTML::FormHandler::Model::DBIC';

has '+item_class' => (default => 'Account');

has_field 'username' => (label => 'User Nickname', required => 1, unique => 1);
has_field 'password' => (type => 'Password', required => 1);
has_field 'password_confirm' => (type => 'PasswordConf', required => 1);
has_field 'email' => (type => 'Email', label => 'Email address');
has_field 'submit' => (type => 'Submit', value => 'Register');

has '+unique_messages' => (default => sub {
		{username => 'Username is already registered'};
	});

no HTML::FormHandler::Moose;
__PACKAGE__->meta->make_immutable;
1;
