package Chatty::Controller::Root;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller' }

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config(namespace => '');

use JSON 'encode_json';

use Chatty::Form::Login;
use Chatty::Form::Register;

has 'login_form' => (
	isa	=> 'Chatty::Form::Login',
	is	=> 'rw',
	lazy	=> 1,
	default	=> sub { Chatty::Form::Login->new }
);

has 'register_form' => (
	isa	=> 'Chatty::Form::Register',
	is	=> 'rw',
	lazy	=> 1,
	default	=> sub { Chatty::Form::Register->new }
);

=head1 NAME

Chatty::Controller::Root - Root Controller for Chatty

=head1 DESCRIPTION

Implements all actions for this simple chat application.

=head1 METHODS

=head2 index

The root page (/)

=cut

sub index :Path :Args(0) {
	my ($self, $c) = @_;
	$c->go('/chat/list') if ($c->user_exists);
	$c->go('login');
}

=head2 login

Allow a user to login.

=cut

sub login :Local :Args(0) {
	my ($self, $c) = @_;

	$c->stash(form => $self->login_form);
	$self->login_form->process($c->req->params);
	return unless $self->login_form->is_valid;

	eval {
		if ($c->authenticate({
			username => $self->login_form->value->{username},
			password => $self->login_form->value->{password}
		})) {
			$c->change_session_id;
			my $user = $c->user->get('username');
			$c->flash->{message} .= "Hi, $user! You are now logged in.";
			$c->res->redirect($c->uri_for_action('index'));
			return;
		}
		else {
			$c->flash->{error} = "Log-in failed! Try again, I guess.";
			$c->res->redirect($c->uri_for_action('login'));
		}
	};
}

=head2 logout

Log the user out.

=cut

sub logout :Local :Args(0) {
	my ($self, $c) = @_;
	if ($c->user_exists) {
		$c->logout;
		$c->flash->{message} = "Goodbye! You have been logged out.";
	}
	$c->res->redirect($c->uri_for_action('index'));
}

=head2 register

Register a new account.

=cut

sub register :Local :Args(0) {
	my ($self, $c) = @_;

	$c->stash(form => $self->register_form);

	my $new_account = $c->model('DB::Account')->new_result({});
	$self->register_form->process(
		item	=> $new_account,
		params	=> $c->req->params
	);

	if (!$self->register_form->is_valid) {
		if ($c->req->method eq 'POST') {
			$c->stash->{error} = "The form has a validation error. Try again...";
		}
		return;
	}

	$c->flash->{message} = "Registration complete. ";
	$c->forward('login');
}

=head2 register_validate

Check whether or not a username is available.

=cut

sub register_validate :Local :Args(0) {
	my ($self, $c) = @_;

	my $id = $c->req->param('fieldId');
	my $username = $c->req->param('fieldValue');

	my $json_arr = [];

	if ($username) {
		my $account = $c->model('DB::Account')->find({username => $username});
		if (!$account) {
			$json_arr = ["$id", 1, "This username is available. Nice!"];
		}
		else {
			$json_arr = ["$id", 0, "This username is taken."];
		}
	}
	else {
		$json_arr = ["$id", 0, "Invalid arguments to check script."];
	}
	$c->res->content_type("application/json");
	$c->res->body(encode_json($json_arr));
}

=head2 access_denied

Standard 403 error page

=cut

sub access_denied :Private {
	my ($self, $c) = @_;
	$c->res->body('Access denied.');
	$c->res->status(403);
}

=head2 missing

Standard 404 error page

=cut

sub missing :Private {
	my ($self, $c) = @_;
	$c->res->body('Page not found.');
	$c->res->status(404);
}

=head2 default

Standard 404 error page

=cut

sub default :Path {
	my ($self, $c) = @_;
	$c->detach('missing');
}

=head2 end

Attempt to render a view, if needed.

=cut

sub end : ActionClass('RenderView') {}

=head1 AUTHOR

Charles McGarvey

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
