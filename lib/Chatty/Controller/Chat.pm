package Chatty::Controller::Chat;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller' }

#__PACKAGE__->config(namespace => 'room');

use Chatty::Form::RoomCreate;

has 'roomcreate_form' => (
	isa	=> 'Chatty::Form::RoomCreate',
	is	=> 'rw',
	lazy	=> 1,
	default	=> sub { Chatty::Form::RoomCreate->new }
);

=head1 NAME

Chatty::Controller::Chat - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=head2 room

Base action for chat rooms.  Sets up the model.

=cut

sub room :Chained(/) :CaptureArgs(0) {
	my ($self, $c) = @_;
	$c->detach('/access_denied') if !$c->user_exists;
}

=head2 list

List the current list of chat rooms.

=cut

sub list :Chained(room) :Args(0) {
	my ($self, $c) = @_;

	$c->stash(rooms => [$c->model('DB::Room')->all]);

	my $form = Chatty::Form::RoomCreate->new(action =>
		$c->uri_for_action('/chat/create'));
	$c->stash(form => $form);
}

=head2 create

Create a new chat room.

=cut

sub create :Chained(room) :Args(0) {
	my ($self, $c) = @_;

	$c->stash(form => $self->roomcreate_form);

	my $new_room = $c->model('DB::Room')->new_result({});
	$self->roomcreate_form->process(
		item	=> $new_room,
		params	=> $c->req->params
	);

	if (!$self->roomcreate_form->is_valid) {
		if ($c->req->method eq 'POST') {
			$c->stash->{error} = "The form has a validation error. Try again...";
		}
		return;
	}

	$c->flash->{message} = "Your new room was created!";
	$c->res->redirect($c->uri_for_action('/chat/view', $new_room->id));
}

=head2 view

View a chat room.

=cut

sub view :Chained(room) :PathPart('') :Args(1) {
	my ($self, $c, $room) = @_;

	$c->stash(room => $c->model('DB::Room')->find($room));
	$c->detach('/missing') if !$c->stash->{room};

	my $name = $c->user->obj->username;

	my $msg = $c->req->param('msg');
	if ($msg) {
		$c->model('Meteor')->addMessage($room, "$name: $msg");
		$c->stash->{json} = \1;
		$c->forward('View::JSON');
		return;
	}

	$c->model('Meteor')->addMessage($room, "** $name has entered **");
}

=head1 AUTHOR

Charles McGarvey

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
