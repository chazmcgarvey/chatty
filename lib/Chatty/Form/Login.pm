package Chatty::Form::Login;

use HTML::FormHandler::Moose;
extends 'HTML::FormHandler';

has_field 'username' => (label => 'Username', required => 1);
has_field 'password' => (type => 'Password', required => 1);
has_field 'submit' => (type => 'Submit', value => 'Login');

no HTML::FormHandler::Moose;
__PACKAGE__->meta->make_immutable;
1;
