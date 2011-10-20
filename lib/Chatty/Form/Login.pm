package Chatty::Form::Login;

use HTML::FormHandler::Moose;
extends 'HTML::FormHandler';
use namespace::autoclean;

has_field 'username' => (label => 'Username', required => 1);
has_field 'password' => (type => 'Password', required => 1);
has_field 'submit' => (type => 'Submit', value => 'Login');

__PACKAGE__->meta->make_immutable;
1;
